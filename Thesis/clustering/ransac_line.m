% RANSAC - Robustly fits a model to data with the RANSAC algorithm
%
% Usage:
%
% [Lc, inliers] = ransac(x, fittingfn, distfn, degenfn s, t, feedback, ...
%                       maxDataTrials, maxTrials)
%
% Arguments:
%     x         - Data sets to which we are seeking to fit a model Lc
%                 It is assumed that x is of size [d x Npts]
%                 where d is the dimensionality of the data and Npts is
%                 the number of data points.
%
%     fittingfn - Handle to a function that fits a model to s
%                 data from x.  It is assumed that the function is of the
%                 form:
%                    Lc = fittingfn(x)
%                 Note it is possible that the fitting function can return
%                 multiple models (for example up to 3 fundamental matrices
%                 can be fitted to 7 matched points).  In this case it is
%                 assumed that the fitting function returns a cell array of
%                 models.
%                 If this function cannot fit a model it should return Lc as
%                 an empty matrix.
%
%     distfn    - Handle to a function that evaluates the
%                 distances from the model to data x.
%                 It is assumed that the function is of the form:
%                    [inliers, Lc] = distfn(Lc, x, t)
%                 This function must evaluate the distances between points
%                 and the model returning the indices of elements in x that
%                 are inliers, that is, the points that are within distance
%                 't' of the model.  Additionally, if Lc is a cell array of
%                 possible models 'distfn' will return the model that has the
%                 most inliers.  If there is only one model this function
%                 must still copy the model to the output.  After this call Lc
%                 will be a non-cell object representing only one model.
%
%     degenfn   - Handle to a function that determines whether a
%                 set of datapoints will produce a degenerate model.
%                 This is used to discard random samples that do not
%                 result in useful models.
%                 It is assumed that degenfn is a boolean function of
%                 the form:
%                    r = degenfn(x)
%                 It may be that you cannot devise a test for degeneracy in
%                 which case you should write a dummy function that always
%                 returns a value of 1 (true) and rely on 'fittingfn' to return
%                 an empty model should the data set be degenerate.
%
%     s         - The minimum number of samples from x required by
%                 fittingfn to fit a model.
%
%     t         - The distance threshold between a data point and the model
%                 used to decide whether the point is an inlier or not.
%
%     feedback  - An optional flag 0/1. If set to one the trial count and the
%                 estimated total number of trials required is printed out at
%                 each step.  Defaults to 0.
%
%     maxDataTrials - Lcaximum number of attempts to select a non-degenerate
%                     data set. This parameter is optional and defaults to 100.
%
%     maxTrials - Lcaximum number of iterations. This parameter is optional and
%                 defaults to 1000.
%
% Returns:
%     Lc         - The model having the greatest number of inliers.
%     inliers   - An array of indices of the elements of x that were
%                 the inliers for the best model.
%
% If no solution could be found Lc and inliers are both returned as empty
% matrices and a warning reported.
%
% Note that the desired probability of choosing at least one sample free from
% outliers is set at 0.99.  You will need to edit the code should you wish to
% change this (it should probably be a parameter)
%
% For an example of the use of this function see RANSACFITHOMOGRAPHY or
% RANSACFITPLANE

% References:
%    Lc.A. Fishler and  R.C. Boles. "Random sample concensus: A paradigm
%    for model fitting with applications to image analysis and automated
%    cartography". Comm. Assoc. Comp, Lcach., Vol 24, No 6, pp 381-395, 1981
%
%    Richard Hartley and Andrew Zisserman. "Multiple View Geometry in
%    Computer Vision". pp 101-113. Cambridge University Press, 2001

% Copyright (c) 2003-2013 Peter Kovesi
% Centre for Exploration Targeting
% The University of Western Australia
% peter.kovesi at uwa edu au
% http://www.csse.uwa.edu.au/~pk
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.




function [MSE] = ransac_plop(XY, fittingfn, prop_inliers, feedback)


if nargin < 4; feedback = true;        end;

npts = length(XY);

ninliers = ceil(npts*prop_inliers);% this is the EXACT number of inliers we want our model to have
trialcount = 0;
bestMSE = Inf;
bestLine =[];


for i=1:1000
    inliers = XY(:,rand(npts,[1,2]));
    meanLc = Lcs(:,ind);
    [~, ~, SEs] = allign(meanLc, Lcs);
    [~,I] = sort(SEs);
    inliers = I(1:ninliers);
    [~, MSE, ~] = allign(meanLc, Lcs(:,inliers));   
    
    while MSE < bestMSE
        bestinliers = inliers;
        bestLc = meanLc;
        bestMSE = MSE;
        
        meanLc = feval(fittingfn, Lcs(:,inliers));
        [~, ~, SEs] = allign(meanLc, Lcs);
        [~,I] = sort(SEs);
        inliers = I(1:ninliers);
        [~, MSE, ~] = allign(meanLc, Lcs(:,inliers));
    end
    
    trialcount = trialcount+1;
    if feedback
        fprintf('trial %d out of %d         \r',trialcount, npts);
    end
    
end

if feedback, fprintf('\n'); end

if ~isempty(bestLc)    % We got a solution
    inliers = bestinliers;
    meanLc = bestLc;
    [deltas, MSE,~] = allign(meanLc, Lcs(:,inliers));
else
    inliers = [];
    meanLc = 0;
    deltas = 0;
    MSE = Inf;
    warning('ransac was unable to find a useful solution');
end
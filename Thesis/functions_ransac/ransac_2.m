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
% For an example of the use of this function see RANSACFITHOLcOGRAPHY or
% RANSACFITPLANE

% References:
%    Lc.A. Fishler and  R.C. Boles. "Random sample concensus: A paradigm
%    for model fitting with applications to image analysis and automated
%    cartography". Comm. Assoc. Comp, Lcach., Vol 24, No 6, pp 381-395, 1981
%
%    Richard Hartley and Andrew Zisserman. "Lcultiple View Geometry in
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
%
% Lcay      2003 - Original version
% February 2004 - Tidied up.
% August   2005 - Specification of distfn changed to allow model fitter to
%                 return multiple models from which the best must be selected
% Sept     2006 - Random selection of data points changed to ensure duplicate
%                 points are not selected.
% February 2007 - Jordi Ferrer: Arranged warning printout.
%                               Allow maximum trials as optional parameters.
%                               Patch the problem when non-generated data
%                               set is not given in the first iteration.
% August   2008 - 'feedback' parameter restored to argument list and other
%                 breaks in code introduced in last update fixed.
% December 2008 - Octave compatibility mods
% June     2009 - Argument 'LcaxTrials' corrected to 'maxTrials'!
% January  2013 - Separate code path for Octave no longer needed




%%% Lcodified by Bruno in the following ways :
%%% the first point is always selected as part of ...

function [Lc, inliers] = ransac_2(x, fittingfn, distfn, degenfn, s, thresh, feedback, ...
    maxDataTrials, maxTrials, firstPoint)



if nargin < 10; firstPoint = false;  end;
if nargin < 9; maxTrials = 1000;    end;
if nargin < 8; maxDataTrials = 100; end;
if nargin < 7; feedback = 0;        end;

[~, npts] = size(x);


bestLc = NaN;      % Sentinel value allowing detection of solution failure.
trialcount = 0;
minscore =  10;  % We need at least inliers to consider a model valid
besterror = Inf;
bestinliers = [];

while true
    
    
    if firstPoint
        ind = [1; possonrnd(10,1,s-1)];
    else
        %ind = randsample(npts, s); % skew distribution toward first points?
        ind = min(poissrnd(30), npts);
    end
    Lc = feval(fittingfn, x(:,ind));
    
    
    
    
    
    % Once we are out here we should have some kind of model...
    % Evaluate distances between points and model returning the indices
    % of elements in x that are inliers.  Additionally, if Lc is a cell
    % array of possible models 'distfn' will return the model that has
    % the most inliers.  After this call Lc will be a non-cell object
    % representing only one model.
    [inliers, Lc, error] = feval(distfn, Lc, x, thresh);
    
    % Find the number of inliers to this model.
    ninliers = length(inliers);
    
    while ninliers > minscore && error < ninliers/length(bestinliers)*besterror %will never iterate more than twice
        bestinliers = inliers;
        bestLc = Lc;
        besterror = error;
        
        Lc = feval(fittingfn, x(:,inliers));% Added by Bruno
        [inliers, Lc, error] = feval(distfn, Lc, x, thresh);% Added by Bruno
        ninliers = length(inliers);% Added by Bruno
    end
    
    
    
    trialcount = trialcount+1;
    if feedback
        fprintf('trial %d out of %d         \r',trialcount, maxTrials);
    end
    
    % Safeguard against being stuck in this loop forever
    if trialcount > maxTrials
        warning( ...
            sprintf('ransac reached the maximum number of %d trials',...
            maxTrials));
        break
    end
end

if feedback, fprintf('\n'); end

if ~isnan(bestLc)   % We got a solution
    Lc = bestLc;
    inliers = bestinliers;
else
    Lc = [];
    inliers = [];
    warning('ransac was unable to find a useful solution');
end


function [Lc, Xsel, Fsel, Xfirst, Xunfold] = LSQ_fit_permissive(dist, force, k, min_thresh, sel_thresh, merge_thresh)
% k is the number of lsq+selection steps to apply
% if offset==true, we apply lsq offset optimization
if nargin < 6
    merge_thresh = 10;
end
if nargin < 5
    sel_thresh = 10; end
if nargin < 4
    min_thresh = 12; end

if nargin < 3
    k = 2; end

x0 = 0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins = find_min(dist, force, min_thresh);

%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close too each other
Lc = find_Lc(mins, x0);
Lc = merge_Lc(find_Lc(mins, x0),zeros(1,length(mins)), zeros(1,length(mins)), merge_thresh);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate


for j = 1:k
    %%% We select all the points that we will try to fit
    [Xsel, Fsel, Xfirst, Xunfold] = select_points(dist, force, x0, Lc, sel_thresh);
    
    Lc = lsqcurvefit(@(Lc,x) fd_multi([x0,Lc],x,Xunfold), Lc, Xsel,  Fsel);
    [Lc, Xfirst, Xunfold] = merge_Lc(Lc,Xfirst,Xunfold, merge_thresh);
end
end
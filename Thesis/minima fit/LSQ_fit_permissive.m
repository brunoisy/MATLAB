function [Lc, Xsel, Fsel, Xfirst, Xunfold] = LSQ_fit_permissive(dist, force, k, interval_length, sel_threshlo, sel_threshhi, merge_thresh, mininliers)
% k is the number of lsq+selection steps to apply
if nargin < 8
    mininliers = 5; end
if nargin < merge_thresh
    merge_thresh = 10; end
if nargin < 6
    sel_threshhi = 10; end
if nargin < 5
    sel_threshlo = 10; end
if nargin < 4
    interval_length = 10; end
if nargin < 3
    k = 2; end

x0 = 0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins = find_min(dist, force, interval_length);

%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close too each other
Lc = find_Lc(mins, x0);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate


for j = 1:k
    %%% We select all the points that we will try to fit
    [Xfirst, Xunfold] = select_points(dist, force, x0, Lc, sel_threshlo, sel_threshhi);
    Xsel = [];
    Fsel = [];
    i = 1;
    while(i<=length(Lc))
        ninliers = sum(Xfirst(i)<=dist & dist<=Xunfold(i));
        if ninliers > mininliers
            Xsel = [Xsel, dist(Xfirst(i)<=dist & dist<=Xunfold(i))];
            Fsel = [Fsel, force(Xfirst(i)<=dist & dist<=Xunfold(i))];
        else
            Lc(i:end-1) = Lc(i+1:end);
            Xunfold(i:end-1) = Xunfold(i+1:end);
            Xfirst(i:end-1) = Xfirst(i+1:end);
            Lc = Lc(1:end-1);
            Xunfold = Xunfold(1:end-1);
            Xfirst = Xfirst(1:end-1);
        end
        i=i+1;
    end
    
    if ~isempty(Xsel) && ~isempty(Fsel)
        Lc = lsqcurvefit(@(Lc,x) fd_multi([x0,Lc],x,Xunfold), Lc, Xsel,  Fsel);
        [Lc, Xfirst, Xunfold] = merge_Lc(Lc,Xfirst,Xunfold);
        
        Xsel = [];
        Fsel = [];
        for i = 1:length(Lc)
            Xsel = [Xsel, dist(Xfirst(i)<=dist & dist<=Xunfold(i))];
            Fsel = [Fsel, force(Xfirst(i)<=dist & dist<=Xunfold(i))];
        end
    else
        Lc = [];
    end
end
end
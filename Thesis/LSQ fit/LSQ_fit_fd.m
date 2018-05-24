function [Lc, Xsel, Fsel, Xfirst, Xunfold, x0] = LSQ_fit_fd(dist, force, k, offset, interval_length, sel_thresh, min_inliers, x0)
% k is the number of lsq+selection steps to apply
% if offset==true, we apply lsq offset optimization

if nargin < 8
    x0 = 0; end
if nargin < 7
    min_inliers = 5; end
if nargin < 6
    sel_thresh = 10; end
if nargin < 5
    interval_length = 10; end
if nargin < 4
    offset = false; end
if nargin < 3
    k = 2; end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins = find_min(dist, force, interval_length);

%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close too each other
% Lc = find_Lc(mins, x0);
Lc = merge_Lc(find_Lc(mins, x0),zeros(1,length(mins)), zeros(1,length(mins)));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate


for j = 1:k
    %%% We select all the points that we will try to fit
    [Xfirst, Xunfold] = select_points(dist, force, x0, Lc, sel_thresh, sel_thresh);
    Xsel = [];
    Fsel = [];
    i = 1;
    while(i<=length(Lc))
        ninliers = sum(Xfirst(i)<=dist & dist<=Xunfold(i));
        if ninliers > min_inliers
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
    
    if offset == true
        x0Lc = lsqcurvefit(@(x0Lc,x) fd_multi(x0Lc,x,Xunfold), [x0, Lc], Xsel,  Fsel);
        x0 = x0Lc(1);
        Lc = x0Lc(2:end);
    else
        Lc = lsqcurvefit(@(Lc,x) fd_multi([x0,Lc],x,Xunfold), Lc, Xsel,  Fsel);
    end
    [Lc, Xfirst, Xunfold] = merge_Lc(Lc,Xfirst,Xunfold);
    
    Xsel = [];
    Fsel = [];
    for i = 1:length(Lc)
        Xsel = [Xsel, dist(Xfirst(i)<=dist & dist<=Xunfold(i))];
        Fsel = [Fsel, force(Xfirst(i)<=dist & dist<=Xunfold(i))];
    end
end
% x0 = -x0; % change of convention...
end
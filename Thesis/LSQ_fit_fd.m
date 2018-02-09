function [Lc, Xsel, Fsel, Xfirst, Xunfold] = LSQ_fit_fd(force, dist, k, offset)
% k is the number of lsq+selection steps to apply
% if offset==true, we apply lsq offset optimization

if nargin < 4
    offset = false; end
if nargin < 3
    k = 1; end


x0 = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins = find_min(dist, force);

%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close too each other
Lc = merge_Lc(find_Lc(mins, x0));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate

thresh = 10;% selection threshold


for j = 1:k
    %%% We select all the points that we will try to fit
    [Xsel, Fsel, Xfirst, Xunfold] = select_points(dist, force, x0, Lc, thresh);
    
    if offset == true
        x0Lc = lsqcurvefit(@(x0Lc,x) fd_multi(x0Lc,x,Xunfold), [x0, Lc], Xsel,  Fsel);
        x0 = x0Lc(1);
        Lc = x0Lc(2:end);
    else
        Lc = lsqcurvefit(@(Lc,x) fd_multi([x0,Lc],x,Xunfold), Lc, Xsel,  Fsel);
    end
    [Lc, Xfirst, Xunfold] = merge_Lc(Lc,Xfirst,Xunfold);
end
end
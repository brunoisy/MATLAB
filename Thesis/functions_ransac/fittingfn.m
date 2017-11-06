function [Lc] = fittingfn(XF)
%finds the Fd curve with the lsq error on x

X = XF(1,:);
F = XF(2,:);

Lc = find_Lc(XF(:,end),0);%We intitalize Lc at value for last point
Lc = lsqcurvefit(@fd, Lc, X, F);
if(200 < Lc)
    Lc = [];
end


end


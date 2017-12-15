function [Lc] = fittingfn(XF)
%finds the Fd curve with the lsq error on x

X = XF(1,:);
F = XF(2,:);

if length(X) == 1 % for speed
    Lc = find_Lc(XF, 0);
else
    Lc = 400;
    Lc = lsqcurvefit(@fd, Lc, X, F);
end

end
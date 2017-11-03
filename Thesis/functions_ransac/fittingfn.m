function [Lc] = fittingfn(XF)
%finds the Fd curve with the lsq error on x

X = XF(1,:);
F = XF(2,:);

Lc = 50*10^-9;
Lc = lsqcurvefit(@(Lc,x)10^12*fd(Lc,x), 10^9*Lc, 10^9*X, 10^12*F)/10^9;
if(200*10^-9 < Lc)
    Lc = [];
end


end


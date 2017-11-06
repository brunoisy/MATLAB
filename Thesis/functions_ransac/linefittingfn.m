function [ab] = linefittingfn(XF)
%finds the Fd curve with the lsq error on x

X = XF(1,:);
F = XF(2,:);

ab = polyfit(X,F,1);


end


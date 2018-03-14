function [a, b] = fittingfn_line(XY)
%FITTINGFN_LINE Summary of this function goes here
%   Detailed explanation goes here

X = XY(1,:)
Y = XY(2,:)
[a,b] = regress(Y,X);

end


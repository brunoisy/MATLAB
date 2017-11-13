function [ F ] = fd(Lc, X)
%FD Summary of this function goes here
%   Detailed explanation goes here

load('constants.mat')


%F = -C*(1./(4*(1-X./Lc).^2)-1/4+X./Lc);

F = zeros(1, length(X));
F(X < Lc) =  -C*(1./(4*(1-X(X<Lc)./Lc).^2)-1/4+X(X<Lc)./Lc);
F(X >= Lc) = -1000000; % this is -infinity (cannot be -Inf for lsqcurvefit to work)

end
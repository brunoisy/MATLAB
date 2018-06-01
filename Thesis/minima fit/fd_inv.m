function [ X ] = fd_inv(Lc, F)
%FD Summary of this function goes here
%   Detailed explanation goes here

load('constants.mat')

X = zeros(1,length(F));
for i = 1:length(F)
    A = 4*F(i)/C;
    p = [A, 2*Lc*(3-A), -Lc^2*(9-A), 4*Lc^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    
    X(i) = real(thisroots(2));% why 2? seems to work...
end


end
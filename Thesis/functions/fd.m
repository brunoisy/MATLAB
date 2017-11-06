function [ F ] = fd(Lc, X)
%FD Summary of this function goes here
%   Detailed explanation goes here

load('constants.mat')
F = -kb*T/lp*(1./(4*(1-X./Lc).^2)-1/4+X./Lc);

end
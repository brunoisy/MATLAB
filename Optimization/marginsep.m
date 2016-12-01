function [h, c, tau] = marginsep(pa, pb)
% Find a maximum margin separating hyperplane betweens sets of points pa et pb
% (data points are arranged as columns in matrices pa and pb)
% Model: min t s.t. h^T ai + c <= -1, h^t bi + c >= 1 and norm(h) <= t
% (alternative model: max t s.t. h^T ai + c <= -t, h^t bi + c >= t and norm(h) <= 1)

n = size(pa, 1);
na = size(pa, 2);
nb = size(pb, 2);


A = [[ones(na+nb,1), [ones(na,1);-ones(nb,1)], [pa';-pb']];zeros(1,2+n);[zeros(n,2),-eye(n)]];
c = [zeros(na+nb,1);1;zeros(n,1)];
b = [1;0;zeros(n,1)];
K.f = 0;
K.l = na + nb;
K.q = n+1;

[x,y,info]=sedumi(A, b, c, K);
h = y(3:n+2);
c = y(2);
% tau = ...
% if ...
%     disp('There exists no separating hyperplane');
%     h = []; c = [];
% else
%     disp(['Separating hyperplane: margin=' num2str(tau,3) ' ; h=' mat2str(h,3) ' ; c=' num2str(c,3)]);
% end

function [newX ] = updatePart( X)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

delta = 0.5;
alpha = 0.6;
phi_tild = [1,delta,delta^2/2; 0,1,delta; 0,0,alpha];
psi_z_tild = [delta^2/2; delta; 0];
psi_w_tild = [delta^2/2; delta; 1];
phi = [phi_tild,zeros(3,3); zeros(3,3),phi_tild];
psi_z = [psi_z_tild,zeros(3,1); zeros(3,1),psi_z_tild];
psi_w = [psi_w_tild,zeros(3,1); zeros(3,1),psi_w_tild];
Zvalues = [0,3.5,0,0,-3.5; 0,0,3.5,-3.5,0];
sigmaW = 0.5;

s = size(X);
N = s(2);
newX = zeros(s);
% for i=1:N %vectorise
%     newX(1:6,i) = phi*X(1:6,i) + psi_z*X(7:8,i) + psi_w*randn(2,1)*sigmaW;
%     newX(7:8,i) = datasample([Zvalues'; X(7:8,i)'], 1, 'Weights', [1 1 1 1 1 15]);
% end


newX(1:6,:) = phi*X(1:6,:) + psi_z*X(7:8,:) + psi_w*randn(2,N)*sigmaW;
size(repmat(Zvalues,N,1))
size(X(7:8,:)')
%newX(7:8,:) = datasample([repmat(Zvalues',1,N); reshape(X(7:8,:),1,2*N)], 1, 'Weights', [1 1 1 1 1 15]);
newX(7:8,:) = datasample([repmat(Zvalues',N,1), X(7:8,:)'], 1, 'Weights', [1 1 1 1 1 15])';

end


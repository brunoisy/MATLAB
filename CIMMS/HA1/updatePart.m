function [newX ] = updatePart(X)
% in  : X is an 8xN matrix where each column represents a particle
% out : newX is an 8xN matrix where each column represents a particle drawn
% from the transition density


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

newX = X;
N = length(X(1,:));

newX(1:6,:) = phi*X(1:6,:) + psi_z*X(7:8,:) + psi_w*randn(2,N)*sigmaW;
inds = randi(20,1,N);
newX(7:8,inds<6) = Zvalues(:,inds(inds<6));

end


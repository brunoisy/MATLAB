function E = ellisep(pa, pb, center)
% Find an ellipsoidal separation betweens sets of points pa et pb
% (data points are arranged as columns in matrices pa and pb)
% If center is not provided, ellipsoids are centered at the origin
% Model: max 0 t.q. ai^T E ai <= 1 et bi^T E bi >= 1
% (or the primal formulation: min 0 <E, ai ai^T> + si = 1  et  <E, bi bi^T> - s'i = 1)

n = size(pa, 1);
na = size(pa, 2);
nb = size(pb, 2);
if nargin < 3
    center = zeros(n, 1);
end

pa = reshape(pa'*pa,1,na^2);
pb = reshape(pb'*pb,1,nb^2);
A = [pa;-pb];

b = zeros(na^2+nb^2,1);
c = [ones(na,1);-ones(nb,1)];
K.s = na+nb;
[x,y,info]=sedumi(A, b, c, K); 
% E = ...
% if ...
%     disp(['There exists no separating ellipsoid centered at c=' mat2str(center)]);
%     E = []; 
% else
%     disp(['Separating ellipsoid centered at ' mat2str(center) ': E=' mat2str(E,3)]);
% end

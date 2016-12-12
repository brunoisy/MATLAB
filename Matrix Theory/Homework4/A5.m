% A=1/4;
% [U,S,V] = svd(1-A);
% delta = U(:,end)*min(diag(S))*V(:,end)'

A=[1/4,3; 0,1/4];
[U,S,V] = svd(eye(2)-A);
delta = U(:,end)*min(diag(S))*V(:,end)'
eig(A+delta)
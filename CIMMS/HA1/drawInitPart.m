function X = drawInitPart(N)


Zvalues = [0,3.5,0,0,-3.5; 0,0,3.5,-3.5,0];
sigmaX0 = diag(sqrt([500,5,5,200,5,5]));

X = zeros(8,N); % Xtilde
X(1:6,:) = randn(6,N);
for i=1:6
    X(i,:) = X(i,:)*sigmaX0(i,i);
end
X(7:8,:) = Zvalues(:,randi(5,1,N));

end


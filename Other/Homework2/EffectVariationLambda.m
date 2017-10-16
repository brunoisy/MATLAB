load('Data-Homework-2.mat')
A = data.A;
b = data.b;
x0 = data.x0;
epsilon = 0.01;
fOptimal = 23.673;

N = 500; % default number of iterations
lambdavec = [0, 0.0001, 0.001, 0.01 1];

n = length(lambdavec);

f = @(x)norm(A*x-b)^2+lambda*norm(x,1);

nbrzero = zeros(n,1);
for i = 1:n
	lambda = lambdavec(i);
	x = proximalGradientAcc(A, b, lambda, x0, N, epsilon);
    nbr = 500-length(find(x(:,end)~=0));
    nbrzero(i,1) = nbr;
end	

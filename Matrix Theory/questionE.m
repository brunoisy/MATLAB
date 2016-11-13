w0 = [0; 0; 0];
alpha = 0.1;
N = 100;
wRef = [0; 0; 1];
C = [1, 0, 0; 1, 1, 0; 0, 1, 1];
D = [1, 0, 0];
% C is A and D is B from excercise E (to avoid confusion with A and b from
% canonical formulation of the problem)

M = 4*N+3;% number of variables

A = eye(3*N+3,M);% sparse?
for i=1:N
    A(1+3*i:3+3*i,1+3*(i-1):3*i) = -C;
    A(1+3*i:3+3*i,3*N+3+i) = -D;
end
b = zeros(3*N+3,1);

xRef = zeros(M,1);
for i=1:N+1
    xRef(1+3*(i-1):3+3*(i-1)) = wRef;
end

Q = sparse(M,M);
Q(1:M+1:M*(3*N+3)) = 2;
Q(M*(3*N+3)+3*N+4:M+1:M*M) = 2*alpha;
Qnorm = @(x) 1/2*x'*Q*x;

 
%Optimal solution
xOpti = xRef + Q\(A'*pinv(A*inv(Q)*A')*(b-A*xRef));

figure
hold on
%Approximate solution
for d = [10, 20, 40, 80, 160]
    iter = 300;% QUESTION E2 --> how many iterations? this is not N!
    x = zeros(M, iter);
    x(:,1) = xRef; % initial iterate?
    deltaX = zeros(1, iter);
    deltaX(1) = Qnorm(xOpti-xRef);
    for k = 1:iter-1
        S = randi([0,1],3*N+3,d);
        x(:,k+1) = x(:,k) - Q\(A'*S*pinv(S'*A*inv(Q)*A'*S)*S'*(A*x(:,k)-b)); %RP
        deltaX(k+1) = Qnorm(xOpti-x(:,k+1));
    end
    plot(1:iter,deltaX);
end
xlabel('iterations')
ylabel('1/2(x-xOptimal)^T*Q*(x-xOptimal)')
legend('d=10','d=20','d=40','d=80','d=160');



% %Optimal solution
% 
% xOpti = xRef + Q\(A'*pinv(A*inv(Q)*A')*(b-A*xRef));
% 
% %Approximate solution
% n = 3;
% d = [300 350 403];
% execTimes  = zeros(1,n);
% epsilon = 0.001;
% for i = 1:n
%     tic; % begin timer
%     x = xRef;
%     deltaX = Qnorm(xOpti-x);
%     while deltaX > epsilon
%         S = randi([0,1],3*N+3,d(i));
%         x = x - Q\A'*S*pinv(S'*A*inv(Q)*A'*S)*S'*(A*x-b); %RP
%         deltaX = Qnorm(xOpti-x);
%     end
%     execTimes(i) = toc;
% end
% 
% figure
% hold on
% bar(execTimes);
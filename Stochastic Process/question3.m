% you need to create folder 'images_q3' in current directory

% sequential_monte_carlo_simple_02PA.m - Started Thu 30 Apr 2015

%   This Matlab script implements a Sequential Monte Carlo (SMC) method for
%   a simple nonlinear dynamical system.
%
%
%   Reference: Computational Methods in Statistics, Anuj Srivastava, August
%   24, 2009, http://stat.fsu.edu/~anuj/pdf/classes/CompStatII10/BOOK.pdf
%   See in particular problem 3 of section 10.5.


% ** Let us define the dynamical system using the following model:
% x_{t+1} = F(x_t) + Gamma u_t
% y_t = G(x_t) + w_t.
% where x_t in R^m, y_t in R^p,
% x_0 = [1 1 1 1]%MODIFIED

rng(3);
sigmaA = 0.1;%MODIFIED
sigmaTheta = 0.1;%MODIFIED
T = 0.5;%MODIFIED


t_f = 2e2;   % final time. Sugg: 1e2
d_x = 4;%MODIFIED  % dimension of state space; must be 1 in this script
d_y = 1;  % dimension of output space; must be 1 in this script
d_u = 2;%MODIFIED  % dimension of u; must be 1 in this script

Fmatrix = [1,0,T,0; 0,1,0,T; 0,0,1,0; 0,0,0,1];%MODIFIED
F = @(x) Fmatrix*x;%MODIFIED  % choice of the function F for the dynamical system
Gamma = [T*T/2,0; 0,T*T/2; T,0; 0,T];%MODIFIED
G = @(x) atan2(x(1),x(2));%MODIFIED  % choice of output function G. Sugg: identity function

mu_u = 0;
mu_w = 0;


out_noise_pdf = @(w) 1/sqrt((2*pi)^d_y*abs(det(sigmaTheta^2))) * exp(-.5*(w-mu_w)'*inv(sigmaTheta^2)*(w-mu_w));  % pdf of the output noise w_t

% ** Simulation: Generate y_t, t=0,..,t_f, that will be used as the
% observations in the SMC algorithm.

x_true = zeros(d_x,t_f +1);  % allocate memory
y_true = zeros(d_y,t_f +1);  % allocate memory

x_true(:,0 +1) = [1 1 1 1];%MODIFIED  % set true initial state
for t = 0:t_f-1
    u_true = mu_u + sigmaA * randn(d_u,1);
    x_true(:,t+1 +1) = F(x_true(:,t +1)) + Gamma * u_true;
    w_true = mu_w + sigmaTheta * randn(d_y,1);
    y_true(:,t +1) = G(x_true(:,t +1)) + w_true;
end
w_true = mu_w + sigmaTheta * randn(d_y,1);  % noise on the output at final time t_f
y_true(:,t_f +1) = G(x_true(:,t_f +1)) + w_true;  % output at final time t_f


% *** SEQUENTIAL MONTE CARLO METHOD ***

n = 5000;  % sample set size. Sugg: 1e2
X = cell(n,t_f +1);   % particles will be stored in X
Xtilde = cell(n,t_f +1);  % to store the predictions

% ** Generate initial sample set {x_0^i,...,x_0^n}:

t = 0;
for i = 1:n
    X{i,t +1} = [1; 1; 1; 1]; % we sample from the distribution of x_0
end

% ** Start loop on time:

for t = 0:t_f-1
    
    % ** Prediction
    
    for i = 1:n
        u = mu_u + sigmaA * randn(d_u,1);
        Xtilde{i,t+1 +1} = F(X{i,t +1}) + Gamma * u;
    end
    
    
    % ** Correction
    
    y = y_true(:,t+1 +1);  % y is the true output at time t+1
    
    weights = zeros(1,n);
    for i=1:n
        weights(i) = out_noise_pdf(y-G(Xtilde{i,t+1 +1}));
    end
    
    % Resample the particles according to the weights:
    if exist('OCTAVE_VERSION') == 0
        % We are using Matlab
        ind_sample = randsample(n,n,true,weights);
    else
        % We are using Octave
        weights_tilde = weights / sum(weights);  % make the weights sum to 1
        [dummy,ind_sample] = histc(rand(n,1),[0 cumsum(weights_tilde)]);
    end
    
    for i=1:n
        X{i,t+1 +1} = Xtilde{ind_sample(i),t+1 +1};
    end
    
end  % for t


%%%%%%%%%%%%%%%%%%%%%%%%%

Xmat = cell2mat(X);

Xpos = Xmat(1:4:n*4,:);
Ypos = Xmat(2:4:n*4,:);

Xmean = zeros(1,t_f+1); %mean of the n iterations at each time
for i = 1:t_f+1
    Xmean(i) = mean(Xpos(:,i));
end
Ymean = zeros(1,t_f+1);
for i = 1:t_f+1
    Ymean(i) = mean(Ypos(:,i));
end

%PLOTTING
for k=[1 50 100 200]
    figure
    hold on
    title(strcat('histogram of positions x at k=',num2str(k)));
    histogram(Xpos(:,k+1));
    xlabel('position x')
    ylabel('number of stimulations')
    saveas(gcf,strcat('images_q3/x_at_k_',num2str(k),'.jpg'));
    
    figure
    hold on
    title(strcat('histogram of positions y at k=',num2str(k)));
    histogram(Ypos(:,k+1));
    xlabel('position y')
    ylabel('number of stimulations')
    saveas(gcf,strcat('images_q3/y_at_k_',num2str(k),'.jpg'));
    
    figure
    hold on
    title(strcat('trajectory at k=',num2str(k)));
    plot(x_true(1,1:(k+1)),x_true(2,1:(k+1)),'*');
    plot(Xmean(1:k+1),Ymean(1:k+1),'*');
    xlabel('x-axis')
    ylabel('y-axis')
    legend('real trajectory', 'estimated trajectory')
    saveas(gcf,strcat('images_q3/trajectory_at_k_',num2str(k),'.jpg'));
end


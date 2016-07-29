% you need to create folder 'images_q4' in current directory

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


load('data.mat');


T = 1;

t_f = 25;  % final time. Sugg: 1e2
d_x = 4;  % dimension of state space;
d_y = 1;  % dimension of output space;
d_u = 2;  % dimension of u;

Fmatrix = [1,0,T,0; 0,1,0,T; 0,0,1,0; 0,0,0,1];
F = @(x) Fmatrix*x;  % choice of the function F for the dynamical system
Gamma = [T^2/2,0; 0,T^2/2; T,0; 0,T];
h = @(x) atan2(x(1),x(2));  % choice of output function G.


sigma_r = sqrt(0.1);
sigma_thet = 0.01;% variance of the noise on the measured bearing angle
sigma_s = sqrt(0.1);
sigma_c = sqrt(0.1);
mu_u = 0;
sigma_u = 0.001;
mu_w = 0;




out_noise_pdf = @(w) 1/sqrt((2*pi)^d_y*abs(det(sigma_thet^2))) * exp(-.5*(w-mu_w)'*inv(sigma_thet^2)*(w-mu_w));  % pdf of the output noise w_t


obs_velocity = zeros(2, t_f+1);%last velocity considered equal to second-to-last-velocity
for t=1:t_f
    obs_velocity(:,t) = (observer(:,t+1) - observer(:,t))/T;
end
obs_velocity(:,t_f+1)=obs_velocity(:,t_f);






% *** SEQUENTIAL MONTE CARLO METHOD ***

n = 5000; %TOMODIFY  % sample set size. Sugg: 1e2
X = cell(n,t_f +1);   % particles will be stored in X
Xtilde = cell(n,t_f +1);  % to store the predictions

% ** Generate initial sample set {x_0^i,...,x_0^n}


t = 0;
for i = 1:n
    r_ev = r + sigma_r*randn(1,1); % random distance evaluated from the initial distribution
    theta_ev = theta + sigma_thet*randn(1,1);
    s_ev = s + sigma_s*randn(1,1);
    c_ev = c + sigma_c*randn(1,1);
    X{i,t +1} = [r_ev*sin(theta_ev); r_ev*cos(theta_ev); s_ev*sin(c_ev)-obs_velocity(1,1) ; s_ev*cos(c_ev)-obs_velocity(2,1)];
    % we sample from the distribution of x_0
end

% ** Start loop on time:


for t = 0:t_f-1
    U = [T/2*(obs_velocity(:,t+2)-obs_velocity(:,t+1)); obs_velocity(:,t+2)-obs_velocity(:,t+1)];%mal placé

    % ** Prediction
    for i = 1:n
        u = mu_u + sigma_u * randn(d_u,1);
        Xtilde{i,t+1 +1} = F(X{i,t +1}) - U + Gamma * u;
    end
    
    
    % ** Correction
    
    y = measurements(t+1 +1);  % y is the true output at time t+1
    
    weights = zeros(1,n);
    for i=1:n
        weights(i) = out_noise_pdf(y-h(Xtilde{i,t+1 +1}));
    end

    
    ind_sample = randsample(n,n,true,weights);
    
    
    for i=1:n
        X{i,t+1 +1} = Xtilde{ind_sample(i),t+1 +1};
    end
    
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%


targ_velocity = zeros(2, t_f+1);%last velocity considered equal to second-to-last velocity
for t=1:t_f
    targ_velocity(:,t) = (target(:,t+1) - target(:,t))/T;
end
targ_velocity(:,t_f+1)=targ_velocity(:,t_f);



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

part_bef_res = cell2mat(Xtilde);
part_aft_res = Xmat;

%PLOTTING
for k = [1 2 3 15 26];
    figure
    subplot(1,2,1)
    title('real and estimated trajectory of alpha');
    hold on
    if k==1
        % do nothing --> we haven't used monte carlo yet
    else
        plot(part_bef_res(1:4:4*n,k-1)+observer(1,k),part_bef_res(2:4:4*n,k-1)+observer(2,k),'*')
        plot(part_aft_res(1:4:4*n,k)+observer(1,k),part_aft_res(2:4:4*n,k)+observer(2,k),'*')
    end
    
    plot(observer(1,1:k), observer(2,1:k),'*');
    plot(target(1,1:k), target(2,1:k),'*');
    plot(observer(1,1:k)+Xmean(1:k), observer(2,1:k)+Ymean(1:k),'*');
    if k==1
        legend('beta','alpha','estimated alpha')
    else
        legend('particle position before res','particle position after res','beta','alpha','estimated alpha')
    end
    xlabel('x');
    ylabel('y');
    
    subplot(1,2,2)
    hold on
    title('real and estimated velocity of alpha');
    if k==1
        % do nothing --> we haven't used monte carlo yet
    else
        plot(part_bef_res(3:4:4*n,k-1)+obs_velocity(1,k),part_bef_res(4:4:4*n,k-1)+obs_velocity(2,k),'*')
        plot(part_aft_res(3:4:4*n,k)+obs_velocity(1,k),part_aft_res(4:4:4*n,k)+obs_velocity(2,k),'*')
    end
    
    plot(targ_velocity(1,k),targ_velocity(2,k), '*k');
    if k==1
        legend('velocity of alpha')
    else
        legend('particle speed before res','particle speed after res','velocity of alpha')
    end
    
    xlabel('x-speed');
    ylabel('y-speed');
    saveas(gcf,strcat('images_q4/k_',num2str(k),'.jpg'))
end

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
G = @(x) atan2(x(1),x(2));  % choice of output function G.


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
    
    % ** Prediction
    U = [T/2*(obs_velocity(:,t+2)-obs_velocity(:,t+1)); obs_velocity(:,t+2)-obs_velocity(:,t+1)];
    for i = 1:n
        u = mu_u + sigma_u * randn(d_u,1);
        Xtilde{i,t+1 +1} = F(X{i,t +1}) - U + Gamma * u;
    end
    
    
    % ** Correction
    
    y = measurements(t+1 +1);  % y is the true output at time t+1
    
    weights = zeros(1,n);
    for i=1:n
        weights(i) = out_noise_pdf(y-G(Xtilde{i,t+1 +1}));
    end

    
    ind_sample = randsample(n,n,true,weights);
    
    
    for i=1:n
        X{i,t+1 +1} = Xtilde{ind_sample(i),t+1 +1};
    end
    
    
end  % for t


%%%%%%%%%%%%%%%%%%%%%%%%%


targ_velocity = zeros(2, t_f+1);%last velocity considered equal to second-to-last velocity
for t=1:t_f
    targ_velocity(:,t) = (target(:,t+1) - target(:,t))/T;
end
targ_velocity(:,t_f+1)=targ_velocity(:,t_f);



Xmat = cell2mat(X);
Xpos = Xmat(1:4:n*4,:);
Ypos = Xmat(2:4:n*4,:);



%%%%%%%%% CRLB computing

CRLB = zeros(1,t_f+1);
RMS = zeros(1,t_f+1);
J = cell(1,t_f+1);


rel_pos = zeros(2,t_f+1);
rel_vel = zeros(2,t_f+1);
for k=1:t_f+1
    rel_pos(:,k) = target(:,k)-observer(:,k);
end
for k=1:t_f
    rel_vel(:,k)=(rel_pos(:,k+1)-rel_pos(:,k))/T;
end
rel_vel(:,t_f+1)=rel_vel(t_f);


real_x = [rel_pos; rel_vel];


Pxx = (r*sigma_thet*cos(theta))^2 + (sigma_r*sin(theta))^2;
Pyy = (r*sigma_thet*sin(theta))^2 + (sigma_r*cos(theta))^2;
Pxy = (sigma_r^2 - (r*sigma_thet)^2)*sin(theta)*cos(theta);
PxxDot = (s*sigma_c*cos(c))^2 + (sigma_s*sin(c))^2;
PyyDot = (s*sigma_c*sin(c))^2 + (sigma_s*cos(c))^2;
PxyDot = (sigma_s^2 - (s*sigma_c)^2)*sin(c)*cos(c);
C = [Pxx, Pxy; Pxy, Pyy];
CDot = [PxxDot, PxyDot; PxyDot, PyyDot];
P1 = [C, zeros(2,2); zeros(2,2), CDot];

J{1} = inv(P1);



% hGrad = @(x) [x(1)*x(2)/(sqrt(x(1)^2/(x(1)^2+x(2)^2))*(x(1)^2+x(2)^2)^(3/2)), 0, 0, 0;
%     0, -sqrt(x(1)^2/(x(1)^2+x(2)^2))/sqrt(x(1)^2+x(2)^2), 0, 0;
%     0, 0, 0, 0;
%     0, 0, 0, 0;];


hGrad = @(x) [x(1)*x(2)/(sqrt(x(1)^2/(x(1)^2+x(2)^2))*(x(1)^2+x(2)^2)^(3/2));
    -sqrt(x(1)^2/(x(1)^2+x(2)^2))/sqrt(x(1)^2+x(2)^2);
    0;
    0];

for k = 1:t_f
    Hk1 = hGrad(real_x(:,k+1));
    J{k+1} = inv(Fmatrix)'*(J{k}/Fmatrix) + Hk1*Hk1'/sigma_thet^2;
end


for k=1:t_f+1
    invJk = inv(J{k});
    CRLB(k)= sqrt(invJk(1,1)+invJk(2,2));
    RMS(k) = sqrt(1/n*sum((Xpos(:,k)-real_x(1,k)).^2+(Ypos(:,k)-real_x(2,k)).^2));
end

figure
hold on
plot(1:t_f+1, CRLB,'*')
plot(1:t_f+1, RMS,'*')
legend('CRLB of RMS', 'RMS');
xlabel('time')
ylabel('RMS')
saveas(gcf,strcat('images_q6/CRLB.jpg'))



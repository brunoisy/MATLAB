% Simply call 
%
%       >> double_pendulum_init
%
% to run the double pendulum simulation with the below parameters. This
% script calls double_pendulum.
%
%   ---------------------------------------------------------------------

phi1                = pi;
dtphi1              = 0;
phi2                = pi + 10^-4;
dtphi2              = 0;
g                   = 9.81; 
m1                  = 1; 
m2                  = 1; 
l1                  = 0.3;
l2                  = 0.5;
duration            = 100;
fps                 = 50;
movie               = false;

clc; figure;

interval=[0, duration];
ivp=[phi1; dtphi1; phi2; dtphi2; g; m1; m2; l1; l2];

double_pendulum(ivp, duration, fps, movie); % utiliser si test CI
%double_pendulum2(ivp, duration, fps, movie); % utiliser si test topologiquement stable
function double_pendulum(ivp, duration, fps, movie)
% DOUBLE_PENDULUM Animates the double pendulum's (mostly) chaotic behavior.
%
%   author:  Alexander Erlich (alexander.erlich@gmail.com)
%
%   parameters:
%   
%   ivp=[phi1; dtphi1; phi2; dtphi2; g; m1; m2; l1; l2]
%
%                               Initial value problem. phi1 and dtphi1 are
%                               the initial angle and anglular velocity. g
%                               is gravity, m1 and l1 mass and rod length.
%                               For an explaining picture, see
%                               documentation file in same folder.
%  
%   duration                    The time interval on which the ode is
%                               solved spans from 0 to duration (in sec).
%
%   fps                         Frames Per Second. The framerate is
%                               relevant both for normal (realtime)
%                               animation and movie recording.
%
%   movie                       If false, a normal realtime animation of
%                               the motion of the double pendulum (the 
%                               framerate being fps) is shown.
%                               If true, a movie (.avi) is recorded. The
%                               filename is 'doublePendulumAnimation.avi'
%                               and the folder into which it is saved is
%                               the current working directory.
%
%   This function calls double_pendulum_ODE and is, in turn, called by
%   double_pendulum_init.
%
%   Example call:    >> double_pendulum([pi;0;pi;5;9.81;1;1;2;1],100,10,false)
%   Or, simply call  >> double_pendulum_init
%
%   ---------------------------------------------------------------------

clear All; clf;

nframes=duration*fps;
%sol=ode45(@double_pendulum_ODE,[0 duration], ivp);
t = linspace(0,duration,nframes);
%y=deval(sol,t);
h = 1/fps;
n = duration*fps;
jacobF = matlabFunction(jacF(h));

[theta, ptheta] = euler_implicite([ivp(1); ivp(3)], [ivp(2); ivp(4)], n, h, jacobF);
phi1=theta(1,:)'; dtphi1=ptheta(1,:)';
phi2=theta(2,:)'; dtphi2=ptheta(2,:)';
[theta2, ptheta2] = euler_implicite([ivp(1)+10^-1; ivp(3)], [ivp(2); ivp(4)], n, h, jacobF);
phi21=theta2(1,:)'; dtphi21=ptheta2(1,:)';
phi22=theta2(2,:)'; dtphi22=ptheta2(2,:)';
% phi1=y(1,:)'; dtphi1=y(2,:)';
% phi2=y(3,:)'; dtphi2=y(4,:)';
l1=ivp(8); l2=ivp(9);

z=plot(0,0,'MarkerSize',30,'Marker','.','LineWidth',2);
hold on;
h=plot(0,0,'MarkerSize',30,'Marker','.','LineWidth',2);


range=1.1*(l1+l2); axis([-range range -range range]); axis square;
set(gca,'nextplot','replacechildren');

    for i=1:length(phi1)-1
        if (ishandle(h)==1)
            Xcoord=[0,l1*sin(phi1(i)),l1*sin(phi1(i))+l2*sin(phi2(i))];
            Ycoord=[0,-l1*cos(phi1(i)),-l1*cos(phi1(i))-l2*cos(phi2(i))];
            set(h,'XData',Xcoord,'YData',Ycoord);
            Xcoord2=[0,l1*sin(phi21(i)),l1*sin(phi21(i))+l2*sin(phi22(i))];
            Ycoord2=[0,-l1*cos(phi21(i)),-l1*cos(phi21(i))-l2*cos(phi22(i))];
            set(z,'XData',Xcoord2,'YData',Ycoord2);

            drawnow;
            F(i) = getframe;
            if movie==false
                pause(t(i+1)-t(i));
            end
        end
    end
    if movie==true
        movie2avi(F,'doublePendulumAnimation.avi','fps',fps)
    end
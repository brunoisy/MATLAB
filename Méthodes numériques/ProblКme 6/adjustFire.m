function [theta] = adjustFire(y0,v0,epsilon,h,f,bonus)
% adjustFire - this MATLAB function finds the angle theta to maximize the
% distance of fire, for a unimodal function f having initial conditions y0 and v0,
% a tolerated uncertainty of epsilon on the final angle, and a length h for 
% the integration

% BRUNO DEGOMME
% 39721300

thetaMin = 0;
thetaMax = 90;

while abs(thetaMax - thetaMin) > 2*epsilon
    b=thetaMin+(thetaMax-thetaMin)/3;
    c=thetaMin+(thetaMax-thetaMin)*2/3;
    distc=HeunIntegrate(c,y0,v0,h,f);
    distb=HeunIntegrate(b,y0,v0,h,f);
    if distc<distb
        thetaMax=c;
        distMax=distb;
    else
        thetaMin=b;
        distMax=distc;
    end
    
    subplot(2,1,2);
    plot([thetaMin thetaMin],[0,300],'-r'); hold on;
    plot([thetaMax thetaMax],[0,300],'-r'); hold on;
    
    fprintf('==== New interval is [%f, %f]\n',thetaMin,thetaMax);
    fprintf('     Distance = %f : error = %f\n',distMax,thetaMax - thetaMin);
    %        input('      Press any key to do next iteration \n');
end

theta = (thetaMin + thetaMax) / 2;

end


function [distance] = HeunIntegrate(theta,y0,v0,h,f)

global shot

U(1) = v0*cosd(theta);
U(2) = 0;
U(3) = v0*sind(theta);
U(4) = y0;


while U(4)>0
    K1=f(U);
    K2=f(U+h*K1);
    U=U+h/2*(K1+K2);
    subplot(2,1,1);
    plot(U(2), U(4)); hold on;
end

T=U(4)/U(3); % temps de trop
U(2)=U(2)-T*U(1);

distance  = U(2);
subplot(2,1,2);
fprintf('Angle = %f : Distance = %f\n',theta,distance);
plot(theta,distance,'.b','MarkerSize',30); hold on;
shot = shot + 1;

end

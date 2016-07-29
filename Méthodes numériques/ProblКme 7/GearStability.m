function [alpha] = GearStability(x,y,n)
% gearStability - this MATLAB function returns the modulus of the
% amplification factor of every point h? of the complex plane for the gear 
% method, given the real an imaginary points of these values in matrixs x 
% and y of same size. n is the order of the considered Gear method, and mus
% be compromised between 0 and 7

% Bruno Degomme 3972 13 00
    z = x+1i*y;
    alpha = z;   % pre-allocation de alpha :-)
    for k=1:size(z,1)
        for l =1:size(z,2)
            if n==1
                c = [(z(k,l) -1) 1 0];
            elseif n==2
                c = [(z(k,l)*2 -3) 4 -1];
            elseif n==3  
                c = [(z(k,l)*6 -11)  18 -9  2];
            elseif n==4
                c = [(z(k,l)*12 -25) 48 -36 16 -3];
            elseif n==5
                c = [(z(k,l)*60 -137) 12 -75 200 -300 300];
            elseif n==6
                c = [(z(k,l)*60 -147) -10 72 -225 400 -450 360];
            end
            
            r = roots(c);
            alpha(k,l) = max(abs(r));
        end
    end
end
 
function [rendement] = GetRendement(T,P)

R=8.314;


H.H2=29.3*(T-298.15)-0.83*10^-3*((T^2-298.15^2)/2)+2.09*10^-6*((T^3-298.15^3)/3);
H.N2=27.62*(T-298.15)+4.19*10^-3*(T^2-298.15^2);
H.NH3=-45.91*10^3+31.81*(T-298.15)+15.48*10^-3*(T^2-298.15^2)+5.86*10^-6*(T^3-298.15^3);

S.H2=130.68+29.3*log(T/298.15)-0.83*10^-3*(T-298.15)+2.09*10^-6*((T^2-298.15^2)/2);
S.N2=191.32+27.62*log(T/298.15)+4.19*10^-3*(T-298.15);
S.NH3=192.66+31.81*log(T/298.15)+15.48*10^-3*(T-298.15)+5.86*10^-6*(T^2-298.15^2);

deltaH=2*H.NH3-3*H.H2-H.N2;
deltaS=2*S.NH3-3*S.H2-S.N2;      
deltaG=deltaH-T*deltaS;
K=exp(-deltaG/(8.314*T));

syms x positive a positive;
Ptot=symfun((4*x-2*a)*R*T,[x a]);
Q=symfun(4/27*a^2*(4*x-2*a)^2/(x-a)^4*(100000/P)^2,[x a]);
[solution_x, solution_a]=solve(Q==K,Ptot==P,x,a);

rendement=solution_a(1)/solution_x(1);
%rendement2=solution_a(2)/solution_x(2)

end


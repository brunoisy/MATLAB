function [mCH4tot] = AmmoniacFactoryForAnalyseParam(masseAmmoniac,temp)
R=8.314;

H.CH4=-74.81*10^3+14.23*(temp-298.15)+75.3*10^-3*((temp^2-298.15^2)/2)-18*10^-6*((temp^3-298.15^3)/3);
H.H2O=-241.82*10^3+30.13*(temp-298.15)+10.46*10^-3*((temp^2-298.15^2)/2);
H.CO=-110.53*10^3+27.62*(temp-298.15)+5.02*10^-3*((temp^2-298.15^2)/2);
H.H2=29.3*(temp-298.15)-0.83*10^-3*((temp^2-298.15^2)/2)+2.09*10^-6*((temp^3-298.15^3)/3);
H.CO2=-393.51*10^3+32.22*(temp-298.15)+22.18*10^-3*((temp^2-298.15^2)/2)-3.35*10^-6*((temp^3-298.15^3)/3);
H.O2=25.73*(temp-298.15)+12.27*10^-3/2*(temp^2-298.15^2)-3.77*10^-6/3*(temp^3-298.15^3);

S.CH4=186.26+14.23*log(temp/298.15)+75.3*10^-3*(temp-298.15)-18*10^-6*((temp^2-298.15^2)/2);
S.H2O=188.3+30.13*log(temp/298.15)+10.46*10^-3*(temp-298.15);
S.CO=197.67+27.62*log(temp/298.15)+5.02*10^-3*(temp-298.15);
S.H2=130.68+29.3*log(temp/298.15)-0.83*10^-3*(temp-298.15)+2.09*10^-6*((temp^2-298.15^2)/2);
S.CO2=213.74+32.22*log(temp/298.15)+22.18*10^-3*(temp-298.15)-3.35*10^-6*((temp^2-298.15^2)/2);
S.O2=205.14+25.73*log(temp/298.15)+12.97*10^-3*(temp-298.15)-3.77/2*10^-6*(temp^3-298.15^3);

deltaH1=3*H.H2+H.CO-H.H2O-H.CH4;
deltaS1=3*S.H2+S.CO-S.H2O-S.CH4;
deltaG1= deltaH1 - temp*deltaS1;
K1=exp(-deltaG1/(R*temp));

deltaH2=H.H2+H.CO2-H.H2O-H.CO;
deltaS2=S.H2+S.CO2-S.H2O-S.CO;
deltaG2=deltaH2 - temp*deltaS2;
K2=exp(-deltaG2/(R*temp));





% MASSES
mNH3 = masseAmmoniac*10^6;
nNH3 = mNH3/17;

syms w positive x positive y positive z positive a positive b positive V positive;
Q1 = symfun((a-b)*(3*a+b)^3/((w-a)*(x-a-b))*(R*temp/(V*100000))^2,[w x a b]);
Q2 = symfun(b*(3*a+b)/((a-b)*(x-a-b)),[w x a b]);
OxygeneFinal = symfun(y-(1/2)*(w-a),[y w a]);
AzoteFinal = symfun(z-(1/3)*(3*w+a),[z w a]);
AmmoniacFinal = symfun(2*z,[z]);
PressionTotaleReacteur1 = symfun((w+x+2*a)*R*temp/V,[w x a V]);

[solution_w, solution_x, solution_y, solution_z,solution_a,solution_b,~] = solve(Q1==K1, Q2==K2, OxygeneFinal==0, z-(79/20)*y==0, AzoteFinal==0, AmmoniacFinal==nNH3,PressionTotaleReacteur1==2950000,w,x,y,z,a,b,V);
% !! semble ne pas donner de solution exacte entre 1850 et 2450 kelvins
% d'ammoniac demandée (non compris)


mCH4=double(solution_w(1,1)*16/10^6);
mH2O=double(solution_x(1,1)*18/10^6);



E1=deltaH1*solution_a(1,1)+deltaH2*solution_b(1,1);
Efourparmol=H.CO2+2*H.H2O-H.CH4-2*H.O2;
nCH4four=-E1/Efourparmol/0.75;
mCH4four=double(nCH4four*16*10^-6);

mCH4tot=mCH4+mCH4four;


end

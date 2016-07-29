function [] = AmmoniacFactory(masseAmmoniac,temp)

% AmmoniacFactory est une fonction qui permet de calculer la masse de mati�re 
% premi�re (tonnes) et l'�nergie (GJ) n�cessaire � produire une masse
% d'ammoniac donn�e (tonnes) connaissant la temperature (Kelvin) du r�acteur 
% � vapeur m�thane et suivant le mod�le du flowsheet analys� en annexe

assert(temp>0,'entrez une temp�rature positive, en Kelvins');
assert(temp<1200,'n"utilisez pas de valeur de temp�rature supp�rieure � 1200 Kelvins');
assert(masseAmmoniac>0, 'entrez une masse en ammoniac positive, en tonnes');

Rendement=0.94; % Rendement de la synth�se d'ammoniac en tant que tel, voir t�che 2

% CONSTANTES D'EQUILIBRE
% Calculons les constantes d'�quilibre des r�actions se d�roulant dans le
% premier r�acteur � partir des donn�s disponnibles dans l'appendice 2 de
% "principes de chimie" et sur wikip�dia

% Pour calculer les constantes d'�quilibre, il est n�cessaire de connaitre
% l'enthalpie de formation et l'entropie de chacun des composants, sachant
% que celle-ci varie avec la temp�rature.

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

R=8.314;

deltaH1=3*H.H2+H.CO-H.H2O-H.CH4;
deltaS1=3*S.H2+S.CO-S.H2O-S.CH4;
deltaG1= deltaH1 - temp*deltaS1;
K1=exp(-deltaG1/(R*temp));

deltaH2=H.H2+H.CO2-H.H2O-H.CO;
deltaS2=S.H2+S.CO2-S.H2O-S.CO;
deltaG2=deltaH2 - temp*deltaS2;
K2=exp(-deltaG2/(R*temp));



% MASSES
% A partir des �quations chimiques, nous pouvons obtenir (voir feuille
% annexe)7 �quations liant les 7 inconnues(les 4 premi�res inconnues sont
% les MP entrantes, les 2 suivants �quilibrent les 2 premi�res r�actions, 
% et la derni�re est le volume du premier r�acteur). 
% Nous pouvons r�soudre ce syst�me de 7 �quations � 7
% inconnues gr�ce � la fonction solve de matlab.
mNH3 = masseAmmoniac*10^6;
nNH3 = mNH3/17;

syms w positive x positive y positive z positive a positive b positive V positive;
Q1 = symfun((a-b)*(3*a+b)^3/((w-a)*(x-a-b))*(R*temp/(V*100000))^2,[w x a b]);
Q2 = symfun(b*(3*a+b)/((a-b)*(x-a-b)),[w x a b]);
OxygeneFinal = symfun(y-(1/2)*(w-a),[y w a]);
AzoteFinal = symfun(z-(1/3)*(3*w+a),[z w a]);
AmmoniacFinal = symfun(2*z*Rendement,[z]);
PressionTotaleReacteur1 = symfun((w+x+2*a)*R*temp/V,[w x a V]);

[solution_w, solution_x, solution_y, solution_z,solution_a,solution_b,~] = solve(Q1==K1, Q2==K2, OxygeneFinal==0, z-(78/21)*y==0, AzoteFinal==0, AmmoniacFinal==nNH3,PressionTotaleReacteur1==2950000,w,x,y,z,a,b,V);
% ! Attention : ne donne plus de solution pour temp>1200 Kelvin

% Ce qui nous donne comme solution les masses (en tonnes) suivantes
mCH4=ceil(double(solution_w(1,1)*16/10^6));
disp(['la masse de m�thane n�cessaire dans le premier r�acteur vaut ' num2str(mCH4) ' tonnes'])

mH20=ceil(double(solution_x(1,1)*18/10^6));
disp(['la masse d"eau n�cessaire vaut ' num2str(mH20) ' tonnes'])

mO2=ceil(double(solution_y(1,1)*32/10^6));
disp(['la masse d"oxyg�ne n�cessaire vaut ' num2str(mO2) ' tonnes'])

mN2=ceil(double(solution_z(1,1)*28/10^6));
disp(['la masse d"azote n�cessaire vaut ' num2str(mN2) ' tonnes'])

mAr=ceil(double(solution_z(1,1)/78*40/10^6));
disp(['la masse d"argon n�cessaire vaut ' num2str(mAr) ' tonnes'])

mMP=mCH4+mH20+mO2+mN2+mAr;
disp(['la masse totale de mati�res premi�res n�cessaires vaut ' num2str(mMP) ' tonnes'])


% DEBITS
% Par ailleurs nous cherchons � obtenir les d�bits entrants et sortants en
% m^3/s

% En consid�rant le m�thane � entrant comme �tant liquide (car c'est ainsi
% qu'il est transport�, mais il entrera en phase gazeuse d�s l'entr�e dans
% le premier r�acteur)
VCH4 = mCH4*1000/422.62; % car masse volumique CH4=422.62 kg/m3 (source : wikip�dia)
DebitCH4 = double(VCH4/(24*60*60));
disp(['le d�bit d"entr�e en m�thane(liquide) vaut ' num2str(DebitCH4) ' m^3/s'])
% Par ailleurs le volume d'eau entrant �tant d�j� connu
DebitH20 = double(mH20/(24*60*60));
disp(['le d�bit d"entr�e en eau vaut ' num2str(DebitH20) ' m^3/s'])
% De plus le volume d'air entrant d�pend de la pression et de la temp�rature.
% Partons de l'hypoth�se que nous faisons entrer de l'air � condition
% standard de temp�rature et de pression, alors
Vair = solution_y(1,1)+solution_z(1,1)*R*temp/101325;
DebitAir = double(Vair/(24*60*60));
disp(['le d�bit d"entr�e en air vaut ' num2str(DebitAir) ' m^3/s'])
% Enfin calculons le d�bit d'ammoniac � la sortie
VNH3 = nNH3*R*750/27000000;
DebitNH3 = double(VNH3/(24*60*60));
disp(['le d�bit de sortie en ammoniac(gazeux) vaut ' num2str(DebitNH3) ' m^3/s'])




% TUBE(S)
% Sachant que la vitesse superficielle d'entr�e des mati�res premi�res dans 
% le premier r�acteur est de 2 m/s, et que chaque tube � un diam�tre de 10 cm, 
% combien de tubes faut-il pour permettre l'�coulement � un d�bit suffisant?

nTubes=ceil(DebitH20/(2*pi*.05^2))+ceil(DebitCH4/(2*pi*0.5^2));
disp(['Il faut ' num2str(nTubes) ' tube(s) pour permettre un �coulement suffisant d"eau et de m�thane liquide � l"entr�e du premier r�acteur'])




% ENERGIES
% Il peut �tre ceil�ressant de connaitre l'�nergie produite ou consomm�e par
% chaque r�action.

% Les 2 r�actions du premier r�acteur consomment ensemble une certaine
% �nergie

E1=deltaH1*solution_a(1,1)+deltaH2*solution_b(1,1);
Efourparmol=H.CO2+2*H.H2O-H.CH4-2*H.O2;
nCH4four=-E1/Efourparmol/0.75;
mCH4four=double(nCH4four*16*10^-6);

disp(['la masse de m�thane n�cessaire dans le four vaut ' num2str(ceil(double(mCH4four))) ' tonnes'])
mCH4tot=mCH4+mCH4four;
disp(['la masse de m�thane totale n�cessaire vaut ' num2str(ceil(double(mCH4tot))) ' tonnes'])

disp(['la quantit� d"�nergie consomm�e dans le premier r�acteur vaut ' int2str(ceil(double(E1*10^-9))) ' GJ'])

% Energie du 2�me r�acteur

deltaHR2=4*H.H2+2*H.CO-2*H.CH4-H.O2;
E2=(solution_w(1,1)-solution_a(1,1))*deltaHR2;
disp(['la quantit� d"�nergie d�gag�e dans le deuxi�me r�acteur vaut ' int2str(-ceil(double(E2*10^-9))) ' GJ'])

% Energie du 3�me r�acteur

deltaHR3=H.H2+H.CO2-H.CO-H.H2O;
E3=(solution_w(1,1)-solution_b(1,1))*deltaHR3;
disp(['la quantit� d"�nergie d�gag�e dans le troisi�me r�acteur vaut ' int2str(-ceil(double(E3*10^-9))) ' GJ'])

% Energie dans le 5�me r�acteur, nous trouvons les H suivants sachant que
% le r�acteur est � 750K
H.N2=13470;
H.NH3=-27298;
H.H2other=13043;


deltaHR5=2*H.NH3-3*H.H2other-H.N2;
E5=2*solution_z(1,1)*deltaHR5;
disp(['la quantit� d"�nergie d�gag�e dans le dernier r�acteur vaut ' int2str(-ceil(double(E5*10^-9))) ' GJ'])

mCO2=ceil(double((solution_w(1,1)+nCH4four)*44/10^6));
disp(['la masse totale de CO2 produite vaut ' num2str(mCO2) ' tonnes'])



end
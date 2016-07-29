function [] = AmmoniacFactory(masseAmmoniac,temp)

% AmmoniacFactory est une fonction qui permet de calculer la masse de matière 
% première (tonnes) et l'énergie (GJ) nécessaire à produire une masse
% d'ammoniac donnée (tonnes) connaissant la temperature (Kelvin) du réacteur 
% à vapeur méthane et suivant le modèle du flowsheet analysé en annexe

assert(temp>0,'entrez une température positive, en Kelvins');
assert(temp<1200,'n"utilisez pas de valeur de température suppérieure à 1200 Kelvins');
assert(masseAmmoniac>0, 'entrez une masse en ammoniac positive, en tonnes');

Rendement=0.94; % Rendement de la synthèse d'ammoniac en tant que tel, voir tâche 2

% CONSTANTES D'EQUILIBRE
% Calculons les constantes d'équilibre des réactions se déroulant dans le
% premier réacteur à partir des donnés disponnibles dans l'appendice 2 de
% "principes de chimie" et sur wikipédia

% Pour calculer les constantes d'équilibre, il est nécessaire de connaitre
% l'enthalpie de formation et l'entropie de chacun des composants, sachant
% que celle-ci varie avec la température.

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
% A partir des équations chimiques, nous pouvons obtenir (voir feuille
% annexe)7 équations liant les 7 inconnues(les 4 premières inconnues sont
% les MP entrantes, les 2 suivants équilibrent les 2 premières réactions, 
% et la dernière est le volume du premier réacteur). 
% Nous pouvons résoudre ce système de 7 équations à 7
% inconnues grâce à la fonction solve de matlab.
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
disp(['la masse de méthane nécessaire dans le premier réacteur vaut ' num2str(mCH4) ' tonnes'])

mH20=ceil(double(solution_x(1,1)*18/10^6));
disp(['la masse d"eau nécessaire vaut ' num2str(mH20) ' tonnes'])

mO2=ceil(double(solution_y(1,1)*32/10^6));
disp(['la masse d"oxygène nécessaire vaut ' num2str(mO2) ' tonnes'])

mN2=ceil(double(solution_z(1,1)*28/10^6));
disp(['la masse d"azote nécessaire vaut ' num2str(mN2) ' tonnes'])

mAr=ceil(double(solution_z(1,1)/78*40/10^6));
disp(['la masse d"argon nécessaire vaut ' num2str(mAr) ' tonnes'])

mMP=mCH4+mH20+mO2+mN2+mAr;
disp(['la masse totale de matières premières nécessaires vaut ' num2str(mMP) ' tonnes'])


% DEBITS
% Par ailleurs nous cherchons à obtenir les débits entrants et sortants en
% m^3/s

% En considérant le méthane à entrant comme étant liquide (car c'est ainsi
% qu'il est transporté, mais il entrera en phase gazeuse dès l'entrée dans
% le premier réacteur)
VCH4 = mCH4*1000/422.62; % car masse volumique CH4=422.62 kg/m3 (source : wikipédia)
DebitCH4 = double(VCH4/(24*60*60));
disp(['le débit d"entrée en méthane(liquide) vaut ' num2str(DebitCH4) ' m^3/s'])
% Par ailleurs le volume d'eau entrant étant déjà connu
DebitH20 = double(mH20/(24*60*60));
disp(['le débit d"entrée en eau vaut ' num2str(DebitH20) ' m^3/s'])
% De plus le volume d'air entrant dépend de la pression et de la température.
% Partons de l'hypothèse que nous faisons entrer de l'air à condition
% standard de température et de pression, alors
Vair = solution_y(1,1)+solution_z(1,1)*R*temp/101325;
DebitAir = double(Vair/(24*60*60));
disp(['le débit d"entrée en air vaut ' num2str(DebitAir) ' m^3/s'])
% Enfin calculons le débit d'ammoniac à la sortie
VNH3 = nNH3*R*750/27000000;
DebitNH3 = double(VNH3/(24*60*60));
disp(['le débit de sortie en ammoniac(gazeux) vaut ' num2str(DebitNH3) ' m^3/s'])




% TUBE(S)
% Sachant que la vitesse superficielle d'entrée des matières premières dans 
% le premier réacteur est de 2 m/s, et que chaque tube à un diamètre de 10 cm, 
% combien de tubes faut-il pour permettre l'écoulement à un débit suffisant?

nTubes=ceil(DebitH20/(2*pi*.05^2))+ceil(DebitCH4/(2*pi*0.5^2));
disp(['Il faut ' num2str(nTubes) ' tube(s) pour permettre un écoulement suffisant d"eau et de méthane liquide à l"entrée du premier réacteur'])




% ENERGIES
% Il peut être ceiléressant de connaitre l'énergie produite ou consommée par
% chaque réaction.

% Les 2 réactions du premier réacteur consomment ensemble une certaine
% énergie

E1=deltaH1*solution_a(1,1)+deltaH2*solution_b(1,1);
Efourparmol=H.CO2+2*H.H2O-H.CH4-2*H.O2;
nCH4four=-E1/Efourparmol/0.75;
mCH4four=double(nCH4four*16*10^-6);

disp(['la masse de méthane nécessaire dans le four vaut ' num2str(ceil(double(mCH4four))) ' tonnes'])
mCH4tot=mCH4+mCH4four;
disp(['la masse de méthane totale nécessaire vaut ' num2str(ceil(double(mCH4tot))) ' tonnes'])

disp(['la quantité d"énergie consommée dans le premier réacteur vaut ' int2str(ceil(double(E1*10^-9))) ' GJ'])

% Energie du 2ème réacteur

deltaHR2=4*H.H2+2*H.CO-2*H.CH4-H.O2;
E2=(solution_w(1,1)-solution_a(1,1))*deltaHR2;
disp(['la quantité d"énergie dégagée dans le deuxième réacteur vaut ' int2str(-ceil(double(E2*10^-9))) ' GJ'])

% Energie du 3ème réacteur

deltaHR3=H.H2+H.CO2-H.CO-H.H2O;
E3=(solution_w(1,1)-solution_b(1,1))*deltaHR3;
disp(['la quantité d"énergie dégagée dans le troisième réacteur vaut ' int2str(-ceil(double(E3*10^-9))) ' GJ'])

% Energie dans le 5ème réacteur, nous trouvons les H suivants sachant que
% le réacteur est à 750K
H.N2=13470;
H.NH3=-27298;
H.H2other=13043;


deltaHR5=2*H.NH3-3*H.H2other-H.N2;
E5=2*solution_z(1,1)*deltaHR5;
disp(['la quantité d"énergie dégagée dans le dernier réacteur vaut ' int2str(-ceil(double(E5*10^-9))) ' GJ'])

mCO2=ceil(double((solution_w(1,1)+nCH4four)*44/10^6));
disp(['la masse totale de CO2 produite vaut ' num2str(mCO2) ' tonnes'])



end
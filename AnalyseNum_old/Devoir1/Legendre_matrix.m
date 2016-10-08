T=zeros(20,20);
Beta=zeros(20,1);
C=zeros(21,1);
C(1)=1; %C_0=1
C(2)=1; %C_1=1

%Remplissons la matrice T
for i=2:20
    C(i+1)= (2*i-1)/i*C(i);
    %T(i,i)=0; (alpha(i)=0)
    Beta(i)= sqrt(((i-1)/i)*C(i-1)/C(i+1));
    T(i-1,i)= Beta(i);
    T(i,i-1)= Beta(i);
end
T2=round(T,4);

X1=1/2;
X2=3/4;

%Calculons les valeurs de la suite de Sturm aux points X1 et X2
PiOfX1=findPolynoms(1/2,T);
PiOfX2=findPolynoms(3/4,T);

VarX1=numSignVar(PiOfX1);
VarX2=numSignVar(PiOfX2);
rootsBetweenX1AndX2= VarX1 - VarX2;
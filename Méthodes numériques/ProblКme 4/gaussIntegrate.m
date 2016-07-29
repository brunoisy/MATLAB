function [ Ih ] = gaussIntegrate(L,z,error)
% gaussIntegrate - Numerically evaluate double integral over square using Gauss-Legendre quadrature
%
%    This MATLAB function uses the composite Gauss-Legendre quadrature to evaluate the double integral
%    fun(x,y) over the square of sidelength L with an absolute tolerance tol.
%
%    g = gaussIntegrate(L,fun,tol)
%
%    See also function_handle, integral, integral2, integral3, quad, quad2d

% BRUNO DEGOMME
% 15/11/14

Ia=[0 Inf]; % contient les "a" approximations successives de l'integrale recherchee
a=2;
n=1; % mis au carre, vaut le nombre de carres sur lesquels est approximee z

while(abs(Ia(a)-Ia(a-1))>error) % tant que la différence entre 2 approximations successives est supperieure a l'erreur toleree
    n=2*n; % quadrupler le nombre de carres
    a=a+1;
    
    Ia(a)=0; % initialiser la valeur de l'integrale a zero
    h=2*L/n;
    X=[-0.861136311594053, -0.339981043584856, 0.339981043584856,0.861136311594053];
    W=[0.347854845137454 0.652145154862546 0.652145154862546 0.347854845137454];
    Xh=X*h/2;
    Yh=Xh;
    Wx=W*h/2;
    Wy=Wx;
    for i=1:n
        for j=1:n % pour chaque carre
            [Xcar, Ycar]=meshgrid(Xh-L-h/2+i*h,Yh-L-h/2+j*h); % les coordonees des 16 points du carre
            U=z(Xcar,Ycar); % la valeur des 16 points du carré
            
            IhLocal=Wx*U*Wy'; % l'approximation de GL en tant que tel
            Ia(a)=Ia(a)+IhLocal; % nous rajoutons le volume du carre considere a l'integrale totale
        end
    end
end

Ih=Ia(a); % renvoie la valeur de l'integrale approximee avec une erreur inferieure a error
end


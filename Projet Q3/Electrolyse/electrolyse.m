function []= electrolyse ()
% Auteur: Groupe 1226
% Date: 29/10/14

% Les 2 premi�res �quations repr�sentent le coefficient d'avencement des
% r�actions respectives, la 3�me �quation repr�sente le pH de la solution
% en fonction des inconnues utilis�es.
syms x y V;
% x est le nombre de moles de r�actifs r�agissant dans le premi�re r�action
% y est le nombre de moles r�agissant dans la seconde r�action
% V est le volume de solution H2S04 ajout�
Qa1= symfun((x^2-y^2)/((5*V-x)*(V+1)),[x y V]);
Qa2= symfun(y*(x+y)/((x-y)*(V+1)),[x y V]);
H3O= symfun(((x+y)/(1+V)),[x y V]);

j=1;
for i=[0 1 2 3 5] % on r�sout le syst�me de 3 �quations � 3 inconnues
    [solution_x(j),solution_y(j),solution_V(j)]=solve(Qa1==1000,Qa2==0.0126,H3O==10^(-i),x,y,V); 
    j=j+1;
end
Xf=double(solution_x);
Yf=double(solution_y);
Vf=double(solution_V)
% U vaut le rapport [H3O+]eqi/[H2SO4]ini
U=(Xf+Yf)./(5*Vf);
plot([0 1 2 3 5],U);
end

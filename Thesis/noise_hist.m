kb = 1.38064852e-23;
T = 270;%?
lp = 10^-9;%??


addpath('helpers')
comma2point_overwrite('curves_LmrP_proteoliposomes/good/curve_2.txt')% change commas to points

fileID = fopen('curves_LmrP_proteoliposomes/good/curve_2.txt');
C = textscan(fileID, '%f %f');
fclose(fileID);
dist = C{1};
force = C{2};
figure
hold on
plot(dist,force,'.')


%%% first step is to find local minimas of the FD profile. 
%%% We will assume those determine the position of a crest

maxmin = 9;%(max # of maxmin local minimas)
locmax = zeros(2,maxmin);
a = 1;
hi = 20; %size of half interval...
for i=1+hi:length(force)-hi
    locmax(:,a) = [dist(i); force(i)];
    a = a+1;
    if a>maxmin
        break
    end
    for j=[-hi:-1,1:hi]
        if(force(i+j)<force(i))
            a = a-1;
            break
        end
    end
end

plot(locmax(1,:),locmax(2,:),'*')

Lc = zeros(1,maxmin);
for i = 1:maxmin
    Xi = locmax(1,i);
    Fi = locmax(2,i);
%     p = [4*lp*Fi/T, (-4*Xi-2*Xi*(4*lp*Fi/(kb*T)+1))*kb, 8*Xi^2*kb+Xi^2*(4*lp*Fi/T+kb),-4*Xi^3*kb];
%     thisroots = roots(p);
%     thisroots = thisroots(thisroots>0);
%     Lc(i) = real(thisroots(1));%danger (usually 2 conjugate roots i.e same)
%     syms L
%     Lc(i) = solve(Fi == kb*T/lp*(1/(4*(1-Xi/L)^2)-1/4+Xi/L),0<L,L);
    A = -Fi*lp/(kb*T)
    Lc(i) = 1/Xi*(4/3-4/(3*sqrt(A+1))-10*exp(nthroot(900/A,4))/(sqrt(A)*(exp(nthroot(900/A,4))-1)^2)+A^1.62/(3.55+3.8*A^2.2));
end



for i=1:maxmin
    X = linspace(0,Lc(i)*95/100,100);
    F = fd_curve(Lc(i),X);
    plot(X,F*2000000*10^12);
end

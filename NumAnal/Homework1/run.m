%%%%%%%%%%%%% question 1
n = 6;
x = linspace(-1,1,n+1);% interpolation points

f1 = @(x) 1/(1+30*x^2);
f2 = @(x) sin(pi*x);
fs = {f1, f2};

for i = 1:length(fs)% for each function
    f = fs{i};
    y = arrayfun(f,x);% interpolation values
    newtPoly = makeNewtonPoly(x,y);
    nevPoly  = makeNevillePoly(x,y);
    
    % Plotting
    figure
    hold on;
    if i == 1; title('f1 = 1/(1+30*x^2)');
    else title('f2 = sin(pi*x)'); end
    
    X = linspace(-1,1,100);
    Y = arrayfun(f, X); 
    plot(X, Y);% function
    
    plot(x, y, '*');% interpolation points
    
    Ynewt = arrayfun(newtPoly, X);
    plot(X, Ynewt);
    
    Ynev = arrayfun(nevPoly, X);
    plot(X, Ynev);
    
    legend('function','interpolation points','newton interpolation polynomial','neville interpolation polynomial');
end


%%%%%%%%%%%%% question 2
%%%%%%% i)
y = arrayfun(f1,x); % we will calculate the jacobian only with the first function
% (the jacobian is independent from the chosen function)
interPoly = polyfit(x,y,n);
J = zeros(n+1,n+1);
for j = 1:n+1
    eps = zeros(1,n+1);% perturbation
    eps(j) = 1;
    yPert = y + eps;
    monomPolyPert = polyfit(x,yPert,n);% perturbed interpolation polynomial
    J(j,:) = fliplr(monomPolyPert - interPoly);
end
frobeniusNorm = norm(J,'fro');


%%%%%%% ii)
xStar = x(1)+(x(2)-x(1))/2;

for i = 1:length(fs)% for each function
    f = fs{i};
    y = arrayfun(f,x);
    monomPoly = polyfit(x,y,n);
    yStar = polyval(monomPoly,xStar);
    
    dPdEpsNewt  = zeros(1,n+1); % gradient evaluated in xStar
    dPdEpsNev   = zeros(1,n+1);
    dPdEpsMonom = zeros(1,n+1);
    
    for j = 1:n+1
        eps = zeros(1,n+1);% perturbation
        eps(j) = 1;
        yPert = y + eps;
        
        newtPolyPert  = makeNewtonPoly(x,yPert);% perturbed interpolation polynomial
        nevPolyPert   = makeNevillePoly(x,yPert);
        monomPolyPert = polyfit(x,yPert,n);
        
        dPdEpsNewt(j)  = newtPolyPert(xStar)          - yStar;
        dPdEpsNev(j)   = nevPolyPert(xStar)           - yStar;
        dPdEpsMonom(j) = polyval(monomPolyPert,xStar) - yStar;
    end
    
    norm(dPdEpsNewt)
    norm(dPdEpsNev)
    norm(dPdEpsMonom)
end



%%%%%%%%%%%% question 3
%%%%%% Normal Plot
X = linspace(-1,1,100);% for plotting
figure
hold on;
for i = 1:length(fs)% for each function
    f = fs{i};
    Y = arrayfun(f, X); 
    if i == 1   
        subplot(1,2,1)
        hold on;
        title('f1 = 1/(1+30*x^2)');
    else
        subplot(1,2,2)
        hold on;
        title('f2 = sin(pi*x)'); 
    end
    plot(X, Y);% function
    
    for n = [6 12]
        x = linspace(-1,1,n+1);% interpolation points
        y = arrayfun(f,x);% interpolation values
        
        newtPoly = makeNewtonPoly(x,y);% we use only newton interpolation as the polynomial is the same as neville's  
        Ynewt = arrayfun(newtPoly, X);
        plot(X, Ynewt);
    end
    plot(x, y, '*');% interpolation points
    legend('function','newton interpolation n=6','newton interpolation n=12','interpolation points n=12');
end

%%%%%% Perturbed Plot
rng(5);
X = linspace(-1,1,100);% for plotting
figure
hold on;
for i = 1:length(fs)% for each function
    f = fs{i};
    Y = arrayfun(f, X); 
    if i == 1   
        subplot(1,2,1)
        hold on;
        title('f1 = 1/(1+30*x^2)');
    else
        subplot(1,2,2)
        hold on;
        title('f2 = sin(pi*x)'); 
    end
    plot(X, Y);% function
    
    for n = [6 12]
        x = linspace(-1,1,n+1);% interpolation points
        y = arrayfun(f,x);% interpolation values
        eps = -0.01 + rand(1,n+1)./50;
        yPert = y + eps;
        
        newtPoly = makeNewtonPoly(x,yPert);% we use only newton interpolation as the polynomial is the same as neville's  
        Ynewt = arrayfun(newtPoly, X);
        plot(X, Ynewt);
    end
    plot(x, yPert, '*');% interpolation points
    legend('function','newton interpolation n=6','newton interpolation n=12','interpolation points n=12');
end
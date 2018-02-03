addpath('functions')
addpath('functions_ransac')


xlimits = [-10, 200];
ylimits = [-150, 20];

figure
hold on
title('histogram (Lc(i-1),Lc(i)) data 4')
xlim([0,220])
ylim([0,220])
xlabel('Lc(i-1)')
ylabel('Lc(i)')
plot(1:220,1:220)%diagonal

colors = get(gca, 'colororder');

directory = 'data/MAT/data_4/';
maxLcs = 1000;
LcFirsts = zeros(1,maxLcs);
LcSeconds = zeros(1,maxLcs);

i=1;
for filenumber = 136:271
    if filenumber ~= 160 && filenumber ~=162 && filenumber ~=178 && filenumber ~=205 && filenumber ~=258 && filenumber ~=261 && filenumber ~=263
        filename = strcat(directory,'curve_',int2str(filenumber),'.mat')
        Lc = RANSAC_fit_fd(filename, xlimits, ylimits, false);
%         Lc = lsq_fit_fd(filename, xlimits, ylimits,1,false,false);
%         for i=1:length(Lc)-1
%             plot(Lc(i),Lc(i+1),'.','Color',colors(mod(i, 7)+1,:));
%         end
        LcFirsts(i:i+length(Lc)-2) = Lc(1:end-1);
        LcSeconds(i:i+length(Lc)-2) = Lc(2:end);
        i = i + length(Lc)-1;
    end
end
LcFirsts = LcFirsts(1:i-1);
LcSeconds = LcSeconds(1:i-1);
plot(LcFirsts,LcSeconds,'.')



n = 50;
m = 50;
A = sparse(n*m,n*m); % adjacency matrix
posY = linspace(0,220,n);
posX = linspace(0,220,m);
sigma = [5,0;0,3];%TO CHANGE!


% vertical links
for j = 1:m
    for i = j+1:n
        mu = [posX(j); posY(i)];
        
        A(j+n*(j-1),i+n*(j-1)) = MAX - sum(normpdf([LcFirsts;LcSeconds],mu,sigma));%weight inversely prop to node density
    end
end
% horizontal links
for i = 1:n
    for j = 1:i-1
        A(i+n*(j-1),i+n*(i-1)) = 0;
    end
end


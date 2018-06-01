% this model generates data following our FD profile model
rng(3)
load('constants.mat')


Lc = [33, 50, 92, 130, 164]; % Example of possible model parameters
Xunfold = [28, 40, 77, 105, 133];%0.85*Lcs;
nCrest = length(Lc);

maxDist = 180;
n = 1024;
sigmaNoise = 5;

dist = linspace(0, maxDist, n);
force = fd_profile(dist, Lc, Xunfold); %+ sigmaNoise*randn(1,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hold on
tit = title('The Worm-Like Chain Profile');
xlabel('Distance (nm)');
ylabel('Force (pN)');
set(gca,'FontSize',24)
xlim([0, maxDist])
ylim([-140, 20])

colors = get(gca, 'colororder');
colors = colors([1,2,4,5,6,7],:);%don't like yellow...
for i = 1:nCrest
   if i == 1
       plot(dist(dist<=Xunfold(i)), force(dist<=Xunfold(i)),'Color',colors(i,:),'LineWidth',2)
   else
       plot(dist(Xunfold(i-1) < dist & dist<=Xunfold(i)), force(Xunfold(i-1) < dist & dist<=Xunfold(i)),'Color',colors(i,:),'LineWidth',2)
   end
   plot([Xunfold(i), Xunfold(i)], [-140, 20],':','Color', colors(i,:),'LineWidth',2)
   plot([Lc(i), Lc(i)], [-140, 20],'--','Color', colors(i,:),'LineWidth',2) 
end
% plot([Xunfold(nCrest),maxDist], [0,0],'Color',colors(nCrest+1,:))
lgd = legend('WLC curve', 'X_{u}^{i+1}', 'L_c^i');

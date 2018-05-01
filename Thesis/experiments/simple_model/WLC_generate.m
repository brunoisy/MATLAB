% this model generates data following our FD profile model
rng(3)
load('constants.mat')


Lc = [33, 50, 92, 130, 147]; % Example of possible model parameters
Xunfold = [28, 40, 77, 105, 117];%0.85*Lcs;
nCrest = length(Lc);

maxDist = 150;
n = 1024;
sigmaNoise = 5;

dist = linspace(0, maxDist, n);
force = fd_profile(dist, Lc, Xunfold)+ sigmaNoise*randn(1,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hold on
tit = title('The Worm-Like Chain model');
xlabel('Distance (nm)');
ylabel('Force (pN)');
xlim([0, maxDist])
ylimits = [-200, 50];%[-140,20]
ylim(ylimits)

colors = get(gca, 'colororder');
colors = colors([1,2,4,5,6,7],:);%don't like yellow...
for i = 1:nCrest
   if i == 1
       plot(dist(dist<=Xunfold(i)), force(dist<=Xunfold(i)),'.','Color',colors(i,:),'markers',12)
   else
       plot(dist(Xunfold(i-1) < dist & dist<=Xunfold(i)), force(Xunfold(i-1) < dist & dist<=Xunfold(i)),'.','Color',colors(i,:),'markers',12)
   end
   plot([Xunfold(i), Xunfold(i)], ylimits,'Color', colors(i,:))
   plot([Lc(i), Lc(i)], ylimits,'--','Color', colors(i,:)) 
end
% plot([Xunfold(nCrest),maxDist], [0,0],'Color',colors(nCrest+1,:))
lgd = legend('FD points', 'X_{unfold}^i', 'L_c^i');
set(gca,'FontSize',24)
lgd.FontSize = 30;

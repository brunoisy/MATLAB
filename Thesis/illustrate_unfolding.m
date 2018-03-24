addpath('LSQ fit')


Lc = [33, 50, 92, 130, 164]; % Example of possible model parameters
Xunfold = [0, 28, 40, 77, 105, 133];
nCrest = length(Lc);
X = -10*(0:nCrest);


% Plotting
figure
subplot(2,1,1)
hold on
xlim([-10*nCrest,200]);
ylim([-1,1]);
set(gca,'ytick',[])

% give different lengths to sections!
h = zeros(1,nCrest);
for i = 1:nCrest
    h(i) = plot([X(i+1),X(i)],[0,0],'linewidth',5);% ith section
end
% plot(0,0,'*') % draw tip?


subplot(2,1,2)
hold on
set(gca,'XAxisLocation','top');
xlim([-10*nCrest,200]);
ylim([-200,0]);
xlabel('Distance (nm)');
ylabel('Force (pN)');

% f = 0;
% x = 0; 
% h2 = plot(f,x,'.');
z=animatedline;

% we move tip 1 nm/sec

set(gca,'nextplot','replacechildren');
for d = 1:200
%     X(1) = X(1)+1
    for i = 1:nCrest
        if d>Xunfold(i)
            X(i) = X(i)+1;
            thisLc = Lc(i);
        end
    end
    for i =1:nCrest
        set(h(i),'XData',[X(i+1),X(i)],'YData',[0,0]);
    end
    
    f = fd(thisLc,X(1));
    if d >Xunfold(end)
        f = 0;
    end
%     set(h2,'XData',X(1),'YData',f);
            addpoints(z,X(1),f);

    
    drawnow;
    F(d) = getframe;
end
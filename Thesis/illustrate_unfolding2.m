addpath('LSQ fit')


Lc = [33, 50, 92, 130, 164]; % Example of possible model parameters
Xunfold = [28, 40, 77, 105, 133];
ncrest = length(Lc);


% Plotting
figure
subplot(2,1,1)
hold on
xlim([0,200]);
ylim([-1,1]);
set(gca,'ytick',[])
set(gca,'FontSize',22)
    colors = get(gca, 'colororder');


h = zeros(1,ncrest);
for i = 1:ncrest
    h(i) = plot([0,0],[0,0],'linewidth',5);% ith section
end
% plot(0,0,'*') % draw tip?-> draw knot to represent protein!
h
line1 = plot([0,0],[-1,1],'--','Color',colors(7,:));

subplot(2,1,2)
hold on
set(gca,'XAxisLocation','top');
set(gca,'FontSize',22)

xlim([0,200]);
ylim([-150,0]);
xlabel('Distance (nm)');
ylabel('Force (pN)');


z=animatedline;
line2 = plot([0,0],[-150,1],'--','Color',colors(7,:));

% we move tip 1 nm/sec

set(gca,'nextplot','replacechildren');
for x = 1:200

    n = find(x<Xunfold,1);% number of stretching sections
    if isempty(n)
        n=ncrest;
        wasempty = true;
    else
        wasempty = false;
    end
    X = zeros(1,n+1);
    X(1) = x;
    if wasempty
        X(n+1) = x-Xunfold(end);
    else
        X(n+1) = 0;
    end
    
    for i = n:-1:2
        X(i) = X(i+1)+(Lc(i)-Lc(i-1))/Lc(n)*(X(1)-X(n+1));
    end
    for i =1:n
        set(h(i),'XData',[X(i+1),X(i)],'YData',[0,0]);
    end
    
    f = fd(Lc(n),X(1));
    if x >Xunfold(end)
        f = 0;
    end
    set(line1,'XData',[x,x],'YData',[-1,1]);
    set(line2, 'XData',[x,x],'YData',[-150,1]);
    if any(x==Xunfold)
        pause(0.2)
    else
        pause(0.02)
    end
    addpoints(z,X(1),f);
    drawnow;
    F(x) = getframe;
end
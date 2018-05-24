figure
hold on
tracenumbers = 1:100;
ninlierss = [10, 20, 30, 40];
for j = 1:4
    subplot(2,2,j)
    
    tempLcs = 20:0.5:150;
    meanLcs = zeros(1,length(tempLcs));
    varLcs = zeros(1,length(tempLcs));
    for i=1:length(tempLcs)
        closestLcs = zeros(1,length(tracenumbers));
        for t = tracenumbers
            if deltas(t)~=0 %aligned curve
                thisLcs = exhLcs{t};
                [~, I] = min(abs(thisLcs-tempLcs(i)));
                closestLcs(t) = thisLcs(I);
            else
                closestLcs(t) = Inf;
            end
        end
        [~,I] = sort(abs(closestLcs-tempLcs(i)));
        inlLcs = closestLcs(I(1:ninlierss(j)));
        meanLcs(i) = mean(inlLcs);
        varLcs(i) = var(inlLcs);
    end
    plot(meanLcs, varLcs,'LineWidth',2)
    
    %
    %         subplot(2,2,j)
    %      allLcs = allLcs(allLcs<160);
    %     ninliers = ninlierss(j);
    %     N = length(allLcs)-ninliers+1;
    %         meanLc = zeros(1,N);
    %         varLc = zeros(1,N);
    %         for i = 1:N
    %             inliers = i:i+ninliers-1;
    %             meanLc(i) = mean(allLcs(inliers));
    %             varLc(i) = var(allLcs(inliers));
    %         end
    %         plot(meanLc, varLc,'LineWidth',2)
    %         title(strcat(["n = ", int2str(ninliers)]))
    title(['n = ',int2str(ninlierss(j))])
    if j==1 || j==3
        ylabel('variance')
    end
    if j==1
        ylim([0,3])
    elseif j==2
        ylim([0,5])
    else
        ylim([0,20])
        xlabel('window mean (nm)')
        
    end
    set(gca,'FontSize',24)
end


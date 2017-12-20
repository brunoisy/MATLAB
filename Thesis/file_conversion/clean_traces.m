ndir = 4;

dir = strcat('data/MAT/data_',int2str(ndir),'/');
newdir = strcat('data/MAT_clean/data_',int2str(ndir),'/');

% xlimits = [-10, 200];
% ylimits = [-150, 20];
xlimits = [-10, 200];
ylimits = [-200, 50];

for filenumber = 136:271
    filename = strcat(dir,'curve_',int2str(filenumber),'.mat');
    load(filename)
    % x = preprocess(x);%??
    
    
%     figure
%     subplot(1,2,1)
%     hold on
%     xlim(xlimits)
%     ylim(ylimits)
%     plot(dist,force,'.')
 

    %%% 1 - We remove all points from start phase
    start_ind = 1;
    thresh = 20;
    for i = 1:length(dist)-3
        if force(i+3) - force(i) > thresh
            breakpoint = i+2;
            break
        end
    end
    for i = breakpoint:length(dist-10)
        if force(i) - force(i+10) > 0
            dist = dist(i:end);
            force = force(i:end);
            break
        end
    end
    
    %%% 2 - We remove all points from end phase
    min_points = 100;
    mu_f = mean(force(end-min_points:end));
    sigma_f = std(force(end-min_points:end));
    thresh = mu_f - 2.5*sigma_f;
    
    strikes = 0;
    max_strikes = 5;
    for i = length(force)-min_points:-1:1
        if force(i) < thresh
            strikes = strikes+1;
        else
            strikes = 0;
        end
        if strikes >= max_strikes
            
            dist = dist(1:i+max_strikes-1);
            force = force(1:i+max_strikes-1);
            break
        end
    end
        
%     
%     subplot(1,2,2)
%     hold on
%     xlim(xlimits)
%     ylim(ylimits)
%     plot(dist,force,'.')
%     
    save(strcat(newdir,'/curve_',int2str(filenumber),'.mat'),'dist','force');
end
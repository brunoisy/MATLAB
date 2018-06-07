filename = 'data/MAT_clean/data_4/curve_13.mat';
load(filename)

xlimits = [-10, 200];
ylimits = [-200, 50];

deltas = 20:50;
error = zeros(1,length(deltas));

for i = 1:length(deltas)
    dist2 = dist+deltas(i);
    [Lcs, firstinliers, lastinliers] = exhaustive_fit(dist2, force);
    Xsel = [];
    Fsel = [];
    lastselinliers = zeros(1,length(lastinliers));
    for j = 1:length(firstinliers)
        Xsel = [Xsel, dist2(firstinliers(j):lastinliers(j))];
        Fsel = [Fsel, force(firstinliers(j):lastinliers(j))];
        if j ==1
            lastselinliers(j) = lastinliers(j)-firstinliers(j)+1;
        else
            lastselinliers(j) = lastselinliers(j-1)+1+lastinliers(j)-firstinliers(j);
        end
    end
    error(i) = sum((Fsel - fd_multi([0, Lcs],Xsel,lastselinliers)).^2)/length(Xsel);
end


figure
hold on
set(gca,'FontSize',24)
title('sensitivity of error to offset')
xlabel('offset (nm)')
ylabel('MSE')
plot(deltas,error,'LineWidth',2)


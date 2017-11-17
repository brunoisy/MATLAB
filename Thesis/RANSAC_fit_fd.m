function [] = RANSAC_fit_fd(filename, xlimits, ylimits)

load(filename)
x = [dist; force];
%x = preprocess(x);
free = true(1,length(x));

maxLc = 220;
maxnLc = 15;
nLc = 0;
Lc = zeros(1,maxnLc);
allinliers = cell(1,maxnLc+1);


%%% 1 - We fit two line to the profile, to get rid of approaching phase
thresh = 10;
[~, inliers]  = ransac(x(:,free), @linefittingfn, @linedistfn, @degenfn, 2, thresh, 1, 10, 50, true);
allinliers{1} = inliers;
start_ind     = inliers(end);
free(1:start_ind) = false(1,start_ind);



%%% 2 - We attempt to fit an FD curve to the different crests
thresh = 20;
for i = 1:maxnLc
    if ~any(free)
        nLc = i-1;
        break
    end
    [~,inliers]     = ransac_2(x(:,free), @fittingfn, @distfn, @degenfn, 1, thresh, 1, 10, 30);
    inliers         = start_ind+inliers;
    allinliers{1+i} = inliers;
    start_ind       = inliers(end);
    
    free(1:start_ind) = false(1,start_ind);
    
    Lc(i) = fittingfn(x(:,inliers));
    if Lc(i) > maxLc
        nLc = i-1;
        break;
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%% Plot
figure

subplot(1,2,1)
hold on
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('initial datapoints');
plot(x(1,:), x(2,:),'.')



subplot(1,2,2)
hold on
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('approximated FD profile using RANSAC');

xinliers = x(:,allinliers{1});
plot(xinliers(1,:), xinliers(2,:),'.')
ab = polyfit(xinliers(1,:), xinliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(min(xinliers(1,:)'),max(xinliers(1,:)'));
F = a*X+b;
plot(X,F)



for i = 1:nLc
    xinliers = x(:,allinliers{1+i});
    plot(xinliers(1,:), xinliers(2,:),'.')
    
    X = linspace(0,Lc(i));
    F = fd(Lc(i), X);
    plot(X,F)
end


end
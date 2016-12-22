function [] = addeq(k_1, k_2, k_3, u, v, C, D, colort, markersize)
if nargin < 9
    markersize=6;
    if nargin < 8
        colort = true;
    end
end
[x_2, x_3, eqtypes] = equilibria(k_1, k_2, k_3, u, v, C, D);
if colort
    colormap = {[0 .8 0], [.8 0 0], [.8 .3 0], [0 0 .8], [0 .6 0], [.6 0 0], [0 1 0], [1 0 0], [1 .5 0], [0 0 1], [0.5 0 0.5], [.5 .3 .3]};
    for i = 1:length(x_2)
        plot(x_2(i), x_3(i), 'o', 'MarkerSize', markersize, 'MarkerFaceColor', colormap{eqtypes(i)});
        hold on;
    end
else
    plot(x_2, x_3, '.', 'MarkerSize', markersize);
    hold on;
end
end

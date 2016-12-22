function addsim(k_1, k_2, k_3, u, v, x0_1, x0_2, x0_3, x0_4)
[~, x_2, x_3] = ozone(k_1, k_2, k_3, u, v, x0_1, x0_2, x0_3, x0_4, 1/2^4, 30);
if any(~isfinite(x_2)) || any(~isfinite(x_3))
    warning('Some trajectories are NaN/Inf')
else
    plot(x_2, x_3);
    hold on;
end
end
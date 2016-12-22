function simulate(k_1, k_2, k_3, u, v, x0_1, x0_2, x0_3, x0_4)

c = 0;
    function addsim(x0_1, x0_2, x0_3, x0_4)
        [T, x_2, x_3] = ozone(k_1, k_2, k_3, u, v, x0_1, x0_2, x0_3, x0_4, 1/100, 10);
        if any(~isfinite(x_2)) || any(~isfinite(x_3))
            warning('Some trajectories are NaN/Inf')
        else
            h(c) = plot(x_2, x_3);
        end
    end

names = {};
figure;
for x00_3 = linspace(.01,x0_3+x0_4,4)
    x00_4 = x0_4+x0_3-x00_3;
    for x00_2 = linspace(.01,(2*x0_1+3*x0_2+x0_4-x00_4)/6,4)
        x00_1 = (2*x0_1+3*x0_2+x0_4-x00_4-3*x00_2)/2;
        c = c+1;
        addsim(x00_1, x00_2, x00_3, x00_4);
        hold on;
        names{c} = strcat('(',num2str(x00_2, 3),',',num2str(x00_3, 3),')');
    end
end
legend(h(:),names{:});


end

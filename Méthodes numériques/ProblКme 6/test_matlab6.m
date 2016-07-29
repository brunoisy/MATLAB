function test_matlab6

    global shot

    close all;

    figure(),
    subplot(2,1,1)
    axis([0 300 0 200]); 
    title('Trajectories');
    axis manual; hold on;

    subplot(2,1,2);
    axis([0 90 220 250]); 
    title('Distance versus elevation angle');
    axis manual; hold on;

    shot = 0;
    adjustFire(88.48,42,0.01,0.05,@f);
    fprintf('=== Number of shots : %d \n', shot);

end

function dudt = f(u)

    dudt = u;
    dudt(1) = -0.01 * u(1);
    dudt(2) = u(1);
    dudt(3) = -9.81 - 0.01 * u(3);
    dudt(4) = u(3);
    
end
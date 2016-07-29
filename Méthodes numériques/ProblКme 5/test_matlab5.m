function test_matlab5()

close all;
[X,U] = beam();

figure;
finalValue = U(end,1);
plot(X,U(:,1),'-r',X,U(:,2),'-b');

fprintf('\n\nIntegration by Runge-Kutta scheme \n');
fprintf('  Finale value is : %5.7f \n',finalValue);

end
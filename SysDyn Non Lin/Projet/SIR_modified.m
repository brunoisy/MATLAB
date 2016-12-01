%FAILURE
r = 0.003;
a = 0.001;
p = 1;
N = 1000;
f = @(t,x) [-r*x(1)^p*x(2); r*x(1)^p*x(2)-a*x(2); a*x(2)];




Rinit = 0;
figure
hold on
xlabel('susceptibles')
ylabel('infectious')
for Iinit = 10 %10:100:N %0:100:(N-Rinit)
    Sinit = N-Rinit-Iinit;
    [~,SIR] = ode45(f,0:10000,[Sinit;Iinit;Rinit]);
    plot(SIR(:,1),SIR(:,2),'*');
end


%f = @(t,x) [-r*x(1)*x(2); r*x(1)*x(2)-a*x(2); a*x(2)];


% 
% Rinit = 0/N;
% figure
% hold on
% xlabel('susceptibles')
% ylabel('infectious')
% for Iinit = (10:100:N)./N %0:100:(N-Rinit)
%     Sinit = 1-Rinit-Iinit;
%     [~,SIR] = ode45(f,0:1000,[Sinit;Iinit;Rinit]);
%     plot(SIR(:,1),SIR(:,2),'*');
% end

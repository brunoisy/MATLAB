function test_matlab8

%
% -1- Les jolis plots :-)
%
close all;  set(figure,'Color',[1 1 1]);

zeta = [0 10 100 1000];
for i=1:4
    [X,Y,U] = convection(82,zeta(i));
    subplot(2,2,i)
    contourf(X,Y,U,0:0.05:2.0); caxis([0 0.8 ]);
    axis off; axis equal;
end
  
end





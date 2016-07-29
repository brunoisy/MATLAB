function [  ] = matlab7_test( )

[x,y]=meshgrid([-8:0.5:8],[-8:0.5:8]);
[alpha] = GearStability(x,y,4);
figure; contourf(x,y,-alpha,[-1:0.1:0]); grid;

end
 
 
 

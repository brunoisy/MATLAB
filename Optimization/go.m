% Example task: separate the first iris species from the second one

load Iris

% We use the 2D version of the iris dataset
set1 = Iris2{1};
set2 = Iris2{2};

% [h,c]=linsep(set1, set2);
% plotpoints(set1,set2,h,c);
% pause;
% 
% [h,c]=marginsep(set1, set2);
% plotpoints(set1,set2,h,c);
% pause;

E=ellisep(set1, set2);
plotpoints(set1,set2,E);
pause;
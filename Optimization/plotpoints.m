function plotpoints(p1, p2, h_E, c)
% p1 and p2 contain the two sets of points to be plotted
% (data points are arranged as columns in matrices pa and pb)
% If problem is 2D and h_E contains a vector and c a scalar:
%    line with equation h_E^T x + c = 0 is plotted 
% If problem is 2D and h_E contains a symmetric matrix and c a vector:
%    ellipse with equation (x-c)^T h_E (x-c) = 1 is plotted
% (if c is not provided, ellipse is centered at the origin)

cla;
set(gca, 'Color', 'k');
hold on;
plot(p1(1,:), p1(2,:), 'ro');
plot(p2(1,:), p2(2,:), 'go');
axis(axis+.5*[-1 1 -1 1]);
if nargin > 2
   if min(size(h_E)) == 1 && max(size(h_E)) == 2 
      plotline(h_E(1), h_E(2), c);
   elseif size(h_E) == [2 2]
      if nargin == 3
          c = zeros(size(h_E,1), 1);
      end
      plotellips(h_E, c); 
   else
      set(gca, 'Color', .2*[2 1 1]);
   end
end
hold off;
figure(gcf);
end

function plotline(a, b, c)
ext = 10;
tmp = axis;
plot(c/a*[ext -(ext+1)], c/b*[-(ext+1) ext], 'y-');
axis(tmp);
end

function plotellips(E, center)
nPoints = 250; 		 	% Number of points to be plotted on the ellipse 
[V, D] = eig(full(E));     
V = V * D^(-1/2);
index = (1:nPoints)*pi*2/nPoints;   
Point = V * [cos(index) ; sin(index)] + center * ones(1, nPoints); 
plot(center(1),center(2),'yx',Point(1,:),Point(2,:),'y-');
end
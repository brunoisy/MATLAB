function d = point_to_line(pts, v1, v2)
%https://nl.mathworks.com/matlabcentral/answers/95608-is-there-a-function-in-matlab-that-calculates-the-shortest-distance-from-a-point-to-a-line

% pt should be nx3
% v1 and v2 are vertices on the line (each 1x3)
% d is a nx1 vector with the orthogonal distances
v1 = repmat(v1,size(pts,1),1);
v2 = repmat(v2,size(pts,1),1);
a = v1 - v2;
b = pts - v2;
d = sqrt(sum(cross(a,b,2).^2,2)) ./ sqrt(sum(a.^2,2));
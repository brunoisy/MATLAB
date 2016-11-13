function gradG = computeGradG(x,y,xStar,epsilon)
% computes gradient of

n = length(x)-2;
gradG = zeros(1,n+2);
for i = 1:n+2
    yTilde1 = y;
    yTilde1(i) = yTilde1(i) + epsilon;
    yTilde2 = y;
    yTilde2(i) = yTilde2(i) - epsilon;
    sigmaTilde1 = naturalCubicSplines(x,yTilde1);
    cubicSpline1 = makeS2(x,yTilde1,sigmaTilde1);
    
    sigmaTilde2 = naturalCubicSplines(x,yTilde2);
    cubicSpline2 = makeS2(x,yTilde2,sigmaTilde2);
    
    gradG(i) = (cubicSpline1(xStar)-cubicSpline2(xStar))/(2*epsilon);
end

end


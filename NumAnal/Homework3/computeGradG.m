function gradG = computeGradG(x,y,xStar,epsilon)
% computes gradient of g, the natural cubic spline interpolating (x,y), at
% point xStar

n = length(x)-2;
gradG = zeros(1,n);

for i = 2:n+1
    yTilde1 = y;
    yTilde1(i) = yTilde1(i) + epsilon;
    yTilde2 = y;
    yTilde2(i) = yTilde2(i) - epsilon;
    [~, gammaTilde1] = ncsInterpol(x,yTilde1);
    splineFun1 = makeSplineFun(x,yTilde1,gammaTilde1);
    
    [~, gammaTilde2] = ncsInterpol(x,yTilde2);
    splineFun2= makeSplineFun(x,yTilde2,gammaTilde2);
    
    gradG(i-1) = (splineFun1(xStar)-splineFun2(xStar))/(2*epsilon);
end

end


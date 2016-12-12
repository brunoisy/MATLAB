function y= beta(x)

B1 = @(x) x.^3/6;
B2 = @(x) (-3*x.^3+3*x.^2+3*x+1)/6;
B3 = @(x) (3*x.^3-6*x.^2+4)/6;
B4 = @(x) (1-x).^3/6;

if (-3<=x)&&(x<=-2)
    y=B1(x+3);
elseif (-2<=x)&&(x<=-1)
    y=B2(x+2);
elseif (-1<=x)&&(x<=0)
    y=B3(x+1);
elseif (0<=x)&&(x<=1)
    y=B4(x);
else
    y=0;
end

end
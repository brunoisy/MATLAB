function y = B(N, x)
% N must be between 1 and 4

B1 = @(x) x^3/6;
B2 = @(x) (-3*x^3+3*x^2+3*x+1)/6;
B3 = @(x) (3*x^3-6*x^2+5)/6;
B4 = @(x) (1-x)^3/6;

if(N==1)
    y=B1(x);
elseif(N==2)
    y=B2(x);
elseif(N==3)
    y=B3(x);
elseif(N==4)
    y=B4(x);
end

end
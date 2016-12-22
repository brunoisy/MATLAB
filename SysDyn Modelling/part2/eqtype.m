function [t] = eqtype(a, b)
if real(a) > real(b)
    t = eqtype(b, a);
else
    eps = 1e-6;
    if abs(imag(a)) > eps
        if abs(real(a)) < eps
            t = 11;
        elseif real(a) < 0
            t = 9;
        else
            t = 10;
        end
    else
        a = real(a);
        b = real(b);
        if abs(a-b) < eps
            if abs(a) < eps
                t = 8;
            elseif a < 0
                t = 6;
            else
                t = 7;
            end
        else
            if abs(b) < eps
                t = 4;
            elseif abs(a) < eps
                t = 5;
            elseif b < 0
                t = 1;
            elseif a > 0
                t = 2;
            else
                t = 3;
            end
        end
    end
end
end

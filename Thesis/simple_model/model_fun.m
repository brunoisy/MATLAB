function [ f ] = model_fun(Lc, x, maxf )

global C

if (x < max(Lc))
    LcSup = Lc(Lc>x);
    f = -C*(1./(4*(1-x/min(LcSup)).^2)-1/4+x/min(LcSup));
    if (abs(f) > maxf) % unrealistically strong force
        if(length(LcSup)>1)
            f = -C*(1./(4*(1-x/min(LcSup(2:end))).^2)-1/4+x/min(LcSup(2:end)));
        else
            f = 0;
        end
    end
else
    f = 0;
end

end


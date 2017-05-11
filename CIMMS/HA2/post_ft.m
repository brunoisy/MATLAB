function [ft] = post_ft(t,lambda)

if((t(2:end)-t(1:(end-1))) > 0)
    ft = exp(-sum(lambda.*(t(2:end)-t(1:(end-1)))))*prod(t(2:end)-t(1:(end-1)));
else
    ft = 0;
end

end

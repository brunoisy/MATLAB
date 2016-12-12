function [lambda, iCut, tCut] = LyapunovExponent(Tout,deltaTnorm)
% This function returns the approximated Lyapunouv exponent, iCut the index
% in Tout off the cutoff time and tCut the cutoff time. It takes time vector 
% Tout and the norm of the error deltatNorm in argument.

logDeltaTnorm = log10(deltaTnorm);
j=0;
for i = 1:size(Tout,1)
   t = Tout(i);
   if(logDeltaTnorm(i) > 0.8*mean(logDeltaTnorm(i:i+1000)))
       j = j+1;
       if j==100
           iCut = i;
           tCut = t;
           break
       end
   else
       j=0;
   end
end

lambda = (mean(logDeltaTnorm(iCut:end))-logDeltaTnorm(1))/tCut; 
end
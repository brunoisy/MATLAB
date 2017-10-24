function [ F ] = model_fun(X, x0, Lc, fmax)

n = length(X);
padding = sum(X<x0);
% Xcut = Lc-5*10^-9;
% 

% F = zeros(1,n-padding);
% for i=1:length(Lc)
%     if i==1
%         F(0<=X & X<Xcut(i)) = fd(Lc(i), X(0<=X & X<Xcut(i)));
%     else
%         F(Xcut(i-1)<=X & X <Xcut(i)) = fd(Lc(i), X(Xcut(i-1)<=X & X <Xcut(i)));
%     end
% %     plop = find(F<-fmax);
% %     if ~isempty(plop)
% %         j = plop(1)
% %         Lc(i) = X(j);
% %         F(X>X(j)) = zeros(1,length(F(X>X(j))));
% %     end
% end
% 
% F = [zeros(1,padding), F];
F = zeros(1,n-padding);
for i = 1:(n-padding)
    if  X(i) < Lc(end)
        LcSup = Lc(Lc>X(i));
        F(i) = fd(LcSup(1), X(i));
        if(F(i) < -fmax)
            if length(LcSup) >1
                F(i) = fd(LcSup(2), X(i));
            else
                F(i) = 0;
            end
        end
    end
end
F = [zeros(1,padding), F];
end
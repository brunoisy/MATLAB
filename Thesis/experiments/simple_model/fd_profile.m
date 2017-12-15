function [ F ] = fd_profile(X, Lc, Xunfold)
addpath('functions')

F = zeros(1,length(X));
for i = 1:length(Xunfold)
    if i == 1
        F(X<=Xunfold(i)) = fd(Lc(i), X(X<=Xunfold(i)));
    else
        F(Xunfold(i-1)<X & X<=Xunfold(i)) = fd(Lc(i), X(Xunfold(i-1)<X & X<=Xunfold(i)));
    end
end
end
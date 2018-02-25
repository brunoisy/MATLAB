function [deltas] = get_deltas(meanLc, Lcs)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

deltas = zeros(1,length(Lcs(1,:)));
for i = 1:length(Lcs(1,:))
    deltas(i) = mean(meanLc - Lcs(:,i));
end
end
function [deltas, MSE] = allign(meanLc, Lcs)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

deltas = zeros(1,length(Lcs(1,:)));
MSE = 0;
for i = 1:length(Lcs(1,:))
    deltas(i) = mean(meanLc - Lcs(:,i));
    Lci_tilde = Lcs(:,i)+deltas(i);
    TSE = sum((meanLc - Lci_tilde).^2);% Total Square Error over all elements of Lc %max((meanLc - Lci_tilde).^2);
    MSE = MSE + TSE; % Mean Square Error over all vectors of Lcs
end
MSE = MSE/length(Lcs(1,:));
end
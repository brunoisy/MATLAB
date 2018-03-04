function [inliers] = distfn_clustering(meanLc, Lcs, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

inliers = [];
for i = 1:length(Lcs(1,:))
    deltai = mean(meanLc - Lcs(:,i));
    Lci_tilde = Lcs(:,i)+deltai;
    TSE = sum((meanLc - Lci_tilde).^2);% Total Square Error over all elements of Lc
%     maxSE = max((meanLc - Lci_tilde).^2);%...
    if TSE < thresh%maxSE<thresh
        inliers = [inliers, i];
    end
end
end
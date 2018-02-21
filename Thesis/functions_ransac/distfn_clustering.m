function [inliers, deltas] = distfn_clustering(Lc_mean, Lcs, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

inliers = [];
deltas = [];
for i = 1:length(Lcs(1,:))
    deltai = mean(Lc_mean - Lcs(:,i));
    Lci_tilde = Lcs(:,i)-deltai;
    MSE = mean((Lc_mean - Lci_tilde).^2);
    if MSE < thresh
        inliers = [inliers, i];
        deltas = [deltas, deltai];
    end
end
end
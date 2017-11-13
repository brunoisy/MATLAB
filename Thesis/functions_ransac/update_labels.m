function [labels] = update_labels(labels, inliers, labelnumber)
%UPDATE_LABELS Summary of this function goes here
%   Detailed explanation goes here

newlabels = zeros(1, sum(labels == 0));
newlabels(inliers) = labelnumber*ones(1, length(inliers));
labels(labels == 0) = newlabels;
end


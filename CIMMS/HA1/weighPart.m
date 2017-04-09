function [ w] = weighPart( X )
%WEIGHPART Summary of this function goes here
%   Detailed explanation goes here
load('RSSI-measurements')
s = size(X);
N = s(2);

w = zeros(1,N);
for i=1:N %vectorise
    w(i) = p(Y(:,1), X(:,i));
end

end


function seq = to_sequence(Lc)
%TO_SEQUENCE Summary of this function goes here
%   Detailed explanation goes here


Lc = round(Lc/0.36);
seq = repmat('A',1,Lc(end)-Lc(1)+length(Lc));% a.a. are represented by zeros
Lc-Lc(1)+1
seq(Lc-Lc(1)+1) = 'G';% unfolding points are represented by ones

end
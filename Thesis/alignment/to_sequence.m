function seq = to_sequence(Lc)
%TO_SEQUENCE Summary of this function goes here
%   Detailed explanation goes here


Lc = floor(Lc/0.36)+1;
seq = repmat('A',1,Lc(end)+length(Lc));% a.a. are represented by A
seq(Lc) = 'G';% unfolding points are represented by G

end

function [brb]= b_redblack(b)
%l'argument b correspond au vecteur
%b du systeme initial de la question 1
brb = 0*b;

n=sqrt(length(b));
if mod(n^2,2)==0
    bb = zeros(n^2/2,1);
    br = zeros(n^2/2,1);
    for i=1:n^2
        if mod(i,2)==0
            bb(i/2) = b(i);
        else
            br(ceil(i/2))=b(i);
        end
    end
    brb = [bb;br];
else
    black = floor(n^2/2);
    red =  n^2-black;
    bb = zeros(black,1);
    br = zeros(red,1);
    for i=1:n^2
        if mod(i,2)==0
            bb(i/2) = b(i);
        else
            br(ceil(i/2))=b(i);
        end
    end
    brb = [bb;br];
end

end
function delta = minLSQ_align(templateLc, Lc)
%MSEALIGN Summary of this function goes here
%   Detailed explanation goes here

bestDelta = 0;
bestError = Inf;
for delta = -50:.1:50
    shiftedLc = Lc+delta;
    error = 0;
    if length(shiftedLc) <= length(templateLc)
        for Lci = shiftedLc
            error = error + min(abs(templateLc-Lci))^2;
        end
    else
        for Lci = templateLc
            error = error + min(abs(shiftedLc-Lci))^2;
        end
    end
    if error < bestError
        bestDelta = delta;
        bestError = error;
    end
end
delta = bestDelta;

end


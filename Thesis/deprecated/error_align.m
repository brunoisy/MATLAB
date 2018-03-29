function error = error_align(shift, Lcs)
%ERROR_ALIGN Summary of this function goes here
%   Detailed explanation goes here

templateLc = Lcs{1,:};
thisLc = Lcs{2,:};
error = 0;
if length(thisLc) <= length(templateLc)
   for Lci = shift+thisLc 
       error = error + min(abs(templateLc-Lci))^2;
   end
end

end


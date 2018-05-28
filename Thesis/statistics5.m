% allLcs = [34.4800,  54.5995,   92.3607,  118.0434,  140.5817];
allLcs = [34.4800, 43.5, 54.5995,  77,  92.3607,  118.0434,  140.5817];
thresh = 1.5;
hasPeak = false(length(allLcs)*2+1, 100);
for tracenumber = 1:100
    if npeaks(tracenumber) > 1
        thisLc = exhLcs{tracenumber};
        for i=1:length(thisLc)
            [mindiff, I] = min(abs(allLcs-thisLc(i)));
            if mindiff < thresh
                hasPeak(2*I, tracenumber) = true;% we have one of the peaks
            else
                if thisLc(i) < allLcs(I)
                    hasPeak(2*I-1, tracenumber) = true;
                else
                    hasPeak(2*I+1, tracenumber) = true;
                end
            end
        end
    end
end
hasPeak = hasPeak(:,npeaks>1);
N = size(hasPeak,2);


for i= 1%1:2%1:4
   peak1 = i*2;
   peak2 = (i+1)*2;
  
   pHasNone = size(hasPeak(:, ~hasPeak(peak1,:) & ~hasPeak(peak2,:)),2)/N
   pHas1no2 = size(hasPeak(:, hasPeak(peak1,:) & ~hasPeak(peak2,:)),2)/N
   pHas2no1 = size(hasPeak(:, ~hasPeak(peak1,:) & hasPeak(peak2,:)),2)/N
   pHas12   = size(hasPeak(:, hasPeak(peak1,:) & hasPeak(peak2,:)),2)/N
   
   
%    hasBothPeaks = hasPeak(:, hasPeak(peak1,:) & hasPeak(peak4,:))
%    pHasNoPeak23 = size(hasBothPeaks(:, ~hasBothPeaks(peak2,:) & ~hasBothPeaks(peak3,:)),2)/size(hasBothPeaks,2)
%    pHasPeak2no3 = size(hasBothPeaks(:, hasBothPeaks(peak2,:) & ~hasBothPeaks(peak3,:)),2)/size(hasBothPeaks,2)
%    pHasPeak3no2 = size(hasBothPeaks(:, ~hasBothPeaks(peak2,:) & hasBothPeaks(peak3,:)),2)/size(hasBothPeaks,2)
%    pHaspeak23   = size(hasBothPeaks(:, hasBothPeaks(peak2,:) & hasBothPeaks(peak3,:)),2)/size(hasBothPeaks,2)
end

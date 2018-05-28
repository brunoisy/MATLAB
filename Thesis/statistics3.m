% allLcs = [34.4800,  54.5995,   92.3607,  118.0434,  140.5817];
allLcs = [34.4800, 43.5, 54.5995,  77,  92.3607,  118.0434,  140.5817];
thresh = 1.5;
hasPeak = false(length(allLcs), 100);
for tracenumber = 1:100
    if npeaks(tracenumber) > 1
        thisLc = exhLcs{tracenumber};
        for currPeak=1:length(thisLc)
            [mindiff, I] = min(abs(allLcs-thisLc(currPeak)));
            if mindiff < thresh
                hasPeak(I, tracenumber) = true;
            end
        end
    end
end
hasPeak = hasPeak(:,npeaks>1);


pPeaks = zeros(length(allLcs),length(allLcs)+1);
for i = 1:length(allLcs)
    hasPeakij = hasPeak(:,hasPeak(i,:));
    for j=(i+1):length(allLcs)
        pPeaks(i,j) = sum(hasPeakij(j, :))/sum(hasPeak(i,:));
        hasPeakij = hasPeakij(:,~hasPeakij(j,:));
    end
    pPeaks(i,length(allLcs)+1) = 1- sum(pPeaks(i,1:end-1));
    
end
pPeaks

pPeaks = zeros(length(allLcs),length(allLcs)+1);
for i = 1:length(allLcs)
    hasPeakij = hasPeak(:,~hasPeak(i,:));
    for j=(i+1):length(allLcs)
        pPeaks(i,j) = sum(hasPeakij(j, :))/sum(~hasPeak(i,:));
        hasPeakij = hasPeakij(:,~hasPeakij(j,:));
    end
    pPeaks(i,length(allLcs)+1) = 1- sum(pPeaks(i,1:end-1));
end
pPeaks

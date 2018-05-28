allLcs = [34.4800,  54.5995,   92.3607,  118.0434,  140.5817];
% allLcs = [34.4800, 43.5, 54.5995,  77,  92.3607,  118.0434,  140.5817];
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

for i=1%1:2%1:4
   peak1 = i*2;
   peak2 = (i+1)*2;
   peak3 = (i+2)*2;
   peak4 = (i+3)*2;
   hasBothPeaks = hasPeak(:, hasPeak(peak1,:) & hasPeak(peak4,:))
   pHasNoPeak23 = size(hasBothPeaks(:, ~hasBothPeaks(peak2,:) & ~hasBothPeaks(peak3,:)),2)/size(hasBothPeaks,2)
   pHasPeak2no3 = size(hasBothPeaks(:, hasBothPeaks(peak2,:) & ~hasBothPeaks(peak3,:)),2)/size(hasBothPeaks,2)
   pHasPeak3no2 = size(hasBothPeaks(:, ~hasBothPeaks(peak2,:) & hasBothPeaks(peak3,:)),2)/size(hasBothPeaks,2)
   pHaspeak23   = size(hasBothPeaks(:, hasBothPeaks(peak2,:) & hasBothPeaks(peak3,:)),2)/size(hasBothPeaks,2)
end


% pPeaks = zeros(length(allLcs)*2,length(allLcs)*2);
% for i = 1:length(allLcs)*2
%     hasPeakij = hasPeak(:,hasPeak(i,:));
%     for j=(i+1):length(allLcs)*2
%         pPeaks(i,j) = sum(hasPeakij(j, :))/sum(hasPeak(i,:));
%         hasPeakij = hasPeakij(:,~hasPeakij(j,:));
%     end
% end
% pPeaks


% 
% pPeaks = zeros(4,length(allLcs)-1);
% for i = 1:length(allLcs)-1
%     currPeak = 2*i;
%     hasPeak1 = hasPeak(:,hasPeak(currPeak,:));
%     pPeaks(1,i) = sum(hasPeak1(currPeak+1,:))/size(hasPeak1,2);
%     hasPeak10 = hasPeak1(:, ~hasPeak1(currPeak+1,:));
%     pPeaks(2,i) = sum(hasPeak10(currPeak+2,:))/size(hasPeak1,2);
%     hasPeak100 = hasPeak10(:, ~hasPeak10(currPeak+2,:));
%     pPeaks(3,i) = 1-pPeaks(1,i)-pPeaks(2,i);%sum(hasPeak100(currPeak+3,:))/size(hasPeak1,2);
%     
%     
%     pPeaks(4,i) = sum(hasPeak1(currPeak+2,:))/size(hasPeak1,2);
% end
% pPeaks

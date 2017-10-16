  n_average = 11;%odd plz
    half_av = floor(n_average/2);
    moving_average = zeros(1, n-n_average);
    for i = 1:n_average
        moving_average = moving_average + force(i:n-1+i-n_average);
    end
    moving_average = moving_average/n_average;
    
    maxmin = 15;
    locmin = zeros(2,maxmin);
    nmin = 0; %number of minimas
    for i = half_av:(n-half_av)
       if force(i)>1.1*moving_average(i-half_av+1)
           nmin = nmin+1;
           locmin(:,nmin) = [dist(i); force(i)];
       end
    end
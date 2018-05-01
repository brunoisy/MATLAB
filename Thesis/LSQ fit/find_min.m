function [ mins ] = find_min(dist, force, interval_length)
mins = [];
for i=1:length(force)
    if force(i) <= min(force(dist(i)-interval_length/2 < dist & dist < dist(i)+interval_length/2))
        mins = [mins, [dist(i); force(i)]];
    end
end
end
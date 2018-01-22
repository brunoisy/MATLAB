n = 50;
m = 50;
A = sparse(n*m,n*m); % adjacency matrix


% horizontal links
for i = n:-1:1
    for j = 1:i-1
        A(i+n*(i-1),i+n*(j-1)) = 0;
    end
end

% vertical links
for j=1:m
    for i=j+1:n
        A(i+n*(j-1),j+n*(j-1)) = 1;%weight inversely prop to node density
    end
end



% Ln = 220;
% Lm = 220;

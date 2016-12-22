function [] = bifurcations(k_1, k_2, k_3, U, V, C, D, colort)
if nargin < 8
    colort = true;
end
figure;
if numel(U) > 1
    for u = U
        addeq(k_1, k_2, k_3, u, V, C, D, colort);
    end
elseif numel(V) > 1
    for v = V
        addeq(k_1, k_2, k_3, U, v, C, D, colort);
    end
else
    addeq(k_1, k_2, k_3, U, V, C, D, colort);
end
xlabel('x_2');
ylabel('x_3');
end

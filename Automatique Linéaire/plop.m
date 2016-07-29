zeta = 0.55;
w = 1;
CG = tf(w^2, [1, 2*zeta*w, 0]);
[thetaM, PhiM, ~, Wc] = margin(CG)
figure
bode(CG);
figure
nyquist(CG);

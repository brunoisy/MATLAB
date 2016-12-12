function gfunc = g_evalBsplines(g, TU, const )

%***************************************************%
%   LINMA 2171: Numerical Analysis                  %
%   Approximation, Interpolation, Integration       %
%                                                   %
%   Prof. : P.-A. Absil                             %
%   Teaching assistant: S. Dong       				%
%***************************************************%

% Input
% 1) g: size [q1,q2] : the "coordinates" of the surface g in the basis {\delta_j1 \otimes \epsilon_j2}
% 2) TU: struct : the 2D evaluation grid
	% .<Te,Ue>: [|Te|,] [|Ue|,1] sequences in each of the 2 dims of the 2D grid 
	% Note: [Te(1), Te(end)] x [Ue(1), Ue(end)] = T x U 
% 3) const: struct 
	% .<tau/nu>: {tau_r}, {nu_s} equidistant sequences in each of the 2 dims of the "basis grid".
	% Note: [tau(1), tau(end)] x [nu(1), nu(end)] = T x U 
	% .<d/e> : unit spacing of {tau}, {nu} (optional)
% Output
% 1) gfunc: size [|Te|, |Ue|] : the image/surface g evaluated on the grid TU  

% If there is any question, contact: shuyu.dong@uclouvain.be  

tau = const.tau;
nu = const.nu;
d = tau(2) - tau(1);
e = nu(2) - nu(1);
m1 = length(tau);% -2?
m2 = length(nu);% -2?
Te = TU.Te;
Ue = TU.Ue;

[Xe, Ye] = meshgrid(Te, Ue);
if size(g,2) <= 1
	gmatrix = reshape(g, [length(nu)+2, length(tau)+2]);
	gmatrix = gmatrix';
else
	gmatrix = g;
end
gfunc = zeros(length(Te),length(Ue));

for r = 1 : m1-1
	for s = 1 : m2-1
		indx = intersect(find( Te>=tau(r)), find(Te <=tau(r+1)) );
		indy = intersect(find( Ue>=nu(s)), find(Ue <=nu(s+1)) );
		n1l = length(indx);
		n2l = length(indy);
		if n1l*n2l > 0
			Tlocal = (Te(indx) - tau(r))/d;
			Ulocal = (Ue(indy) - nu(s))/e; 
			foo = zeros(n1l, n2l);
			BTlocal = compute_B(Tlocal);
			BUlocal = compute_B(Ulocal);
			glocal = zeros(16,1);
			for j1 = r : r+ 3
				for j2 = s : s+3
                     j1
                     j2
                     j1j2 = j1+j2
                     g =gmatrix(j1,j2)
                     b1 = BTlocal(:,4+r-j1)
                     b2 = BUlocal(:,4+s-j2)
                    
					foo = foo + gmatrix(j1,j2)* BTlocal(:,4+r-j1)*BUlocal(:,4+s-j2)';
				end
			end
			gfunc(indx, indy) = foo;
		end
	end
end

% % to visualize gfunc [|Te|, |Ue|]
% figure(); surf(Xe', Ye',gfunc);
% figure(); imagesc(gfunc);
function B = compute_B(Xe, const)

%***************************************************%
%   LINMA 2171: Numerical Analysis                  %
%   Approximation, Interpolation, Integration       %
%                                                   %
%   Prof. : P.-A. Absil                             %
%   Teaching assistant: S. Dong       				%
%***************************************************%

% Input 
% 1) Xe: size [|Xe|,] : evaluation points in 1D
% 2) const: struct
		% .<Bfunc>: contains the 4 cubic splines function 
% Output
% 1) B: size [|Xe|,4] : 4x1D-evaluations

% If there is any question, contact: shuyu.dong@uclouvain.be  


if nargin < 2 || ~isfield(const,'Bfunc')
	Bfunc{1} = @(x) (x.^3 / 6);
	Bfunc{2} = @(x)(-3*x.^3 + 3*x.^2 + 3*x + 1) / 6;
	Bfunc{3} = @(x)(3*x.^3 - 6*x.^2 + 4) / 6;
	Bfunc{4} = @(x) (1-x).^3 / 6;
else
	Bfunc = const.Bfunc;
end


B = zeros(length(Xe),4);
for j =  1 : 4
	B(:,j) = Bfunc{j}(Xe);
end

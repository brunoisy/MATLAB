  function beautifulCurve()
  T = [0 0 0 0 1 2 2 2 3];     X = [0 1 2 3 4];     Y = [0 3 0 3 0];
  p = 3; n = length(T)-1;      t = [T(p+1):0.05:T(n-p+1)];
  for i=0:n-p-1
    B(i+1,:) = b(t,T,i,p);
  end
  plot(X*B,Y*B);                                               
  end

  function u = b(t,T,j,p)
  i = j+1;
  if p==0
    u = (t>= T(i) & t < T(i+p+1)); return
  end
  u = zeros(size(t));
  if T(i) ~= T(i+p)
    u = u + ((t-T(i)) / (T(i+p) -T(i))) .* b(t,T,j,p-1);
  end
  if T(i+1) ~= T(i+p+1)
    u = u + ((T(i+p+1)-t) ./ (T(i+p+1) -T(i+1))) .* b(t,T,j+1,p-1);
  end
  end
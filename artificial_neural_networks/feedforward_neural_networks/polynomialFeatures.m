function X_poly = polynomialFeatures(X, degree)
  
  % For X with two features
  X1 = X(:,1);
  X2 = X(:,2);
  
  X_poly = ones(size(X1(:,1)));
  
  for i=1:degree
    for j=0:i
      X_poly(:,end+1) = (X1.^(i-j)) .* (X2.^j);
    endfor
  endfor
  
  X_poly = X_poly(:, 2:end);
  
end
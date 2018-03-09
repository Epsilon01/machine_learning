function cost = costFunction(X, y, weights)
  
  m = size(X,1); % number of training examples
  
  cost = 1/(2*m) * sum((X * weights - y).^2);
  
end
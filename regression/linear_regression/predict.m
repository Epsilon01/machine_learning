function p = predict(X, weights)
  
  m = size(X,1); % number of training examples
  X = [ones(m,1) X];
  
  p = X*weights;
  
end
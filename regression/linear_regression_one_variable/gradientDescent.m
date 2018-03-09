function [weights cost_hist] = gradientDescent(X, y, weights, alpha, num_iters)
  
  m = size(X,1); % number of training examples
  cost_hist = zeros(num_iters,1);
  
  % Add a column of ones (bias unit)
  X = [ones(m,1), X];
  
  for i=1:num_iters
    tmp = sum(((X*weights-y).*X),1);
    weights = weights - alpha/m * tmp';
  
    cost_hist(i) = costFunction(X, y, weights);
  endfor
  
end
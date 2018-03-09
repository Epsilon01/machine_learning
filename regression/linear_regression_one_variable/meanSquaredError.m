function error = meanSquaredError(y, p)
  
  m = length(y);% number of training examples
  
  error = 1/m * sum((y-p).^2, 1);
  
end
function g = sigmoid(z)

  % Brief: compute the sigmoid function
  %
  % Parameter
  %   z - 
  %
  % Returns:
  %   J = sigmoid(z) computes the sigmoid of z.

  
  
  g = 1.0 ./ (1.0 + exp(-z));
  
end

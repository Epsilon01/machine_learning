function g = softmax(z)
  
  g = exp(z) ./ sum(exp(z));
  
end
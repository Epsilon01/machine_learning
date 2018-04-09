function g = softmax(z)
  
  z = bsxfun(@minus, z, max(z, [], 1));
  z = exp(z);  
  g = bsxfun(@rdivide, z , sum(z));
  
end
function [X_norm] = centerFeatures(X)
  
  mu = mean(X);
  X_norm = bsxfun(@minus, X, mu);
  
end
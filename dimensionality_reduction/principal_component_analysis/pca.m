function [U, S] = pca(X)
  
  m = size(X,1); % number of training examples
  
  Sigma = 1/m*X'*X; % covariance matrix
  [U,S,V] = svd(Sigma);
  
end
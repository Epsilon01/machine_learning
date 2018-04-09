function W = initializeWeightsDebug(size_in, size_out)
  
  W = zeros(size_out, size_in);
  
  % Initialize with the sin function for debug
  W = reshape(sin(1:numel(W)), size(W)) /10;
  
end
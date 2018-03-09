function checkGradients(lambda)
  
  m = 5;
  input_layer_size = 2;
  hidden_layer_size = 3;
  output_layer_size = 2;
  
  W1 = initializeWeightsDebug(hidden_layer_size, input_layer_size);
  W2 = initializeWeightsDebug(output_layer_size, hidden_layer_size);
  nn_weights = [W1(:) ; W2(:)];
  
  X = initializeWeightsDebug(m, input_layer_size-1);
  y = mod(1:m, output_layer_size)';
  
  costFunc = @(p) costFunction(X, y, lambda, p, ...
                               input_layer_size, ...
                               hidden_layer_size, ...
                               output_layer_size);
  
  [cost grad] = costFunc(nn_weights);
  num_grad = computeNumericalGradients(costFunc, nn_weights);
  
  disp([num_grad grad]);
  
  diff = norm(num_grad - grad)/norm(num_grad+grad);
  disp('diff '), disp(diff);
  
end
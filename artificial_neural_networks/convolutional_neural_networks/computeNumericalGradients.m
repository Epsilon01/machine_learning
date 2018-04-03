function num_grad = computeNumericalGradients(costFunction, nn_weights)
  
  % Brief:
  %
  % Parameters:
  %   cost        - 
  %   nn_weights  - 
  %
  % Returns:
  %   num_grad - 
  
  
  
  % Initialization -------------------------------------------------------------
  num_grad = zeros(size(nn_weights));
  epsilon = 1e-4;
  
  
  
  % Compute numerical gradients ------------------------------------------------
  for i = 1:length(num_grad)
    
    old_t = nn_weights(i);
    
    nn_weights(i) = old_t + epsilon;
    loss_pos = costFunction(nn_weights);
    
    nn_weights(i) = old_t - epsilon;
    loss_neg = costFunction(nn_weights);
    
    num_grad(i) = (loss_pos - loss_neg)/(2*epsilon);
    nn_weights(i) = old_t;
    
  endfor
  
end
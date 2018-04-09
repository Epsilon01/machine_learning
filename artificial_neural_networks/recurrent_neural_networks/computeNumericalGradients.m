function num_grad = computeNumericalGradients(costFunc, nn_weights)
  
  num_grad = zeros(size(nn_weights));
  perturb  = zeros(size(nn_weights));  
  
  epsilon = 1e-3;
  
  for i = 1:numel(nn_weights)  
    perturb(i) = epsilon;
    loss1 = costFunc(nn_weights - perturb);
    loss2 = costFunc(nn_weights + perturb);
    num_grad(i) = (loss2 - loss1)/(2*epsilon);
    perturb(i) = 0;    
  endfor
  
end
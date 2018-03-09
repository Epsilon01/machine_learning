function [error_train, error_cv] = ...
          learningCurves(X, y, ...
                         X_cv, y_cv, ...
                         lambda, nn_weights_initial, ...
                         input_layer_size, ...
                         hidden_layer_size, ...
                         output_layer_size)
          
  m = size(X,1); % number of training examples
  
  error_train = zeros(m,1);
  error_cv    = zeros(m,1);
  
  options = optimset('MaxIter', 50);

  for i=1:m
    
    % Training
    costFuncTrain = @(p) costFunction(X(1:i,:), y(1:i,:), lambda, p, ...
                                      input_layer_size, ...
                                      hidden_layer_size, ...
                                      output_layer_size);
    [nn_weights, dummy] = fmincg(costFuncTrain, nn_weights_initial, options);
    
    % Training set                                
    [cost_train, dummy] = costFuncTrain(nn_weights);
    error_train(i) = cost_train;
    
    % Cross-validation set
    costFuncCV = @(p) costFunction(X_cv, y_cv, lambda, p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   output_layer_size);
                                
    [cost_cv, dummy] = costFuncCV(nn_weights);
    error_cv(i) = cost_cv;    
    
  endfor
          
end
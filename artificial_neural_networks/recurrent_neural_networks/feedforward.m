function [a2, a3] = feedforward(X, nn_weights, options)
  
  % Brief: feedforward the neural network with X and nn_weights
  %
  % Parameters
  %   X           - data set
  %   nn_weights  - weights
  %   options     - hyperparameters
  %
  % Returns
  %   a2  - outputs of the hidden layer
  %   a3  - outputs of the neural network
  
  
  
  n = size(X,2); % number of words
  
  [W1, Wh, W2] = paramsToStack(nn_weights, options);
  
  a2 = zeros(options.hlayer_size,n);
  a3 = zeros(options.olayer_size,n);
  
  % Feedforward ----------------------------------------------------------------
  if iscell(X)
    a1 = cell2mat(X); % size(a1) = m
  else
    a1 = X;
  endif
  
  
  for t=1:n % for each word
    
    % Hidden layer
    if(t==1)
      z2 = W1(:,a1(t)); % size(z2) = hidden_layer_size x 1
    else
      z2 = W1(:,a1(t)) + Wh*a2(:,t-1);
    endif
    
    a2(:,t) = tanh(z2);
    
    % Output layer
    z3 = W2*a2(:,t); % size(z3) = output_layer_size x 1
    a3(:,t) = softmax(z3);
  endfor
  
end
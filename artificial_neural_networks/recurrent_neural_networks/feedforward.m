function [a2, a3] = feedforward(X, ...
                                nn_weights, ...
                                input_layer_size, ...
                                hidden_layer_size, ...
                                output_layer_size)
  
  n = size(X,2); % number of words
  
  % Weights of the 1st layer
  W1_size = hidden_layer_size*input_layer_size;
  W1 = reshape(nn_weights(1:W1_size), hidden_layer_size, input_layer_size);
  
  % Weights of the hidden layer
  Wh_size = hidden_layer_size*hidden_layer_size;
  Wh = reshape(nn_weights(W1_size+1:W1_size+Wh_size), hidden_layer_size, hidden_layer_size);
  
  % Weights of the 2nd layer
  W2 = reshape(nn_weights(W1_size+Wh_size+1:end), output_layer_size, hidden_layer_size);
  
  a2 = zeros(hidden_layer_size,n);
  a3 = zeros(output_layer_size,n);
  
  % Feedforward ----------------------------------------------------------------
  if iscell(X)
    a1 = cell2mat(X); % size(a1) = m
  else
    a1 = X;
  endif
  
    
  for t=1:n
    
    % Hidden layer
    if(t==1)
      z2 = W1(:,a1(t)); % size(z2) = hidden_layer_size x 1
    else
      z2 = W1(:,a1(t)) + Wh*a2(:,t-1);
    endif
    a2(:,t) = tanh(z2);
    
    % Output layer
    z3 = W2*a2(:,t); % size(z3) = input_layer_size x 1
    a3(:,t) = softmax(z3);
  endfor
  
end
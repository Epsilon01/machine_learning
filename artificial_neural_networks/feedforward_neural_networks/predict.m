function p = predict(X, ...
                     nn_weights, ...
                     input_layer_size, ...
                     hidden_layer_size, ...
                     output_layer_size)
  
  m = size(X, 1); % number of samples
  
  W1 = reshape(nn_weights(1:hidden_layer_size * (input_layer_size+1)), hidden_layer_size, input_layer_size+1);
  W2 = reshape(nn_weights((hidden_layer_size * (input_layer_size+1)+1):end), output_layer_size, hidden_layer_size+1);
  
%  size(W1) % 3x3
%  size(W2) % 2x4
  
  % Feedforward
  a1 = [ones(m,1), X]; % mx3
  
  z2 = a1 * W1'; % mx3
  a2 = tanh(z2); % mx3
  a2 = [ones(m,1), a2]; % mx4
  
  z3 = a2 * W2'; % mx2
  a3 = exp(z3) ./ sum(exp(z3)); % mx2
  
  [dummy p] = max(a3, [], 2);
  
end
function [J grad] = costFunction(X, ...
                                 y, ...
                                 lambda, ...
                                 nn_weights, ...
                                 input_layer_size, ...
                                 hidden_layer_size, ...
                                 output_layer_size)
  
  m = size(X, 1); % number of training examples
  
  W1 = reshape(nn_weights(1:hidden_layer_size * (input_layer_size+1)), hidden_layer_size, input_layer_size+1);
  W2 = reshape(nn_weights((hidden_layer_size * (input_layer_size+1)+1):end), output_layer_size, hidden_layer_size+1);
  
  % Turn the ground truth into logical arrays
  y_mat = eye(2)(y+1,:);
  
  
%  size(y) % m x 1
%  size(y_vec) % m x output_layer_size
%  size(W1) % 3x3
%  size(W2) % output_layer_size x hidden_layer_size+1
  
  % Feedforward ----------------------------------------------------------------
  a1 = [ones(m,1), X]; % m x input_layer_size+1
  
  z2 = a1 * W1'; % m x hidden_layer_size
  a2 = tanh(z2); % m x hidden_layer_size
  a2 = [ones(m,1), a2]; % m x hidden_layer_size+1
  
  z3 = a2 * W2'; % mx2
  a3 = exp(z3) ./ sum(exp(z3),2); % m x output_layer_size
  
  % Compute the loss function --------------------------------------------------
  W1_no_bias = W1(:,2:end);
  W2_no_bias = W2(:,2:end); % output_layer_size x hidden_layer_size
  
  J = -1/m * sum(sum(y_mat .* log(a3), 2),1);
  J += lambda/(2*m) * (sum(sum(W1_no_bias.^2,2),1) + sum(sum(W2_no_bias.^2,2),1)); % Regularization
  
  % Backpropagation ------------------------------------------------------------
  delta3 = a3 - y_mat; % m x output_layer_size
  delta2 = (1-(tanh(z2).^2)) .* (delta3 * W2_no_bias); % m x hidden_layer_size
  
  Delta1 = delta2' * a1; % hidden_layer_size x input_layer_size+1
  Delta2 = delta3' * a2; % output_layer_size x hidden_layer_size+1
  
  W1_bias_zero = [zeros(size(W1_no_bias,1),1) W1_no_bias];
  W2_bias_zero = [zeros(size(W2_no_bias,1),1) W2_no_bias];
  
  W1_grad = Delta1 .* 1/m + lambda/m * W1_bias_zero;
  W2_grad = Delta2 .* 1/m + lambda/m * W2_bias_zero;
  
  % Unroll gradients
  grad = [W1_grad(:) ; W2_grad(:)];
  
end
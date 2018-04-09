function grad = bptt(X, Y, ...
                     a2, a3, ...
                     nn_weights, ...
                     options)

  % Brief: run Backpropagation Through Time (BPTT)
  %
  % Parameters:
  %   X           - data set
  %   Y           - data labels
  %   a2          - ouputs of hidden layer
  %   a3          - outputs of neural network
  %   nn_weights  - weights
  %   options     - hyperparameters
  %
  % Returns
  %   grad  - gradients
  
  
  
  bptt_truncate = options.bptt_truncate;
  n = size(X,2);
  
  % Weights of the 1st layer
  [W1, Wh, W2] = paramsToStack(nn_weights, options);
  
  delta2 = zeros(size(W1));
  deltah = zeros(size(Wh));
  delta3 = zeros(size(W2));
  
  delta3_tmp = a3;
  
  % Y - a3
  idx = sub2ind(size(delta3_tmp), Y(:), [1:n]');
  delta3_tmp(idx) = (delta3_tmp(idx) - 1)/1.0;
  
  % For each word
  for t=n:-1:1
    delta3 = delta3 + (delta3_tmp(:,t) * a2(:,t)');
    % size(delta3_tmp(:,t)); = hidden_layer_size x 1
    delta_t = (W2' * delta3_tmp(:,t)) .* (1 - (a2(:,t).^2)); % size(delta_t) = hidden_layer_size x 1
    
    for bptt_step = t:-1:max(1,t-bptt_truncate)
      %
      if bptt_step-1>0
        deltah += delta_t' * a2(:,bptt_step-1);
      endif
      
      delta2(:,X(bptt_step)) += delta_t;
      
      % Update
      if bptt_step-1>0
        delta_t = (Wh' * delta_t) .* (1 - (a2(:,bptt_step-1).^2)); % size(delta_t) = hidden_layer_size x 1
      else
        delta_t = (Wh' * delta_t);
      end
    endfor
    
  endfor
  
  % Unroll gradients
  grad = [delta2(:); deltah(:); delta3(:)];
  grad = grad/n;
  
end
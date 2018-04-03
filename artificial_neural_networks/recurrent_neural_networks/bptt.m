function [grad] = bptt(X, Y, ...
                       a2, a3, ...
                       nn_weights, ...
                       input_layer_size, ...
                       hidden_layer_size, ...
                       output_layer_size)
  
%  W1_grad; % hidden_layer_size w input_layer_size
%  Wh_grad;
%  W2_grad; % 8000 x hidden_layer_size
  
  bptt_truncate = 4;
  n = size(X,2);
  
  % Weights of the 1st layer
  W1_size = hidden_layer_size*input_layer_size;
  W1 = reshape(nn_weights(1:W1_size), hidden_layer_size, input_layer_size);
  
  % Weights of the hidden layer
  Wh_size = hidden_layer_size*hidden_layer_size;
  Wh = reshape(nn_weights(W1_size+1:W1_size+Wh_size), hidden_layer_size, hidden_layer_size);
  
  % Weights of the 2nd layer
  W2 = reshape(nn_weights(W1_size+Wh_size+1:end), output_layer_size, hidden_layer_size);
  
  delta3 = zeros(size(W2));
  delta2 = zeros(size(W1));
  deltah = zeros(size(Wh));
  
  delta3_tmp = a3;
  
  % Y - a3
  idx = sub2ind(size(delta3_tmp), Y(:), [1:n]');
  delta3_tmp(idx) -= 1;
  
  % For each word
  for t=n:-1:1
    delta3 += delta3_tmp(:,t) * a2(:,t)';
%    % size(delta3_tmp(:,t)); = hidden_layer_size x 1
%    delta_t = (W2' * delta3_tmp(:,t)) .* (1 - (a2(:,t).^2)); % size(delta_t) = hidden_layer_size x 1
%    
%    for bptt_step = t:-1:max(1,t-bptt_truncate)
%      %
%      if bptt_step-1>0
%        deltah += delta_t' * a2(:,bptt_step-1);
%      endif
%      
%      delta2(:,X(bptt_step)) += delta_t;
%      
%      % Update
%      if bptt_step-1>0
%        delta_t = (Wh' * delta_t) .* (1 - (a2(:,bptt_step-1).^2)); % size(delta_t) = hidden_layer_size x 1
%      else
%        delta_t = (Wh' * delta_t);
%      end
%    endfor
    
  endfor
  
  % Unroll gradients
  grad = [delta2(:); delta3(:); deltah(:)];
  
end
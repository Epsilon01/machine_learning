function [J grads] = costFunction(X, Y, nn_weights, ...
                                  options, grad)
  
  % Brief: compute the cost and gradients
  %
  % Parameters
  %   X           - data set
  %   Y           - data labels
  %   nn_weights  - weights
  %   options     - hyperparameters
  %
  % Returns
  %   J     - cost
  %   grads - gradients
  
  
  
  m = size(X,1); % the number of sentences
  N = 0; % The number of words in all sentences
  J = 0; % The cost
  
  for i=1:m % for each sentence
  
    % Feedforward --------------------------------------------------------------
    [a2, a3] = feedforward(X{i}, nn_weights, options);
    
    if iscell(Y{i})
      Y_sent = cell2mat(Y{i});
    else
      Y_sent = Y{i};
    endif
    
    idx = sub2ind(size(a3), Y_sent(:), [1:numel(Y_sent)]');
    correct_word_predictions = a3(idx);
    
    N += numel(Y_sent);


    
    % Compute the cost ---------------------------------------------------------
    J += sum(log(correct_word_predictions));
    

    
    % Backpropagation ----------------------------------------------------------
    if grad
      if iscell(X{i})
        X_sent = cell2mat(X{i});
      else
        X_sent = X{i};
      endif
      
      grads = bptt(X_sent, Y_sent, ...
                   a2, a3, ...
                   nn_weights, ...
                   options);
    else
      grads = 0;
    endif
    
  endfor
  
  J = J*-1/N;
  
end
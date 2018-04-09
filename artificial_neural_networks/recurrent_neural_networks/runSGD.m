function opt_nn_weights = runSGD(costFunction, nn_weights, X, Y, options)
  
  % Brief: runs the stochastic gradient descent
  %
  % Parameters:
  %   costFunction  - function for gradients computation
  %   nn_weights    - weights
  %   X             - data set
  %   Y             - data labels
  %   options       - 
  %
  % Returns:
  %   opt_nn_weights  - weights
  
  
  
  fprintf('Run SGD...\n');
  fflush(stdout);  
  
  % Initialization -------------------------------------------------------------
  nb_images = length(Y);
  nb_epoch = options.epoch;
  minibatch = options.minibatch;
  alpha = options.alpha;
  
  mom = 0.5;
  mom_increase = 20;
  velocity = zeros(size(nn_weights));
  
  % SGD loop -------------------------------------------------------------------
  it = 0;
  for e = 1:nb_epoch
    
    rand_id = randperm(nb_images);
    
    for s = 1:minibatch:(nb_images-minibatch+1)
      
      it = it+1;
      if it == mom_increase
        mom = options.momentum;
      endif
      
      mb_X = X(:, :, rand_id(s:s+minibatch-1));
      mb_Y = Y(rand_id(s:s+minibatch-1));
      
      [cost grad] = costFunction(mb_X, mb_Y, nn_weights);
      
      velocity = (mom .* velocity) + (alpha .* grad);
      nn_weights = nn_weights - velocity;
      
      fprintf('Epoch %d: Cost on iteration %d is %f\n', e, it, cost);
      fflush(stdout);
      
    endfor
    
    alpha = alpha/2.0;
    
  endfor
  
  opt_nn_weights = nn_weights;
  
  fprintf('Run SGD... Ok\n');
  fflush(stdout);
  
end
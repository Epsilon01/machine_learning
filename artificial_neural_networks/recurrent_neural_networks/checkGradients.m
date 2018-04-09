function checkGradients()
  
  fprintf('Check Gradients...\n');
  fflush(stdout);
  
  % Check gradient with only one sample
  X = {[1,2,3,4]};
  Y = {[2,3,4,5]};
  
  nb_words = 100; % Use a small dictionnary here
  options.ilayer_size = nb_words;
  options.hlayer_size = 10;
  options.olayer_size = nb_words;
  options.bptt_truncate = 1000;
  
  W1 = initializeWeightsDebug(options.ilayer_size, options.hlayer_size);
  Wh = initializeWeightsDebug(options.hlayer_size, options.hlayer_size);
  W2 = initializeWeightsDebug(options.hlayer_size, options.olayer_size);
  nn_weights = [W1(:); Wh(:); W2(:)];
  
  costFunc = @(p) costFunction(X, Y, p, options, false);
  
  [cost grad] = costFunction(X, Y, nn_weights, ...
                             options, true);
                          
  num_grad = computeNumericalGradients(costFunc, nn_weights);
  
  disp('10 firsts results')
  fprintf('num_grad \t grad\n');
  disp([num_grad(1:10) grad(1:10)]);
  
  diff = norm(num_grad - grad)/norm(num_grad+grad);
  disp('diff '), disp(diff);
  
  fprintf('Check Gradients... Ok\n');
  fflush(stdout);
  
end
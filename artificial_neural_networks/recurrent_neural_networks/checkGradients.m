function checkGradients()
  
  fprintf('Check Gradients...\n');
  fflush(stdout);
  
  % Check gradient with only one sample
  X = {[1,2,3,4]};
  Y = {[2,3,4,5]};
  
  nb_words = 100; % Use a small dictionnary here
  input_layer_size = nb_words;
  hidden_layer_size = 100;
  output_layer_size = nb_words;
  
  W1 = initializeWeightsDebug(hidden_layer_size, input_layer_size);
  Wh = initializeWeightsDebug(hidden_layer_size, hidden_layer_size);
  W2 = initializeWeightsDebug(output_layer_size, hidden_layer_size);
  nn_weights = [W1(:); Wh(:); W2(:)];
  
  costFunc = @(p) costFunction(X, Y, p, ...
                               input_layer_size, ...
                               hidden_layer_size, ...
                               output_layer_size);
  
  [cost grad] = costFunctionFull(X, Y, nn_weights, ...
                                 input_layer_size, ...
                                 hidden_layer_size, ...
                                 output_layer_size);
                          
%  num_grad = zeros(size(nn_weights));
  num_grad = computeNumericalGradients(costFunc, nn_weights);
  
  disp('10 firsts results')
  fprintf('num_grad \t grad\n');
  start = input_layer_size*hidden_layer_size;
  disp([num_grad grad]);
%  for i=start:start+10
%    fprintf('%d \t %d\n', num_grad(i,:), grad(i,:));
%  endfor
  
  diff = norm(num_grad(start:start+10) - grad(start:start+10))/norm(num_grad(start:start+10) + grad(start:start+10));
%  diff = norm(num_grad - grad)/norm(num_grad+grad);
  disp('diff '), disp(diff);
  
  fprintf('Check Gradients... Ok\n');
  fflush(stdout);
  
end
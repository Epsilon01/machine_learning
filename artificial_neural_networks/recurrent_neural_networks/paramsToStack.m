function [W1, Wh, W2] = paramsToStack(nn_weights, options)
                                          
  % Brief: converts unrolled parameters into structured weight matrices
  %        and corresponding biases vectors.
  %
  % Parameters:
  %   nn_weights  - unrolled parameter vector.
  %   options     - hyperparameters.
  %
  % Returns:
  %   W1  - hidden_layer_size x input_layer_size parameter matrix.
  %   Wh  -  parameter matrix.
  %   W2  -  parameter matrix.
  
  
  
  ilayer_size = options.ilayer_size;
  hlayer_size = options.hlayer_size;
  olayer_size = options.olayer_size;
   
  ind_start = 1;
  ind_end   = hlayer_size*ilayer_size;
  W1 = reshape(nn_weights(ind_start:ind_end), hlayer_size, ilayer_size);
  
  ind_start = ind_end+1;
  ind_end   = ind_end+hlayer_size*hlayer_size;
  Wh = reshape(nn_weights(ind_start:ind_end), hlayer_size, hlayer_size);
  
  ind_start = ind_end+1;
  W2 = reshape(nn_weights(ind_start:end), olayer_size, hlayer_size);
  
end
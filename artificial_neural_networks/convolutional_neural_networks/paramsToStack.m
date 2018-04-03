function [Wc, Wd, bc, bd] = paramsToStack(nn_weights, image_dim, filter_dim,...
                                          nb_filter, pool_dim, nb_classe)
                                          
  % Brief: converts unrolled parameters into structured weight matrices
  %        and corresponding biases vectors.
  %
  % Parameters:
  %   nn_weights  - unrolled parameter vector.
  %   image_dim   - width/height of image.
  %   filter_dim  - dimension of convolutional filter.
  %   nb_filter   - number of convolutional filters.
  %   pool_dim    - dimension of pooling area.
  %   nb_classe   - number of classes to predict.
  %
  % Returns:
  %   Wc  - filter_dim x  filter_dim x nb_filter  parameter matrix.
  %   Wd  - nb_classe x hidden_size parameter matrix.
  %   bc  - nb_filter x 1 bias for convolution layer. 
  %   bd  - hidden_size x 1 bias for dense layer.
  
  
  
  out_dim = (image_dim - filter_dim + 1)/pool_dim;
  hidden_size = out_dim^2 * nb_filter;
  
  ind_start = 1;
  ind_end   = filter_dim^2 * nb_filter;
  Wc = reshape(nn_weights(ind_start:ind_end), filter_dim, filter_dim, nb_filter);
  
  ind_start = ind_end+1;
  ind_end   = ind_end+hidden_size*nb_classe;
  Wd = reshape(nn_weights(ind_start:ind_end), nb_classe, hidden_size);
  
  ind_start = ind_end+1;
  ind_end   = ind_end+nb_filter;
  bc = nn_weights(ind_start:ind_end);
  
  ind_start = ind_end+1;
  bd = nn_weights(ind_start:end);
  
end
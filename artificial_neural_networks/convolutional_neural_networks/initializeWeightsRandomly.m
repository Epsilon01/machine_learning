function W = initializeWeightsRandomly(image_dim,...
                                       filter_dim,...
                                       nb_filter,...
                                       pool_dim,...
                                       nb_classes)
                                       
  assert(filter_dim < image_dim, 'Assert error: (filter_dim < image_dim) == false');
  
  Wc = 1e-1*randn(filter_dim, filter_dim, nb_filter);
  
  convolution_output_dim = image_dim - filter_dim + 1;
  
  assert(mod(convolution_output_dim, pool_dim)==0, ...
         'Assert error: mod(convolution_output_dim, pool_dim)~=0');
         
  pooling_output_dim = convolution_output_dim/pool_dim;
  
  hidden_size = pooling_output_dim^2 * nb_filter;
  
  r = sqrt(6) / sqrt(nb_classes+hidden_size+1);
  Wd = rand(nb_classes, hidden_size) * 2 * r - r;
  
  bc = zeros(nb_filter, 1);
  bd = zeros(nb_classes, 1);
  
  W = [Wc(:) ; Wd(:) ; bc(:) ; bd(:)];
  
end
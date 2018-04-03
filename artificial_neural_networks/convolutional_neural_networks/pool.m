function pooled_features = pool(pool_dim, activations)
  
  conv_dim = size(activations,1);
  nb_filter = size(activations,3);
  nb_image = size(activations,4);
  pooling_output_dim = conv_dim/pool_dim;
  
  pooled_features = zeros(pooling_output_dim, pooling_output_dim, ...
                          nb_filter, nb_image);
  
  % Mean pooling --------------------------------------------------------------- 
  pool_dim_sq = pool_dim*pool_dim;
  pool_filter = ones(pool_dim, pool_dim)./pool_dim_sq;
  
  for image_num=1:nb_image
    for filter_num=1:nb_filter
      
      % Get the convolved image with the filter
      im = squeeze(activations(:, :, filter_num, image_num));
      
      conv_features = conv2(im, pool_filter, 'valid');
      
      conv_features_ds = downsample(conv_features, pool_dim);
      conv_features_ds = (downsample(conv_features_ds', pool_dim))';
      
      pooled_features(:,:,filter_num,image_num) = conv_features_ds;
      
    endfor
  endfor
  
end
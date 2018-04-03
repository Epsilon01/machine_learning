function conv_features = convolve(filter_dim, nb_filter, X, Wc, bc)
  
  % brief:
  %
  % Parameters:
  %   filter_dim  -
  %   nb_filter   -
  %   X           -
  %   nn_weights  -
  %   b           -
  %
  % Returns
  %   convFeatures  - 
  
  image_dim = size(X,1);
  nb_image = size(X,3);
  conv_dim = image_dim - filter_dim+1;
  
  conv_features = zeros(conv_dim, conv_dim, nb_filter, nb_image);
  
  for image_num = 1:nb_image
      
    % Get the image_num
    im = squeeze(X(:, :, image_num));
      
    for filter_num = 1:nb_filter
      
      % The result for one image with one filter
      conv_image = zeros(conv_dim, conv_dim);
      
      % Get the filter_num
      filter = Wc(:,:,filter_num);
      
      % Flip the filter
      filter = rot90(squeeze(filter),2);
      
      % Convolve the image with the filter
      conv_image = conv_image + conv2(im, filter, 'valid');
      conv_image = conv_image + bc(filter_num);
      
      conv_image = sigmoid(conv_image);
      
      conv_features(:, :, filter_num, image_num) = conv_image;
      
    endfor
  endfor
  
end
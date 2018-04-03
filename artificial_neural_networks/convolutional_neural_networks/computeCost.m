function [cost grad preds] = computeCost(X, Y, ...
                                         nn_weights, ...
                                         nb_classe, ...
                                         filter_dim, ...
                                         nb_filter, ...
                                         pool_dim, ...
                                         pred)
  
  % Brief:
  %
  % Parameters:
  %   X           - 
  %   Y           - 
  %   nn_weights  - 
  %   nb_classe   - 
  %   filter_dim  - 
  %   nb_filter   - 
  %   pool_dim    - 
  %
  % Returns:
  %   cost  - 
  %   grad  - 
  
  
  
  image_dim = size(X,1);
  nb_image = size(X,3);
  
  [Wc, Wd, bc, bd] = paramsToStack(nn_weights, image_dim, filter_dim,...
                                   nb_filter, pool_dim, nb_classe);
                                
                                
  % Initialize -----------------------------------------------------------------
  Wc_grad = zeros(size(Wc));
  Wd_grad = zeros(size(Wd));
  bc_grad = zeros(size(bc));
  bd_grad = zeros(size(bd));
  
  
  
  
  % Forward propagation --------------------------------------------------------
  conv_dim = image_dim - filter_dim+1;
  % Convolve
  activations = convolve(filter_dim, nb_filter, X, Wc, bc);
  % Pool
  activations_pooled = pool(pool_dim, activations);
  % hidden_size x nb_image
  activations_pooled = reshape(activations_pooled, [], nb_image);
  
  % Softmax
  probs = zeros(nb_classe, nb_image);
  activations_softmax = Wd * activations_pooled + repmat(bd,1,nb_image);
  activations_softmax = bsxfun(@minus, activations_softmax, max(activations_softmax, [], 1));
  activations_softmax = exp(activations_softmax);
  probs = bsxfun(@rdivide, activations_softmax, sum(activations_softmax));
  
  clear activations_softmax; % free memory
  
  
  
  % Compute cost ---------------------------------------------------------------  
  ground_truth = full(sparse(Y, 1:nb_image, 1));
  tmp = ground_truth .* probs;
  tmp = log(tmp(tmp~=0));
  cost = -mean(tmp);
  
  clear tmp; % free memory
  
  
  
  % Make predictions -----------------------------------------------------------
  if pred
    [~,preds] = max(probs,[],1);
    preds = preds';
    grad = 0;
    return;
  end;
  
  

  % Backpropagation ------------------------------------------------------------
  output_dim = conv_dim/pool_dim;
  tmp1 = (-1/nb_image) .* (ground_truth - probs);
  clear ground_truth; % free memory
  
  Wd_grad = tmp1 * activations_pooled';
  bd_grad = tmp1 * ones(nb_image, 1);
  clear activations_pooled; % free memory
  
  tmp2 = Wd' * tmp1;
  tmp2_pooled = reshape(tmp2, output_dim, output_dim, nb_filter, nb_image);
  tmp2_upsampled = zeros(conv_dim, conv_dim, nb_filter, nb_image);
  clear tmp1; % free memory
  
  for image_num = 1:nb_image
      
    % Get the image_num
    im = squeeze(X(:, :, image_num));
    
    for filter_num = 1:nb_filter
      
      % Upsample
      tmp3 = (1/(pool_dim*pool_dim)) .* kron(squeeze(tmp2_pooled(:,:,filter_num, image_num)), ones(pool_dim));
      tmp2_upsampled(:,:,filter_num,image_num) = tmp3 .* activations(:,:,filter_num, image_num) .* (1-activations(:,:,filter_num, image_num));
      
      % Deconvolve
      tmp4_1 = squeeze(tmp2_upsampled(:,:,filter_num,image_num));
      tmp4_2 = conv2(im, rot90(squeeze(tmp4_1),2), 'valid');;
      Wc_grad(:,:,filter_num) = squeeze(Wc_grad(:,:,filter_num)) + tmp4_2;
      bc_grad(filter_num) = bc_grad(filter_num) + sum(tmp4_1(:));
      
    endfor
  endfor
  
  % Free memory
  clear activations;
  clear tmp2_pooled;
  clear tmp2_upsampled;
  
  
  
  % Compute gradients ----------------------------------------------------------
  % Unroll gradients
  grad = [Wc_grad(:) ;  Wd_grad(:) ; bc_grad(:) ; bd_grad(:)];
  
end
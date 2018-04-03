% Initialization
% pkg load signal
clear ; close all; clc

% Add paths
addpath("data");



% Load Data --------------------------------------------------------------------

% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
X = loadMNISTImages('data/train-images-idx3-ubyte');
Y = loadMNISTLabels('data/train-labels-idx1-ubyte');
Y(Y==0) = 10; % Remap 0 to 10
 
% We are using display_network from the autoencoder code
display_network(X(:,1:100)); % Show the first 100 images
disp(Y(1:10)); % Show the first 10 labels



% Initialize Parameters --------------------------------------------------------
image_dim = 28;   % 28x28
nb_classe = 10;  % Numbers from 0 to 9
filter_dim = 9;   % Filter size for convolution
nb_filter = 20;   % Number of filters for convolution
pool_dim = 2;     % Pooling dimension

nn_weights = initializeWeightsRandomly(image_dim, filter_dim, nb_filter,...
                                       pool_dim, nb_classe);
                                       
X = reshape(X, image_dim, image_dim, []);



% Check convolution ------------------------------------------------------------
CHECK_CONVOLUTION = false;
if CHECK_CONVOLUTION
  
  db_filter_dim = 8;
  nb_filter = 100;
  nb_images = 60000;
  pool_dim = 3;
  
  Wc = randn(filter_dim, filter_dim, nb_filter);
  bc = rand(nb_filter);
  
  % Use only 8 images for the test
  conv_image = X(:, :, 1:8);
  
  conv_features = convolve(filter_dim, nb_filter, conv_image, Wc, bc);
  
  for i = 1:1000
    
    filter_num = randi([1, nb_filter]);
    image_num = randi([1, 8]);
    image_row = randi([1, image_dim - filter_dim + 1]);
    image_col = randi([1, image_dim - filter_dim + 1]);
    
    patch = conv_image(image_row:image_row+filter_dim-1, ...
                       image_col:image_col+filter_dim-1, ...
                       image_num);
                       
    feature = sum(sum(patch.*Wc(:,:,filter_num))) + bc(filter_num);
    feature = sigmoid(feature);
    
    if abs(feature - conv_features(image_row, image_col, filter_num, image_num)) > 1e-9
      fprintf('Convolved feature does not match test feature\n');
      fprintf('Filter Number    : %d\n', filter_num);
      fprintf('Image Number      : %d\n', image_num);
      fprintf('Image Row         : %d\n', image_row);
      fprintf('Image Column      : %d\n', image_col);
      fprintf('Convolved feature : %0.5f\n', conv_features(image_row, image_col, filter_num, image_num));
      fprintf('Test feature : %0.5f\n', feature);       
      error('Convolved feature does not match test feature');
    endif
    
  endfor
  
  disp('The convolution algorithm is OK !');
  
endif




% Check pooling ----------------------------------------------------------------
CHECK_POOLING = false;
if CHECK_POOLING
  
  test_mat = reshape(1:64, 8, 8);
  expected_mat = [mean(mean(test_mat(1:4, 1:4))),mean(mean(test_mat(1:4, 5:8))); ...
                  mean(mean(test_mat(5:8, 1:4))) mean(mean(test_mat(5:8, 5:8))); ];
                  
  test_mat = reshape(test_mat, 8, 8, 1, 1);
  
  pooled_features = squeeze(pool(4, test_mat));
  
  if ~isequal(pooled_features, expected_mat)
    disp('Pooling incorrect');
    disp('Expected');
    disp(expectedMatrix);
    disp('Got');
    disp(pooledFeatures);
    error('Pooling error');
  endif
  
  disp('The pooling algorithm is OK !');
  
endif



% Check Gradient ---------------------------------------------------------------
CHECK_GRADIENT = false;
if CHECK_GRADIENT
  
  db_nb_filter = 2;
  db_filter_dim = 9;
  db_pool_dim = 5;
  db_X = X(:,:,1:10);
  db_Y = Y(1:10);
  
  db_nn_weights = initializeWeightsRandomly(image_dim,...
                                            db_filter_dim,...
                                            db_nb_filter,...
                                            db_pool_dim,...
                                            nb_classe);
  
  costFunction = @(p) computeCost(db_X, db_Y, ...
                                  p, ...
                                  nb_classe, ...
                                  db_filter_dim, ...
                                  db_nb_filter, ...
                                  db_pool_dim); 
  
  [cost grad] = costFunction(db_nn_weights);
                            
  num_grad = computeNumericalGradients(costFunction, db_nn_weights);
  
  % Print the 10 firsts num_grad and grad side by side
  disp([num_grad(1:10) grad(1:10)]);
  
  diff = norm(num_grad-grad) / norm(num_grad+grad);
  
  disp(diff);
  
  assert(diff < 1e-9, 'The difference between the numerical gradients and gradients is too large.');
  
endif



% Learn parameters -------------------------------------------------------------
LOAD_PARAMETERS = true;
if LOAD_PARAMETERS
  
  load('opt_nn_weights');
  
else
  
  options.epoch = 3;
  options.minibatch = 256;
  options.alpha = 1e-1;
  options.momentum = .95;

  costFunction = @(x,y,w) computeCost(x, y, w, nb_classe, filter_dim, ...
                                      nb_filter, pool_dim);

  opt_nn_weights = runSGD(costFunction, nn_weights, X, Y, options);

  save("-binary", "opt_nn_weights.mat", "opt_nn_weights");
  
endif



% Predictions on the test set --------------------------------------------------

X_test = loadMNISTImages('data/t10k-images-idx3-ubyte');
Y_test = loadMNISTLabels('data/t10k-labels-idx1-ubyte');

X_test = reshape(X_test, image_dim, image_dim, []);
Y_test(Y_test==0) = 10; % Remap 0 to 10

[~, ~, preds] = computeCost(X_test, Y_test, opt_nn_weights, nb_classe, ...
                            filter_dim, nb_filter, pool_dim, true);
                               
accuracy = (sum(preds==Y_test) / length(preds))*100;

fprintf('Accuracy is %f percrent\n', accuracy);























% Initialization
clear ; close all; clc

% Add paths
addpath("datas");

% Load data in X_data and y_data -----------------------------------------------
load('make_moons_X_y.mat');

y_data = y_data';

% size(X) % mx2
% size(y) % mx1

% Create the training set,
% the test set and the cross-validation set from X -----------------------------
m_data = size(X_data,1);

% Training set
X = X_data(1:m_data*0.6, :);
y = y_data(1:m_data*0.6, :);

% Test set
X_test = X_data(m_data*0.6+1:m_data*0.8, :);
y_test = y_data(m_data*0.6+1:m_data*0.8, :);

% Cross-validation set
X_cv = X_data(m_data*0.8+1:end, :);
y_cv = y_data(m_data*0.8+1:end, :);



% Plot data --------------------------------------------------------------------
plotData(X_data, y_data);



% Polynomial features & Normalization ------------------------------------------
degree = 1; % Here we don't need polynomial features since results are good
            % but the value can be changed to see results.

% Training set
X_poly = polynomialFeatures(X, degree);
[X_poly, mu, sigma] = normalizeFeatures(X_poly);

% Test set
X_poly_test = polynomialFeatures(X_test, degree);
X_poly_test = bsxfun(@minus, X_poly_test, mu);
X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);

% Cross validation set
X_poly_cv = polynomialFeatures(X_cv,degree);
X_poly_cv = bsxfun(@minus, X_poly_cv, mu);
X_poly_cv = bsxfun(@rdivide, X_poly_cv, sigma);



% Neural Network parameters initialization -------------------------------------
input_layer_size = size(X_poly, 2); % the number of features
hidden_layer_size = 3;
output_layer_size = 2; % the number of output classes

W1 = initializeWeightsRandomly(input_layer_size, hidden_layer_size);
W2 = initializeWeightsRandomly(hidden_layer_size, output_layer_size);
nn_weights_initial = [W1(:); W2(:)]; % unroll weights

lambda = 0.01;
m = size(X_poly,1); % number of training examples

%size(W1) %3x3
%size(W2) %2x4
%size(nn_weights) % 809x1

fprintf('Program paused. Press enter to continue.\n');
pause;



% Check gradients --------------------------------------------------------------
%checkGradients(lambda); % Use it only to test the backpropagation 



% Learning curves --------------------------------------------------------------
[error_train, error_cv] = learningCurves(X_poly, y, ...
                                         X_poly_cv, y_cv, ...
                                         lambda, nn_weights_initial,
                                         input_layer_size,
                                         hidden_layer_size,
                                         output_layer_size);

plot(1:m, error_train, 1:m, error_cv);
title('Learning curves')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')

fprintf('Program paused. Press enter to continue.\n');
pause;

% Validation curves ------------------------------------------------------------
[lambda_vec, err_train, err_cv] = validationCurves(X_poly, y, ...
                                                   X_poly_cv, y_cv, ...
                                                   nn_weights_initial, ...
                                                   input_layer_size, ...
                                                   hidden_layer_size, ...
                                                   output_layer_size);

plot(lambda_vec, err_train, lambda_vec, err_cv);
title('Validation curves')
legend('Train', 'Cross-Validation');
xlabel('Lambda');
ylabel('Error');

% Find the minimum error on the cross-validation set
[min_err idx] = min(err_cv);

% Train with the optimum parameter
opt_lambda = lambda_vec(idx);
fprintf('Optimum lambda: %f\n', opt_lambda);

options = optimset('MaxIter', 50);
costFunc = @(p) costFunction(X_poly, y, opt_lambda, p, ...
                             input_layer_size, ...
                             hidden_layer_size, ...
                             output_layer_size);

[nn_weights, cost] = fmincg(costFunc, nn_weights_initial, options);

fprintf('Program paused. Press enter to continue.\n');
pause;


% Plot the decision boundary ---------------------------------------------------
plotDecisionBoundary(X_poly_test, y_test, nn_weights);
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
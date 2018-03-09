clear ; close all; clc

% Add paths
addpath("datas");



% Load data in X_data and y_data -----------------------------------------------
load('boston_X_y.mat');

% Here we extract only one feature
% (the proportion of residential land zoned)
X_data = X_data(:,6);

y_data = y_data';



% Create the training set and the test set from X ------------------------------
m_data = size(X_data,1);

% Training set
X = X_data(1:m_data*0.7, :);
y = y_data(1:m_data*0.7, :);

% Test set
X_test = X_data(m_data*0.7+1:m_data*1, :);
y_test = y_data(m_data*0.7+1:m_data*1, :);



% Parameters initialization ----------------------------------------------------
weights = zeros(2,1);
num_iters = 1500;
alpha = 0.01;



% Plot datas -------------------------------------------------------------------
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;



% Gradient descent -------------------------------------------------------------
fprintf('Run gradient descent\n');
[weights cost_hist] = gradientDescent(X, y, weights, alpha, num_iters);

plotCostHist(cost_hist);

fprintf('Program paused. Press enter to continue.\n');
pause;



% Predict ----------------------------------------------------------------------
p = predict(X_test, weights);
plotLinearFit(X_test, y_test, weights);

X_test_bias = [ones(size(X_test,1),1), X_test];

error = meanSquaredError(y_test, p);
fprintf('Mean squared error on the test set %f\n', error);



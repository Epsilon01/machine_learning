clear ; close all; clc

% Add paths
addpath("data");



% Load/plot data ---------------------------------------------------------------
load('2d_points.mat');
plot2dPoints(X, 'The 2D point set.');
fprintf('Press any key to continue.\n');
pause();


% PCA --------------------------------------------------------------------------

% Center features
[X_norm] = centerFeatures(X);
plot2dPoints(X_norm, 'The 2D point set centered.');
fprintf('Press any key to continue.\n');
pause();

% Run PCA
[U S] = pca(X_norm);
plotEigenvectors(X,U);
fprintf('Press any key to continue.\n');
pause();

test = U' * X_norm';
plot2dPoints(test', 'The transformed 2D point set.');
fprintf('Press any key to continue.\n');
pause();


% Image Compression ------------------------------------------------------------

%% Load data --------------------------------------------------------------------
%X = imread('data/lena.png');
%
%imshow(X); % Plot image
%title('Grayscale Lena');
%
%
%
%% PCA --------------------------------------------------------------------------
%
%% Feature normalization
%[X_norm, mu, sigma] = normalizeFeatures(X);
%
%% Run PCA
%[U S] = pca(X_norm);
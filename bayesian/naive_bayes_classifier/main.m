% Initialization
% pkg load signal
clear ; close all; clc

% Add paths
addpath("data");



% Load data --------------------------------------------------------------------
X = [3;
     2;
     1;
     3;
     3;
     2;
     1;
     1;
     3;
     1;
     3;
     2;
     2;
     1];
     
y = [1;
     2;
     2;
     2;
     2;
     2;
     1;
     1;
     2;
     2;
     2;
     2;
     2;
     1];
     
% Train ------------------------------------------------------------------------
[prior, likelihood, evidence] = train(X, y, 2);



% Predict ----------------------------------------------------------------------
[preds, probs] = predict(X, prior, likelihood, evidence);

nb_examples = size(X,1);
for i=1:nb_examples
  fprintf('class=%d, %f, %f\n', preds(i), probs(i,1), probs(i,2));
  fflush(stdout);  
endfor







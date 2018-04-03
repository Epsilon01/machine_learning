clear ; close all; clc
pkg load image

% Add paths
addpath("data");



% Parameters initialization ----------------------------------------------------
nb_words = 8000;
data_filename = 'data/reddit-comments-2015-08.csv';

train_size = 100;
X_train = cell(train_size);
Y_train = cell(train_size);

% Network parameters
input_layer_size = nb_words; % the number of features
hidden_layer_size = 100;
output_layer_size = nb_words; % the number of output classes

W1 = initializeWeightsRandomly(input_layer_size, hidden_layer_size);
Wh = initializeWeightsRandomly(hidden_layer_size, hidden_layer_size);
W2 = initializeWeightsRandomly(hidden_layer_size, output_layer_size);
nn_weights_initial = [W1(:); Wh(:); W2(:)]; % unroll weights



% Build data -------------------------------------------------------------------
%X = buildData(data_filename, nb_words);

load('data/dico');
load('data/sentences');

dico = result(:,1);
dico = ['SENTENCE_START'; 'SENTENCE_END'; 'UNKNOWN'; dico];
dico = dico(1:nb_words,:);


for j=1:train_size
  sent = sentences{j};
  words = strsplit(sent);
  

  int_sent = [];
  for i=1:numel(words)
    res = strcmp(words(i), dico);
    it = find(res);
    
    if isempty(it)
      it = 3;
    endif
    
    int_sent = [int_sent, it];
  endfor
  
  X_train{j} = num2cell([1, int_sent]);
  Y_train{j} = num2cell([int_sent, 2]);
endfor



% Predict ----------------------------------------------------------------------
%Y = feedforward(X_train, nn_weights_initial, ...
%                input_layer_size, ...
%                hidden_layer_size, ...
%                output_layer_size);
                
%Y = predict(X_train, nn_weights_initial, ...
%            input_layer_size, ...
%            hidden_layer_size, ...
%            output_layer_size);

%fprintf('Test the cost function\n');
%
%J = costFunction(X_train, Y_train, ...
%                 nn_weights_initial, ...
%                 input_layer_size, ...
%                 hidden_layer_size, ...
%                 output_layer_size);
%                 
%fprintf('Expected loss for random predictions: %f\n', log(nb_words));        
%fprintf('Loss: %f\n', J);
%fflush(stdout);


checkGradients();

                
                
                
                
                
                
                
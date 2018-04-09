clear ; close all; clc
pkg load image

output_precision(7)

% Add paths
addpath("data");



% Parameters initialization ----------------------------------------------------
nb_words = 8000;
data_filename = 'data/reddit-comments-2015-08.csv';

train_size = 100;
X_train = cell(train_size,1);
Y_train = cell(train_size,1);

% SGD parameters
options.epoch = 3;
options.minibatch = 256;
options.alpha = 1e-1;
options.momentum = .95;

% BPTT parameters
options.bptt_truncate = 1000;

% Network parameters
options.ilayer_size = nb_words; % the number of features
options.hlayer_size = 100;
options.olayer_size = nb_words; % the number of output classes

W1 = initializeWeightsRandomly(options.ilayer_size, options.hlayer_size);
Wh = initializeWeightsRandomly(options.hlayer_size, options.hlayer_size);
W2 = initializeWeightsRandomly(options.hlayer_size, options.olayer_size);

nn_weights_initial = [W1(:); Wh(:); W2(:)]; % unroll weights



% Build data -------------------------------------------------------------------
LOAD_DATA = true;
if LOAD_DATA
  
  fprintf('Load data from file...\n');
  fflush(stdout);
  
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
  
  fprintf('Load data from file...ok\n');
  fflush(stdout);
  
else
  
  X = buildData(data_filename, nb_words);
  
endif



% Check cost -------------------------------------------------------------------
CHECK_COST = false;
if CHECK_COST
  J = costFunction(X_train, Y_train, ...
                   nn_weights_initial, ...
                   options);
                   
  fprintf('Expected loss for random predictions: %f\n', log(nb_words));        
  fprintf('Loss: %f\n', J);
  fflush(stdout);
endif



% Check gradients --------------------------------------------------------------
CHECK_GRADIENTS = false;
if CHECK_GRADIENTS
  checkGradients();
endif

           
                
% Learn parameters -------------------------------------------------------------
LOAD_PARAMETERS = false;
if LOAD_PARAMETERS
  load('opt_nn_weights');
else
  costFunction = @(x,y,w) computeCost(x, y, w, nb_classe, filter_dim, ...
                                      nb_filter, pool_dim);

  opt_nn_weights = runSGD(costFunction, nn_weights_initial,
                          X_train, Y_train, options);

  save("-binary", "opt_nn_weights.mat", "opt_nn_weights");
endif



% Generate sentences -----------------------------------------------------------               
nb_sentences = 10;
for i=1:nb_sentences
  
  
  
endfor
                
                
                
                
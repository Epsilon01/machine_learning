function [preds, probs] = predict(X, prior, likelihood, evidence)
  
  nb_examples = size(X,1);
  nb_class = size(prior, 1);
  nb_feature = size(likelihood, 2);
  
  preds = zeros(nb_examples,1);
  probs = zeros(nb_examples, nb_class);
  
  for i=1:nb_examples
    
    for j=1:nb_class    
      % Likelihood
      ind_class = ones(nb_feature,1)*j;
      ind = sub2ind(size(likelihood), ind_class, [1:nb_feature], X(i,:));
      likelihood_vec = likelihood(ind);
      X_likelihood = prod(likelihood_vec);
      
      % Prior
      X_prior = prior(j);;
      
      % "Probability" for the jth class
      probs(i,j) = X_likelihood * X_prior;
      
    endfor
  
    % MAP
    [~, preds(i)] = max(probs(i,:));
    
  endfor  
  
end
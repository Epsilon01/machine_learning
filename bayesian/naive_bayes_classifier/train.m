function [prior, likelihood, evidence] = train(X, y, nb_class)
  
  % Brief:
  %
  % Parameters:
  %   X - data set
  %   y - data labels
  %
  % Returns
  %   prior       - P(A)
  %   likelihood  - P(B|A)
  %   evidence    - P(B)
  
 
 
  nb_examples = size(X,1);
  nb_feature = size(X,2);
  nb_value = nb_examples; % Just for initialization
  
  prior      = zeros(nb_class, 1);
  likelihood = zeros(nb_class, nb_feature, nb_value);
  evidence   = zeros(nb_feature, nb_value);
  
  for i=1:nb_class
    X_class = X(find(y==i), :);
    prior(i) = size(X_class,1) / nb_examples;
    
    for j=1:nb_feature
      values = unique(X(:,j));
      nb_value = numel(values);
      
      for k=1:nb_value
        X_class_feature = X_class(find(X_class(:,j)==values(k)));
        likelihood(i,j,k) =  size(X_class_feature,1) ./ size(X_class,1);
        evidence(j,k) += size(X_class_feature,1);
      endfor
      
    endfor
  endfor
  
  evidence /= nb_examples;
  
end
function plotDecisionBoundary(X, y, nn_weights, degree)
  
  % Color tab: blue and red
  map_br = [0, 0, 0.35;
            0.35, 0, 0];
  
  n = size(X,2); % number of features
  
  plotData(X(:,1:2), y);
  hold on;
  
  u = linspace(min(X(:,1)), max(X(:,1)), 100);
  v = linspace(min(X(:,2)), max(X(:,2)), 100);
  
  z = zeros(length(u), length(v)); % 50x50
  
  for i=1:length(u)
    for j=1:length(v)
      if n<3 % Less than 3 features (degree == 1)
        z(i,j) = predict([u(i) v(j)], nn_weights, 2, 3, 2);
      else % More than or equal to 3 features (degree > 1)
        z(i,j) = predict(polynomialFeatures([u(i) v(j)], degree), nn_weights, size(X,2), 3, 2);
      endif
    endfor
  endfor
  
  z=z';
  
  contourf(u, v, z, 'g');
  colormap(map_br);
  title('Decision boundary');
 
  hold off;
  
end
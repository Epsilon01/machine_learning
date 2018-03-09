function plotData(X, y)
  
  % Create New Figure
  figure; hold on;

  pos = find(y==0);
  neg = find(y==1);
  
  plot(X(pos,1), X(pos,2), 'ob');
  plot(X(neg,1), X(neg,2), 'or');
  
  title('Dataset (training/cross-validation/testing sets)');
  
  hold off;
end
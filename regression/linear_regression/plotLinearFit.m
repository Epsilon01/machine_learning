function plotLinearFit(X, y, weights)
  
  plotData(X, y);
  
  hold on;
  plot(X, y, '-');
  hold off;
  
  title('Linear fit on test set');
  
end
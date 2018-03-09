function plotData(X, y)
  
  figure;
  plot(X, y, 'bx');
  xlabel('Average number of rooms per dwelling');
  ylabel('Prices');
  title('Boston dataset (with only one variable)');
  
end
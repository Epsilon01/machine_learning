function plot2dPoints(X, ti)
  
  figure;
  plot(X(:,1), X(:,2), 'ro');
  axis equal;
  title(ti);
  grid on;
  
end
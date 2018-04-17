function plotEigenvectors(X, U)
  
  % Brief:
  %
  % Parameters
  %   X - 
  %   U - 
  
  
  hold on;
  
  x = linspace(-10, 10, 100);
  
  nb_eigv = size(U,2);
  for i=1:nb_eigv
    y = U(2,i)/U(1,i)*x;
    plot(x, y);
  endfor
  
  title('Eigenvectors of the covariance matrix.');
  
  hold off;
  
end
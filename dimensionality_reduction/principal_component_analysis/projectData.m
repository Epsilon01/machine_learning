function X_proj = projectData(X, eigs)
  
  % Brief:
  %
  % Parameters
  %   X     - the data
  %   eigs  - the eigenvectors
  %
  % Returns
  %   X_proj - the data projected into the eigenspace
  
  
  
  X_proj = eigs' * X';
  X_proj = X_proj';
  
end
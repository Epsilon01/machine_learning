function plotCostHist(cost_hist)
  
  figure;
  
  num_iters = size(cost_hist,1);
  
  plot(1:num_iters, cost_hist);
  
  
end;
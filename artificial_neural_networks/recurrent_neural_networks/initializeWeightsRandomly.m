function W = initializeWeightsRandomly(input_layer_size, output_layer_size)
  
  epsilon_init = 0.1;
  W = rand(output_layer_size, input_layer_size) * 2 * epsilon_init - epsilon_init;
  
end
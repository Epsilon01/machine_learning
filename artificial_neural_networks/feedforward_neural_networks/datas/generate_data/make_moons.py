import numpy as np
import scipy.io as sio
from sklearn.datasets import make_moons

# Generate a dataset and plot it
np.random.seed(0)
X, y = make_moons(200, noise=0.20)

sio.savemat('make_moons_X_y.mat', {'X_data':X, 'y_data':y})

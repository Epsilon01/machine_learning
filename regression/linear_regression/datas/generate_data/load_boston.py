import scipy.io as sio
from sklearn.datasets import load_boston

boston = load_boston()
X = boston.data
y = boston.target

sio.savemat('../boston_X_y.mat', {'X_data':X, 'y_data':y})

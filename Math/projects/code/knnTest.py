#!/usr/bin/env python

from sklearn.neighbors import NearestNeighbors
import numpy as np
X = np.array([[-1, -1],[0.2,0.5],[-2, -1], [-3, -2],[0.5,0.5],[1, 1], [2, 1], [3, 2]])
nbrs = NearestNeighbors(n_neighbors=2, algorithm='ball_tree').fit(X)
test = np.array([0,0])
test = test.reshape(1,-1)
distances, indices = nbrs.kneighbors(test)
print distances, indices           
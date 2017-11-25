print(__doc__)

import numpy as np
import pickle
import csv
import math

from sklearn.cluster import DBSCAN
from sklearn import metrics
from sklearn.datasets.samples_generator import make_blobs
from sklearn.preprocessing import StandardScaler


# #############################################################################
# Generate sample data

'''
centers = [[1, 1], [-1, -1], [1, -1]]
X, labels_true = make_blobs(n_samples=750, centers=centers, cluster_std=0.4,
                            random_state=0)
X = StandardScaler().fit_transform(X)

'''
_val = []
counter = 0
with open('dbscan1_car200_input.csv', 'rU') as inp:
    rd = csv.reader(inp)
    for row in rd:
        _val.append([row[0],row[1]])
        counter = counter + 1

_val = np.asarray(_val)
#print(_val)
#_val_original = _val
#_val_original =_val_original.astype('float32')
#_val = StandardScaler().fit_transform(_val_original)
X = _val
# #############################################################################
# Compute DBSCAN

#Eps=((prod(max(x)-min(x))*k*gamma(.5*n+1))/(m*sqrt(pi.^n))).^(1/n);
my_min_samples = int(math.sqrt(2*counter))
print(my_min_samples)
db = DBSCAN(eps=0.0048, min_samples=5).fit(X)
core_samples_mask = np.zeros_like(db.labels_, dtype=bool)
core_samples_mask[db.core_sample_indices_] = True
labels = db.labels_

# Number of clusters in labels, ignoring noise if present.
n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)

'''
print('Estimated number of clusters: %d' % n_clusters_)
print("Homogeneity: %0.3f" % metrics.homogeneity_score(labels_true, labels))
print("Completeness: %0.3f" % metrics.completeness_score(labels_true, labels))
print("V-measure: %0.3f" % metrics.v_measure_score(labels_true, labels))
print("Adjusted Rand Index: %0.3f"
      % metrics.adjusted_rand_score(labels_true, labels))
print("Adjusted Mutual Information: %0.3f"
      % metrics.adjusted_mutual_info_score(labels_true, labels))
print("Silhouette Coefficient: %0.3f"
      % metrics.silhouette_score(X, labels))
'''

# #############################################################################
# Plot result
import matplotlib.pyplot as plt

# Black removed and is used for noise instead.
unique_labels = set(labels)
colors = [plt.cm.Spectral(each)
          for each in np.linspace(0, 1, len(unique_labels))]

#circle1 = plt.Circle((10, 10), 0.2, color='r')
#fig, ax = plt.subplots()
#ax.add_artist(circle1)
my_group_counter = 1
for k, col in zip(unique_labels, colors):
    if k == -1:
        # Black used for noise.
        col = [0, 0, 0, 1]

    class_member_mask = (labels == k)

    xy = X[class_member_mask & core_samples_mask]
    plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
             markeredgecolor='k', markersize=14)
    #print(xy[:, 0], xy[:, 1])
    #print(' ----- clusters ----- ')
    for x, y in zip(xy[:, 0], xy[:, 1]):
        print(str(x) + ',' + str(y) + ',' + str(my_group_counter) + ',1')

    xy = X[class_member_mask & ~core_samples_mask]
    plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
             markeredgecolor='k', markersize=6)

    #print(' ----- noise ----- ')
    for x, y in zip(xy[:, 0], xy[:, 1]):
        print(str(x) + ',' + str(y) + ',' + str(my_group_counter) + ',0')

    my_group_counter = my_group_counter + 1
    if my_group_counter == n_clusters_:
        break

#plt.title('Estimated number of clusters: %d' % n_clusters_)
plt.show()


    



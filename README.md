# DeepLearning

A Matlab datastore class for balanced image data.

https://github.com/baillon/DeepLearning

Use a BalancedImageDatastore object to manage a balanced collection of image files. The balanced datastore of image files is created by duplicating the lowest occurrence images from the original image datastore. The new datastore will be composed by nClasses * maxOccur observations, where nClasses is the number of distinct labels of the original image datastore and maxOccur is the count of the most sampled label.

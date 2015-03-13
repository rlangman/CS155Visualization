import csv
import numpy as np
import pylab
import math
import unicodedata

# This index corresponds to the genre in the
# file movies.txt or trymovies.txt
# i.e., 3 is Action, 4 is Adventure, and so on
idxgenre = 4 
raw_data = np.loadtxt("moviesSVD.txt")

# Applying SVD
data = raw_data.transpose()
U, s, V = np.linalg.svd(data)
blah = U[:, :2]
want = np.dot(blah.transpose(), data)

numrows = 0

songnames = [0] * want.shape[1]
indexgenres = [0] * want.shape[1]

# This is for getting the genres and the song names
genre = 0
with open('trymovies.txt', 'rb') as f:
    for row in f:
        substrs = row.split("\t")
        songnames[numrows] = substrs[1]
        if substrs[idxgenre] == '1':
            indexgenres[genre] = numrows
            genre += 1
        numrows += 1

# Some random movie groupings
batmanmovies = [28, 230, 253, 402]

amityville = [436, 437, 438, 439, 440, 441, 857]

freewilly = [34, 77, 456]

startrek = [221, 226, 227, 228, 229, 379, 448, 449] 

starwars = [49, 171, 180]

diehard = [143, 225, 549]

disney = [541, 0, 70, 417, 98, 595, 587, 94, 945]

#If you want specific movies, try the first line
# If you want by genre, try the second line
#batch = batmanmovies + starwars + diehard + disney
batch = indexgenres[:genre]

# Plotting
xaxis = [want[0, x] for x in batch]
yaxis = [want[1, x] for x in batch]
pylab.plot(xaxis, yaxis, 'bo')


# For labeling the points
for label, x, y in zip([songnames[x] for x in batch], \
        xaxis, yaxis):
    # Need the following two lines for strange characters, for example, titles
    # in French
    declabel = label.decode("utf-8")
    unilabel = unicodedata.normalize('NFKD', declabel).encode('ascii','ignore')
    pylab.annotate(
        unilabel, 
        xy = (x, y), xytext = (-2, 2),
        textcoords = 'offset points', ha = 'right', va = 'bottom',
        size=8)

# Plot the x-axis
minxaxis = int(math.floor(min(xaxis)) * 100)
maxxaxis = int(math.ceil(max(xaxis)) * 100)

values = np.arange(minxaxis, maxxaxis) * 0.01 
zeros = [0] * (maxxaxis - minxaxis)
pylab.plot(values, zeros, 'b--')

# Plot the y-axis
minyaxis = int(math.floor(min(yaxis)) * 100)
maxyaxis = int(math.ceil(max(yaxis)) * 100)

regvalues = np.arange(minyaxis, maxyaxis) * 0.01
regzeros = [0] * (maxyaxis - minyaxis)
pylab.plot(regzeros, regvalues, 'b--')

pylab.show()


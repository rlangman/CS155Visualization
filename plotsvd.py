import csv
import numpy as np
import pylab

raw_data = np.loadtxt("moviesSVD.txt")

#print raw_data.shape

data = raw_data.transpose()

U, s, V = np.linalg.svd(data)
#print U
#print s
#print V

blah = U[:, :2]

want = np.dot(blah.transpose(), data)

#print want.shape

numrows = 0

songnames = [0] * want.shape[1]

with open('trymovies.txt', 'rb') as f:
    #reader = csv.reader(f)
    #numrows = 0
    for row in f:
        substrs = row.split("\t")
        songnames[numrows] = substrs[1]
        numrows += 1

#print numrows
#print songnames

#print 


pylab.plot(want[0, :20], want[1, :20], 'bo')


for label, x, y in zip(songnames[:20], want[0, :20], want[1, :20]):
    pylab.annotate(
        label, 
        xy = (x, y), xytext = (-2, 2),
        textcoords = 'offset points', ha = 'right', va = 'bottom')

values = np.arange(-100, 150) * 0.01 

regvalues = np.arange(-100, 100) * 0.01
regzeros = [0] * 200

zeros = [0] * 250

pylab.plot(regvalues, regzeros, 'b--')


pylab.plot(zeros, values, 'b--')

pylab.show()


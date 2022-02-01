## This script calculates the cross correlation between functional alpha carbon atoms which we chose depending on previous studies.##
from sys import argv
import math
import numpy as np
import pylab
import copy
import matplotlib.pyplot as plt


def plot_colormap(matrix,filename,number):
        X,Y = np.mgrid[1:(number+1):1, 1:(number+1):1]
        pylab.pcolor(X,Y,matrix,cmap=plt.cm.seismic,vmax=1,vmin=-1)
        pylab.axis([0,number+1,0,number+1])
        pylab.colorbar()
        pylab.savefig(filename+".png")
        pylab.show()
f= open(argv[1],'r')   #correlation file got from gromacs
data= f.readlines()
f.close()
no_res = int(argv[2])            # Total number of residues in protein
l= len(data)
data_mod = []
for line in data:
        temp=line.strip().split()
        data_mod.append([float(temp[0]),float(temp[1]),float(temp[2])])
data_mod = np.array(data_mod)

data_mod = np.reshape(data_mod,(no_res*3,no_res*3))

normalize  = np.diagonal(data_mod[0::3,0::3]) + np.diagonal(data_mod[1::3,1::3]) + np.diagonal(data_mod[2::3,2::3])

normalize  = np.sqrt(normalize)

covariance = data_mod[0::3,0::3]+data_mod[1::3,1::3]+data_mod[2::3,2::3]

print(normalize)

del data_mod

list = np.loadtxt(argv[3])   # File having total number fuctional alpha carbons sequence

list = list.astype(int)

list=list-1                # substracted 1 becaues python starts from 0

corr2 = np.zeros((int(argv[6]),int(argv[6])))    #Two dimentional array of size equal to number of fuctional alpha carbons

k=0

for i in list:
    
    l=0
    for j in list:
        t=covariance[i][j]
        corr2[k][l]=t
        l=l+1
    k=k+1  

new = open(argv[4]+"_pairs.txt",'w')

resids = np.loadtxt(argv[5],dtype="str")  #Residue names of functional carbon atoms 

m=0

nor1=np.zeros(int(argv[6])) # T

for i in list:
    nor1[m]=normalize[i]
    
    m=m+1


no_res1=int(argv[6])  # Total number of functional alpha  carbon atoms

for i in range(no_res1):
    
        for j in range(i,no_res
                    corr2[i][j] = corr2[i][j]/(nor1[i]*nor1[j])
                    corr2[j][i] = corr2[i][j]
                    if (abs(corr2[i][j]) >= float(argv[7])) :
                              if np.abs(i-j) > 0:
                                        print (resids[i],resids[j],corr2[i][j],file=new)
                    
np.savetxt(argv[4]+".txt",corr2)
plot_colormap(corr2,argv[4],no_res1)
new.close()

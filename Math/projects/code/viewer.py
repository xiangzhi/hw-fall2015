#!/usr/bin/env python

#Make use of numpy since we are doing operations
import numpy
import csv #so we can read csv files
import os #for file manipulations
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt

#use scikit-learn for simplicity
from sklearn.neighbors import KNeighborsClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC, LinearSVC

def readcsvfile(file_name):
    """
    read and return the csv file in the correct format
    """
    tmpfile = numpy.array([])
    with open(file_name,'rb') as csvfile:
        csvreader = csv.reader(csvfile, delimiter=",")
        #count how many columns there are
        #only count those that are not empty
        row = next(csvreader)
        while row[-1] == "":
            del row[-1]
        col_num = len(row)
        #count how many rows we have
        csvfile.seek(0)
        row_num = sum(1 for row in csvreader)
        #create a new numpy object
        tmpfile = numpy.ones((row_num, col_num-1)) #minus one because the first is the time step
        #loop through and add it to the list
        csvfile.seek(0)
        idx = 0
        for row in csvreader:
            row.pop(0) #remove first element
            #check if last element is empty, if it is remove it
            while row[-1] == "":
                del row[-1]
            tmpfile[idx,:] = row #put it into the array
            idx += 1
    return tmpfile



effectorFile = readcsvfile("test/test1-endEffector.csv")
ptrs3D = effectorFile[:,0:3].copy()


fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
for pts in ptrs3D:
    ax.scatter(pts[0], pts[1], pts[2], c='r',marker='o')

ptrs3D = ptrs3D[0:500,:]
for pts in ptrs3D:
    ax.scatter(pts[0], pts[1], pts[2], c='b',marker='o')


plt.show()
#print numpy.shape(data), numpy.shape(gt)
#print ptrs3D

# #train a logistic classifier
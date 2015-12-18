#!/usr/bin/env python

#Make use of numpy since we are doing operations
import numpy
import csv #so we can read csv files
import os #for file manipulations
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

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
        if col_num > 1:
            col_num = col_num - 1
        tmpfile = numpy.ones((row_num, col_num)) #minus one because the first is the time step
        #loop through and add it to the list
        csvfile.seek(0)
        idx = 0
        for row in csvreader:
            if len(row) != 1:
                row.pop(0) #remove first element
            #check if last element is empty, if it is remove it
            while row[-1] == "":
                del row[-1]
            tmpfile[idx,:] = row #put it into the array
            idx += 1
    return tmpfile


typeList = ['ori','forward','backward','left','right','up','down']

def readgtfile(file_name):
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
        if col_num > 1:
            col_num = col_num - 1
        tmpfile = numpy.ones((row_num, col_num)) #minus one because the first is the time step
        #loop through and add it to the list
        csvfile.seek(0)
        idx = 0
        for row in csvreader:
            #check if last element is empty, if it is remove it
            while row[-1] == "":
                del row[-1]

            #convert to number
            tmpfile[idx,:] = typeList.index(row[0]) #put it into the array
            idx += 1
    return tmpfile



def readData(fileID):
    dataTypes = {}
    for typename in typeList:
        posName = '%s-%s-aPos.csv' % (fileID, typename)
        effortName = '%s-%s-aEffort.csv' % (fileID, typename)
        #get the data from csv
        posFile = readcsvfile(posName)
        effortFile = readcsvfile(effortName)
        #combine the data
        data = numpy.zeros((numpy.shape(posFile)[0], numpy.shape(posFile)[1] + numpy.shape(effortFile)[1]))
        data[:,0:numpy.shape(posFile)[1]] = posFile.copy()
        data[:,numpy.shape(posFile)[1]:] = effortFile.copy()
        dataTypes[typename] = data
    return dataTypes


class JointInferencer(object):
    """
    A class that tries to infer what type of action is done based on the available information
    """
    def __init__(self):
        print("nothing");
        self.alpha = 0.5

    def filterData(self,data):
        """
        Use Exponentially Weighted Moving Average
        """
        for idx, rows in enumerate(data):
            if idx == 0:
                data[idx,:] = rows
            else:
                data[idx,:] = self.alpha * data[idx,:] + (1 - self.alpha) * data[idx-1,:]
            
            if numpy.any(numpy.isnan(data[idx,:])):
                print data[idx,:]
        return data


    def train(self,dir_name):
        """
        Train the system with the available informations
        """


        typeData = readData("data/zhiT2")

        #now put all the information in a format that we want to use for training
        data = None
        gtData = None
        for idx, typename in enumerate(typeList):
            #add the gt on the last column
            gt = numpy.ones((numpy.shape(typeData[typename])[0]))
            gt = gt * idx
            
            #filter the data
            tmp = self.filterData(typeData[typename])

            if data is None:
                data = tmp
                gtData = gt
            else:
                data = numpy.concatenate((data,tmp))
                gtData = numpy.concatenate((gtData,gt))


        print 'Start training classifiers'
        #train KNN classifiers
        self.knnClassifier = KNeighborsClassifier(n_neighbors=5, weights='uniform', algorithm='auto')
        self.knnClassifier.fit(data,gtData)
        #train Logistic Regression Algorithm
        self.llClassifier = LogisticRegression()
        self.llClassifier.fit(data,gtData)
        #train a SVC classifier
        self.svcClassifier = SVC(C=0.01,kernel='linear')
        self.svcClassifier.fit(data,gtData)
        #train  a linear SVM classifier
        self.lsvcClassifier = LinearSVC()
        self.lsvcClassifier.fit(data,gtData)


        print 'Finish training classifiers'



        #now we use the data to train all types of classifiers

        #effectorFile = readcsvfile("data/zhiT-3-endEffector.csv")
        #print effortFile[0,0]
        #create the combine version
        #data = numpy.zeros((numpy.shape(posFile)[0], numpy.shape(posFile)[1] + numpy.shape(effortFile)[1]))
        #data[:,0:numpy.shape(posFile)[1]] = posFile.copy()
        #data[:,numpy.shape(posFile)[1]:] = effortFile.copy()
        #now create the ground truth
        #gt = numpy.ones((numpy.shape(posFile)[0],1))

        # ptrs3D = effectorFile[:,0:3].copy()


        # fig = plt.figure()
        # ax = fig.add_subplot(111, projection='3d')
        # for pts in ptrs3D:
        #     ax.scatter(pts[0], pts[1], pts[2], c='r',marker='o')
        # plt.show()
        # #print numpy.shape(data), numpy.shape(gt)
        # #print ptrs3D

        # #train a logistic classifier
        



        # #loop through all of them to create a csv object for them

        # for file_name in file_names:
        #     with open(file_name,'rb') as csvfile:
        #         csvreader = csv.reader(csvfile, delimiter=",")
        #         for row in csvreader:
        #             print row


    def inferBatch(self,data):
        types = {}
        types["knn"] = (self.knnClassifier.predict(data)).astype(int)
        types["ll"] = (self.llClassifier.predict(data)).astype(int)
        types["svc"] = (self.svcClassifier.predict(data)).astype(int)
        types["lsvc"] = (self.lsvcClassifier.predict(data)).astype(int)
        return types

    def infer(self, data):
        #"infer what class it is in"
        knnresult = (self.knnClassifier.predict(data)).astype(int)
        llresult = (self.llClassifier.predict(data)).astype(int)
        svcresult = (self.svcClassifier.predict(data)).astype(int)
        lsvcresult = (self.lsvcClassifier.predict(data)).astype(int)
        print knnresult,llresult, svcresult, lsvcresult


def test(ji):
    #read the test file
    posFile = readcsvfile('test/test1-aPos.csv')
    effortFile = readcsvfile('test/test1-aEffort.csv')
    data = numpy.zeros((numpy.shape(posFile)[0], numpy.shape(posFile)[1] + numpy.shape(effortFile)[1]))
    data[:,0:numpy.shape(posFile)[1]] = posFile.copy()
    data[:,numpy.shape(posFile)[1]:] = effortFile.copy()

    data = ji.filterData(data)


    # for row in data:
    #     ji.infer(row.reshape(1,-1))

    #read the ground truth
    gtFile = readgtfile('test/groundT.csv')
    gtFile = gtFile.reshape((numpy.shape(gtFile)[0]))

    batch = ji.inferBatch(data)

    tp = batch["svc"]
    print numpy.shape(tp)
    print numpy.shape(gtFile)




    tmp1 = gtFile - tp
    print "& %d & %d & %d & %f"%(numpy.shape(gtFile)[0],numpy.sum(tmp1 == 0),numpy.sum(tmp1 != 0), float(numpy.sum(tmp1 == 0))/numpy.shape(gtFile)[0])
    #print numpy.sum(tmp1 != 0)

    l1, = plt.plot(tp,label='Predicted State')
    plt.setp(l1,color='r',linewidth=2.0,label='Predicted State')

    l2, = plt.plot(gtFile,label='Ground Truth')
    plt.setp(l2,color='g',linewidth=2.0,label='Ground Truth')
    plt.ylim([-0.5,6.5])
    plt.title("SVM(Linear Kernel)")
    plt.ylabel("States")
    plt.xlabel("Time Steps")

    #green_patch = mpatches.Patch(color='green', label='Ground Truth')
    #red_patch = mpatches.Patch(color='red', label='Predicted State')
    #plt.legend(handles=[red_patch, green_patch])
    plt.legend([l1,l2])

    plt.show()

    viewer(tp)
    #print batch["knn"]


def viewer(result):
    effectorFile = readcsvfile("test/test1-endEffector.csv")
    #because the numbers doesn't fit, we going to randomly taking out
    #some samples
    ssize = numpy.shape(effectorFile)[0]
    print ssize
    osize = numpy.shape(result)[0]
    print osize
    takeList = numpy.random.randint(0,high=osize,size=ssize-osize)
    print numpy.shape(takeList)
    print takeList
    print numpy.shape(effectorFile)
    effectorFile = numpy.delete(effectorFile,takeList,axis=0)
    print numpy.shape(effectorFile)

    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')




    ptrs3D = effectorFile[:,0:3].copy()
    for pts in ptrs3D:
        ax.scatter(pts[0], pts[1], pts[2], c='r',marker='o')
    #plt.show()

def main():
    print "start"
    ji = JointInferencer()
    ji.alpha = 0.1
    ji.train('data')
    test(ji)


if __name__  == "__main__":
    main()

# coding: utf-8

# In[1]:

import SUGen as su
import numpy as np


# In[2]:

import PhysConst as pc
from scipy.io import savemat
from scipy.interpolate import interp1d


# In[3]:

def fractionFromUnitaryMatrix(A):
    init_prod = np.asarray([[1.0/3,2.0/3,0],[1,0,0],[0,1,0],[0,0,1]])
    
    rowe = A[0,:]*A[0,:]
    rowmu = A[1,:]*A[1,:]
    rowtau = A[2,:]*A[2,:]
    mat2 = A*A
    termE = []
    termMu = []
    termTau = []
    for i in range(3):
        termE.append(sum(mat2[i,:]*rowe))
        termMu.append(sum(mat2[i,:]*rowmu))
        termTau.append(sum(mat2[i,:]*rowtau))
    
    
    #implementing this for testing purposes
    final_e = []
    final_mu = []
    final_tau = []

    for i in range(4):
        final_e.append(sum(init_prod[i,:]*termE))
        final_mu.append(sum(init_prod[i,:]*termMu))
        final_tau.append(sum(init_prod[i,:]*termTau))
    
    
    total = np.add(final_e, final_mu)
    total = np.add(total, final_tau)
    return final_e, final_mu, final_tau, total
        
    #final_e[i] + final_mu[i] + final_tau[i] + final_ster[i] = 1


# In[4]:

def processFile(filename):
    csv = np.genfromtxt(filename, delimiter=",")
    csv = csv[np.argsort(csv[:, 0])]
    #print csv.shape
    x = csv[:,0]
    index = []
    for i in range(len(x) - 1):
        if x[i] == x[i+1]:
            index.append(i)
    #index = index
    for i in reversed(index):
        csv = np.delete(csv,i,0)
    x = csv[:,0]
    y = csv[:,1]
    #print x.shape, y.shape
    f = interp1d(x,y)
    #f = interpld(x,y)
    return f


# In[5]:

def dagger(U):
    return np.dot((U.conjugate().T),U)


# In[6]:

def checkForCuts(mat,interpolators):
    m = mat.flatten()
    count = 0
    totalChi2 = 0
    chi2Limit = 10.42
    for i in m:
        try:
            temp = interpolators[count](i)
            if temp < -1:
                print temp, i, count
        except ValueError:
            return False
        count = count + 1
        totalChi2 = totalChi2 + temp
    
    if totalChi2 <= chi2Limit:
        print totalChi2
        return True
    else:
        return False
            
        
    


# In[ ]:

count = 0
frac_e = []
frac_mu = []
frac_tau = []
phyEl = pc.PhysicsConstants()
phyEl.numneu = 4
ndim = 3
count  = 0
U = su.SUGen(phyEl)
non_unitarity_frac = 0.1
interpolators = []
interpolators.append(processFile('ue1.csv'))
interpolators.append(processFile('ue2.csv'))
interpolators.append(processFile('ue3.csv'))
interpolators.append(processFile('umu1.csv'))
interpolators.append(processFile('umu2.csv'))
interpolators.append(processFile('umu3.csv'))
interpolators.append(processFile('utau1.csv'))
interpolators.append(processFile('utau2.csv'))
interpolators.append(processFile('utau3.csv'))
# fe2 = processFile('ue2.csv')
# fe3 = processFile('ue3.csv')
# fmu1 = processFile('umu1.csv')
# fmu2 = processFile('umu2.csv')
# fmu3 = processFile('umu3.csv')
# ftau1 = processFile('utau1.csv')
# ftau2 = processFile('utau2.csv')
# ftau3 = processFile('utau3.csv')
while True:
    U.sample_params()
    matrix = (U.matrix_gen())
    mat33 = matrix[0:3,0:3]
    
    I = np.identity(ndim)
    matDag = dagger(mat33)
    delta = np.subtract(matDag,I)
#     if count < 10:
#         print np.absolute(delta)
#         print mat33
#         count = count + 1
    if np.amax(np.absolute(delta)) <= non_unitarity_frac :
        flag = checkForCuts(np.absolute(mat33),interpolators)
        if flag == True:
            print "found one " + str(count)
            count = count + 1
            efrac, mufrac, taufrac,total = fractionFromUnitaryMatrix(np.absolute(mat33))
    #         frac_e.append(np.divide(efrac,total))
    #         frac_mu.append(np.divide(mufrac,total))
    #         frac_tau.append(np.divide(taufrac,total))
            frac_e.append(efrac)
            frac_mu.append(mufrac)
            frac_tau.append(taufrac)
        #print efrac, total
    
    if count > 1000:
        break

frac_e = np.asarray(frac_e)
frac_mu = np.asarray(frac_mu)
frac_tau = np.asarray(frac_tau)
savemat('frac_10_con.mat',mdict={'eFraction' : frac_e, 'muFrac':frac_mu, 'tauFrac':frac_tau})
    
    


# In[ ]:




#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 10:34:53 2020

@author: anandvs.guntuku
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv("DelhiGrandFinalData.csv")

x = df['AOD_imputed']
y = df['PM_imputed1']

print(x)

#training and testing
from sklearn.model_selection import train_test_split
xtr, xte, ytr, yte = train_test_split(x, y, test_size = 0.25, random_state = 3)

xtr = xtr.values.reshape(-1,1)
ytr = ytr.values.reshape(-1,1)

#training linear regression model on training set
from sklearn.linear_model import LinearRegression as lr
linreg = lr()
linreg.fit(xtr,ytr)

#training polyregression model
from sklearn.preprocessing  import PolynomialFeatures as pf
polyreg = pf(degree = 2)
x_poly = polyreg.fit_transform(xtr)
linreg2 = lr()
linreg2.fit(x_poly, ytr)

# visualising linear regression results
plt.scatter(xtr, ytr, color = 'red')
plt.plot(xtr,linreg.predict(xtr), color = 'blue')
plt.xlabel('AOD_IMPUTED')
plt.ylabel('PM2.5')
plt.title('Linear Regression')
plt.show()


# visualising poly regression results
plt.scatter(xtr, ytr, color = 'red')
plt.plot(xtr,linreg2.predict(polyreg.fit_transform(xtr)), color = 'blue')
plt.xlabel('AOD_IMPUTED')
plt.ylabel('PM2.5')
plt.title('Poly Regression')
plt.show()
















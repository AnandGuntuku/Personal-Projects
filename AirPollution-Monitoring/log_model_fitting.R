# Create a function with arguments.
new.function <- function(a,b,c) {
  result <- a * b + c
  print(result)
}

# Call the function by position of arguments.
new.function(5,3,11)

# Call the function by names of the arguments.
new.function(a = 11, b = 5, c = 3)

library(caTools)
set.seed(42)

df = read.csv('DelhiGrandFinalData.csv')

yr2016 = subset(df, year == 2016)
yr2017 = subset(df, year == 2017)
yr2018 = subset(df, year == 2018)
yr2019 = subset(df, year == 2019)
yr2020 = subset(df, year == 2020)

newfunc = function(dataset) {
  set.seed(3)
  split = sample.split(dataset, SplitRatio = 0.75)
  training_set = subset(dataset, split == TRUE)
  test_set = subset(dataset, split == FALSE)
  
  # Feature Scaling
  # training_set = scale(training_set)
  # test_set = scale(test_set)
  #year = as.factor(year)
  # Fitting Multiple Linear Regression to the Training set
 
  regressor = lm(formula = (log(PM_imputed1,2) ~ log(AOD_imputed,2) + log(RH_imputed1,2)),
                 data = training_set)
  
  # Predicting the Test set results
  y_pred = predict(regressor, newdata = test_set)
  print(summary(regressor))
  print(cor(dataset$log(PM_imputed1,2), dataset$log(AOD_imputed,2)))
  "
  #plotting
  attach(dataset)
  par(mfrow = c(2,2))
  smoothScatter(log(AOD_imputed,2), log(PM_imputed1,2), nbin = 500,
                colramp = colorRampPalette(c(white, blues9)))
  abline(regressor, lwd = 3, col = 'red')
  
  plot(RH_imputed1, log(PM_imputed1,2), pch = 20)
  abline(regressor, lwd = 3, col = 'red')
  smoothScatter(log(test_set$PM_updated,2), y_pred, pch = 20, xlim=c(0,10), ylim=c(0,10))
  abline(regressor, lwd = 3, col = 'red')
  plot(predict(regressor), residuals(regressor))
  abline(regressor, lwd = 3, col = 'red')
  max(dataset$PM_updated)
"
}

res2020 = newfunc(df)




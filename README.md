# STA141C_Final_Project

### Package: 
FinalProject

### Title: 
Applying BLB to MLR Using Parallel Processing

### Authors: 
Zhuoheng Han: hzhhan@ucdavis.edu

Christopher Ton: chrton@ucdavis.edu

Samuel Krut: sdkrut@ucdavis.edu

Valerie Tu: vttu@ucdavis.edu 
    
### Description: 
Our package enables other users to carry out bag of little boostraps for the multiple linear regression model. This package gives users to use parallel processing to get the confidence interval of sigma, the confidence interval of coefficients, and the confidence interval of prediction. Users can decide the group numbers and the bootstraps times in this package.

### Imports: 

    furrr (>= 0.1.0),
    base,
    readr,
    stats,
    stringr,
    purrr,
    future,
    
### Example:
coef_ci(data, group_number = 10, bootstrap_times = 1000)

sigma_ci(data, group_number = 10, bootstrap_times = 1000)

pred_ci(data, newdata, group_number = 10, bootstrap_times = 1000)
    

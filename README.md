# STA141C_Final_Project

### Package: 
FinalProject

### Title: 
Applying BLB to MLR Using Parallel Processing

### Authors: 

    c(person("Zhuoheng", "Han", email = "hzhhan@ucdavis.edu", role = c("aut","cre")),
    person("Christopher","Ton",email="chrton@ucdavis.edu",role = c("aut","ctb")),
    person("Samuel","Krut",email="sdkrut@ucdavis.edu",role = c("aut","ctb")),
    person("Valerie","Tu",email="vttu@ucdavis.edu",role = "ctb"))
    
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
    

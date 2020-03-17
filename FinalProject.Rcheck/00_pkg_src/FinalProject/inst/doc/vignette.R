## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE----------------------------------------------
library(FinalProject)
library(devtools)
load_all()
library(dplyr)

## ---- message = FALSE----------------------------------------------------
?coef_ci
?sigma_ci
?pred_ci

## ---- message = FALSE----------------------------------------------------
library(nycflights13)
flights = flights %>%
  mutate(time = hour*60 + minute) %>%
  select(dep_delay,arr_delay,distance,time)
y = flights$time #response variable defined
x = flights[,c(1:3)] #predictor variables subsetted
data = data.frame(y,x)
newdata = data.frame(dep_delay = c(10,20), arr_delay = c(20,30), distance = c(400,500))

## ---- message = FALSE, warning = FALSE-----------------------------------
coef_ci(data, 10, 100)
summary(lm(y~., data))$coef[,1]

## ---- message = FALSE, warning = FALSE-----------------------------------
pred_ci(data, newdata, 10, 100)
predict(lm(y~., data), newdata)

## ---- message = FALSE, warning = FALSE-----------------------------------
sigma_ci(data, 10, 100)
summary(lm(y~., data))$sigma


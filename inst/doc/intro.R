## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
set.seed(2022)
old_digits <- options(digits=2)

## ----first_example------------------------------------------------------------
library(mlr3)
library(mlr3learners)
library(cpi)

cpi(task = tsk("wine"), 
    learner = lrn("classif.ranger", predict_type = "prob", num.trees = 10),
    resampling = rsmp("cv", folds = 5))

## ----glmnet_example-----------------------------------------------------------
cpi(task = tsk("wine"), 
    learner = lrn("classif.glmnet", predict_type = "prob", lambda = 0.01),
    resampling = rsmp("holdout"))

## ----glmnet_example_ce--------------------------------------------------------
cpi(task = tsk("wine"), 
    learner = lrn("classif.glmnet", lambda = 0.01),
    resampling = rsmp("holdout"), 
    measure = msr("classif.ce"))

## ----first_example_fisher-----------------------------------------------------
cpi(task = tsk("wine"), 
    learner = lrn("classif.ranger", predict_type = "prob", num.trees = 10),
    resampling = rsmp("cv", folds = 5), 
    test = "fisher")

## ----example_seqknockoff, eval=FALSE------------------------------------------
#  mytask <- as_task_regr(iris, target = "Petal.Length")
#  cpi(task = mytask, learner = lrn("regr.ranger", num.trees = 10),
#      resampling = rsmp("cv", folds = 5),
#      knockoff_fun = seqknockoff::knockoffs_seq)

## ----example_seqknockoff_xtilde, eval=FALSE-----------------------------------
#  library(seqknockoff)
#  x_tilde <- knockoffs_seq(iris[, -3])
#  mytask <- as_task_regr(iris, target = "Petal.Length")
#  cpi(task = mytask, learner = lrn("regr.ranger", num.trees = 10),
#      resampling = rsmp("cv", folds = 5),
#      x_tilde = x_tilde)

## ----glmnet_example_group-----------------------------------------------------
cpi(task = tsk("iris"), 
    learner = lrn("classif.glmnet", predict_type = "prob", lambda = 0.01),
    resampling = rsmp("holdout"), 
    groups = list(Sepal = 1:2, Petal = 3:4))

## ----first_example_parallel, eval=FALSE---------------------------------------
#  doParallel::registerDoParallel(4)
#  cpi(task = tsk("wine"),
#      learner = lrn("classif.ranger", predict_type = "prob", num.trees = 10),
#      resampling = rsmp("cv", folds = 5))

## ---- include=FALSE-----------------------------------------------------------
options(old_digits)


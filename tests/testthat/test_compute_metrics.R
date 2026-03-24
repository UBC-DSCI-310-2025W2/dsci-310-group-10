library(testthat)
library(caret)
library(here)

library(here)
source(here("R", "compute_metrics.R"))

test_that("compute_metrics works for a simple binary case", {
  preds <- factor(c(1, 0, 1, 1))
  truth <- factor(c(1, 0, 0, 1))
  
  result <- compute_metrics(preds, truth)
  
  expect_true(is.list(result))
  expect_named(result, c("accuracy", "precision", "recall", "f1"))
  expect_true(result$accuracy <= 1 && result$accuracy >= 0)
})

test_that("compute_metrics returns perfect scores when predictions match truth", {
  preds <- factor(c(1, 0, 1, 0))
  truth <- factor(c(1, 0, 1, 0))
  
  result <- compute_metrics(preds, truth)
  
  expect_equal(result$accuracy, 1)
  expect_equal(result$precision, 1)
  expect_equal(result$recall, 1)
  expect_equal(result$f1, 1)
})


test_that("compute_metrics handles single-class predictions", {
  preds <- factor(c(1, 1, 1, 1), levels = c(0, 1))
  truth <- factor(c(1, 1, 1, 1), levels = c(0, 1))
  
  result <- compute_metrics(preds, truth)
  
  expect_equal(result$accuracy, 1)
})

test_that("compute_metrics handles imbalanced classes", {
  preds <- factor(c(1, 1, 1, 1, 0), levels = c(0, 1))
  truth <- factor(c(1, 1, 1, 1, 1), levels = c(0, 1))
  
  result <- compute_metrics(preds, truth)
  
  expect_true(result$accuracy <= 1)
  expect_true(result$accuracy >= 0)
})


test_that("compute_metrics errors when inputs are not factors", {
  preds <- c(1, 0, 1)
  truth <- c(1, 0, 1)
  
  expect_error(compute_metrics(preds, truth))
})

test_that("compute_metrics errors when lengths differ", {
  preds <- factor(c(1, 0, 1))
  truth <- factor(c(1, 0))
  
  expect_error(compute_metrics(preds, truth))
})

test_that("compute_metrics errors when factor levels differ", {
  preds <- factor(c("A", "B"))
  truth <- factor(c("A", "C"))
  
  expect_error(compute_metrics(preds, truth))
})

test_that("compute_metrics returns correct metric values (case 1)", {
  preds <- factor(c(1, 1, 0, 0), levels = c(0, 1))
  truth <- factor(c(1, 0, 1, 0), levels = c(0, 1))
  
  # Confusion matrix:
  # TP = 1 (1 predicted as 1)
  # TN = 1 (0 predicted as 0)
  # FP = 1 (1 predicted but actually 0)
  # FN = 1 (0 predicted but actually 1)
  
  # Expected:
  # accuracy = (1+1)/4 = 0.5
  # precision = 1/(1+1) = 0.5
  # recall = 1/(1+1) = 0.5
  # f1 = 0.5
  
  result <- compute_metrics(preds, truth)
  
  expect_equal(result$accuracy, 0.5)
  expect_equal(result$precision, 0.5)
  expect_equal(result$recall, 0.5)
  expect_equal(result$f1, 0.5)
})

test_that("compute_metrics returns correct metric values (case 2)", {
  preds <- factor(c(1, 1, 1, 0, 0), levels = c(0, 1))
  truth <- factor(c(1, 1, 0, 0, 0), levels = c(0, 1))
  
  # Confusion matrix:
  # TP = 2
  # TN = 2
  # FP = 1
  # FN = 0
  
  # Expected:
  # accuracy = (2+2)/5 = 0.8
  # precision = 2/(2+1) = 2/3 ≈ 0.6667
  # recall = 2/(2+0) = 1
  # f1 = 2 * (2/3 * 1) / (2/3 + 1) = 0.8
  
  result <- compute_metrics(preds, truth)
  
  expect_equal(result$accuracy, 0.8)
  expect_equal(result$precision, 2/3)
  expect_equal(result$recall, 1)
  expect_equal(result$f1, 0.8)
})

test_that("compute_metrics handles zero precision case", {
  preds <- factor(c(0, 0, 0), levels = c(0, 1))
  truth <- factor(c(1, 1, 1), levels = c(0, 1))
  
  result <- compute_metrics(preds, truth)
  
  expect_true(is.na(result$precision) || result$precision == 0)
})

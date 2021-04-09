#' ---
#' title: "Intro to Shiny"
#' author: "Gabriela Carr"
#' date: '`r format(Sys.Date(), "%B %d, %Y")`'
#' output:
#'    html_document:
#'       number_sections: true
#'       toc: true
#'       toc_float:
#'          collapsed: true

#' Install shiny packages
install.packages("shiny")
install.packages("shinythemes")

#' Load in library
library(shiny)
library(shinythemes)
library(tidyverse)

#' Run an example
runExample("01_hello")

Getting And Cleaning Data
======================

The class project for [Getting and Cleaning Data](https://www.coursera.org/course/getdata) was to read in the ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), perform an analysis on the data set, and output a tidy data set.

## Contents 
This repo contains 4 following files.
* REDME.md - ovierview of the repo
* run_analysis.R - R scrip to perform analysis
* CodeBook.md - document that describes the variables, data, and transformations
* secondary_data.cvs - which contains the tidy data set 

## About run_analysis script
If the data files for this project is not in your working directory, the script will automatically donwnload it to your working directory, then will unzip it.

For creating tidy data, this script uses reshape2 package, if it is not installed in your system, will automaticaly install.

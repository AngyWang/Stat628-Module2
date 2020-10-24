# Stat628-Module2-Group21
This project is the coursework for stat 628, in which we built a body fat percentage calculator through a data set with 252 males body features. you can find the final app of our calculator at [Body Fat Calculator](https://jiawei98.shinyapps.io/BodyFatUI/).


## Summary
Nameofsummaryfile is an summary of what we did. The results shows that the percentage of body fat of a male is can be predicted by *Weight*, *Abdomen* and *Wrist circum*.

There are four folders providing more details in our main project, *code*, *image*, *data*.

## Image
This folder contains figures produced in our analysis.

* Histogram plot and box plot for body fat is provided. Histogram of Body Fat.png is the histogram of Bodyfat for the raw data. Boxplot of Body Fat Divided By Age.png is the boxplot of Bodyfat divided by age for the raw data.
* Density plots and dotplots for explanatory variables are utilized. Density of Independent Variables Devided By Age.png contains the density plots for several independent variables. Dotplot of Forearm And Bodyfat.png and Dotplot of Weight And Bodyfat.png are the dotplots for corresponding variables.
* To check for multicollinearity, we also plotted the correlation plot. Correlation Plot.png is the correlation plot for all variables in the raw data.
* Cross Validation results can be found in Cross Validation Result For Simplest Model, Cross Validation Result For BIC Selected Model.png and Cross Validation Result For Final Model.png.
* The fitted result can be seen from Fitted Value vs Original Value.png, in which we compare the fitted values and the original data.

## Code
The provided R code file contains three parts:

* Data description and cleaning part, in which we illustrated the distributions and relationships among these variables and dropped unreasonable observations.
* Model selection part, in which we built several models, compared their validities and then made a choice.
* Model diagnosis part, in which we assess the assumptions and check the robustness, accuracy and speed.


## Data
*BodyFat.csv* is the rawdata for our study.

*BodyFat_new.csv* is the csv file after data cleaning.

## Authors
* **Xiaofeng Wang**(xwang2443@wisc.edu)
* **Jiawei Huang**(jhuang455@wisc.edu)
* **Yiran Wang**(wang2559@wisc.edu)

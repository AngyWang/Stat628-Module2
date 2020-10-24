# Stat628-Module2-
This repository contains work related to STAT 628, instructed by Prof. Hyunseung Kang. We built a simple and robust model for predicting men's body fat percentage. 

## Link to our web-based app
- [Body fat percentage Calculator](https://jiawei98.shinyapps.io/BodyFatUI/)


## Summary
Nameofsummaryfile is an summary of what we did. The results shows that the percentage of body fat of a male is can be predicted by *Weight*, *Abdomen* and *Wrist circum*.

There are four folders providing more details in our main project, *code*, *image*, *data*.

## Code
The provided R code file contains three parts:

* Data description and cleaning part, in which we illustrated the distributions and relationships among these variables and dropped unreasonable observations.
* Model selection part, in which we built several models, compared their validities and then made a choice.
* Model diagnosis part, in which we assess the assumptions and check the robustness, accuracy and speed.

## Image
This folder contains figures produced in our analysis.

* Histogram of Body Fat.png is the histogram of Bodyfat for the raw data.
* Boxplot of Body Fat Divided By Age.png is the boxplot of Bodyfat divided by age for the raw data.
* Density of Independent Variables Devided By Age.png contains the density plots for several independent variables.
* Dotplot of Forearm And Bodyfat.png and Dotplot of Weight And Bodyfat.png are the dotplots for corresponding variables.
* Correlation Plot.png is the correlation plot for all variables in the raw data.

## Data
*BodyFat.csv* is the raw data set of available measurements include age, weight, height, bmi, and various body circumference measurements. In particular, the variables listed below (from left to right in the data set) are: 

* Percent body fat from Siri's (1956) equation  
* Density determined from underwater weighing  
* Age (years)  
* Weight (lbs)  
* Height (inches)  
* Adioposity (bmi)
* Neck circumference (cm)  
* Chest circumference (cm)  
* Abdomen 2 circumference (cm)  
* Hip circumference (cm)  
* Thigh circumference (cm)  
* Knee circumference (cm)  
* Ankle circumference (cm)  
* Biceps (extended) circumference (cm)  
* Forearm circumference (cm)  
* Wrist circumference (cm)  

*new_BodyFat.Rdata* is the Rdata file after data cleaning.

## Authors
* **Xiaofeng Wang** - (xwang2443@wisc.edu)
* **Jiawei Huang** - (jhuang455@wisc.edu)
* **Yiran Wang** -　(wang2559@wisc.edu)

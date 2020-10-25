# STAT 628 Module 2
BodyFat = read.csv("BodyFat.csv") #Read data into R
attach(BodyFat) # This "attaches" the data into R. 
dim(BodyFat) # Dimension of the data (number of rows, number of columns)
colnames(BodyFat) #Variables in the Data

# Analyzing Raw Data
head(BodyFat) #Look at the first few data points 
tail(BodyFat) #Look at the last few data points
summary(BodyFat) #Gives you a brief summary statistic of all the variables in the data
# Note that the first column contains the index number of each individual.

# Step 1: Visualizing Data
library("ggplot2")
library("cowplot")
# Bodyfat description plot
# histogram
ggplot(data = BodyFat, aes(BODYFAT, fill = cut(BODYFAT, 15))) + 
        geom_histogram(bins = 50) +
        scale_fill_discrete(h = c(220, 120)) +
        labs(title = "Histogram of Body Fat %",
             x = "Body Fat %",
             y = "Frequency") +
        theme(plot.title = element_text(hjust = 0.5)) # centeirng the title
ggsave("Histogram of Body Fat.png",width = 7, height = 5)
# Boxplot
ggplot(data = BodyFat, aes(y = BODYFAT)) +
        geom_boxplot(aes(fill=cut(AGE,5)),
                     alpha = 0.5,
                     outlier.colour="red", 
                     outlier.shape=8, 
                     outlier.size=3)+
        scale_fill_discrete(h = c(220, 120)) +
        labs(title = "Boxplot of Body Fat %",
             y = "Body Fat %",
             x = "Age intervals(yrs)")  +
        theme(plot.title = element_text(hjust = 0.5))+
        coord_flip()
ggsave("Boxplot of Body Fat Divided By Age.png",width = 7, height = 5)
# Dotplot
ggplot(BodyFat, aes(WEIGHT,BODYFAT,colour = WRIST)) + 
        geom_point(alpha = 0.8) +
        scale_colour_gradient(low="white", high="green") +
        labs(title = "Dotplot of Weight And Bodyfat",
             x = "Weight",
             y = "BodyFat %") +
        theme(plot.title = element_text(hjust = 0.5)) # centeirng the title
ggsave("Dotplot of Weight And Bodyfat.png",width = 7, height = 5)
ggplot(BodyFat, aes(FOREARM,BODYFAT,colour = WRIST)) + 
        geom_point(alpha = 0.8) +
        scale_colour_gradient(low="white", high="green") +
        labs(title = "Dotplot of Forearm And Bodyfat",
             x = "Forearm",
             y = "BodyFat %") +
        theme(plot.title = element_text(hjust = 0.5)) # centeirng the title
ggsave("Dotplot of Forearm And Bodyfat.png",width = 7, height = 5)

# Independent variables
# density plot
plot.WEIGHT = ggplot(BodyFat, aes(x = WEIGHT,fill = cut(AGE,3))) +
        geom_density(alpha = 0.3) +
        guides(fill=F) +
        scale_fill_discrete(h = c(220, 120))
plot.FOREARM = ggplot(BodyFat, aes(x = FOREARM,fill = cut(AGE,3))) +
        geom_density(alpha = 0.3) +
        guides(fill=F) +
        scale_fill_discrete(h = c(220, 120))
plot.WRIST = ggplot(BodyFat, aes(x = WRIST,fill = cut(AGE,3))) +
        geom_density(alpha = 0.3) +
        guides(fill=F) +
        scale_fill_discrete(h = c(220, 120))
plot.BODYFAT = ggplot(BodyFat, aes(x = BODYFAT,fill = cut(AGE,3))) +
        geom_density(alpha = 0.3) +
        guides(fill=F) +
        scale_fill_discrete(h = c(220, 120))
densityplot = ggdraw() +
        draw_plot(plot.WEIGHT, 0, 0.5, 0.5, 0.5) +
        draw_plot(plot.FOREARM, 0.5, 0.5, 0.5, 0.5) +
        draw_plot(plot.WRIST, 0, 0, 0.5, 0.5) +
        draw_plot(plot.BODYFAT, 0.5, 0, 0.5, 0.5) +
        scale_colour_manual(values=cut(AGE,3)) +
        labs(title = "Density of Independent Variables Devided By Age") +
        theme(plot.title = element_text(hjust = 0.5)) # centeirng the title
ggsave("Density of Independent Variables Devided By Age.png",width = 7, height = 5)

# Correlation plot
library(corrplot)
corrplot(cor(BodyFat[,-c(1)]),method = "square",tl.col = "black",tl.cex=0.8,tl.srt = 45,bg = "white")




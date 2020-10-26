#Jiawei Huang: shinyapp developer
library(shiny)
library(fields)
library(ggplot2)
setwd(getwd())
BodyFat = read.csv("BodyFat_new.csv")
n = dim(BodyFat)[1]
fit = lm(BODYFAT~(WEIGHT+ABDOMEN+WRIST), data = BodyFat)

server <- function(input, output) {
  
  weight = eventReactive(input$go,{ifelse(is.na(input$weight),0,ifelse(input$weight_unit == "lbs",input$weight,2.2046*input$weight))})
  abdomen = eventReactive(input$go,{ifelse(is.na(input$abdomen),0,ifelse(input$abdomen_unit == "cm",input$abdomen,2.54*input$abdomen))})
  wrist = eventReactive(input$go,{ifelse(is.na(input$wrist),0,ifelse(input$wrist_unit == "cm",input$wrist,2.54*input$wrist))})
  esti = eventReactive(input$go,{round(as.numeric(predict(fit,data.frame(WEIGHT =weight(),ABDOMEN = abdomen(),WRIST = wrist()),interval="predict",level = 0.95)),2)})
  
  output$weight = eventReactive(input$go,{ifelse(input$weight_unit == "lbs",input$weight,2.2046*input$weight)})
  output$abdomen = eventReactive(input$go,{ifelse(input$abdomen_unit == "cm",input$abdomen,2.54*input$abdomen)})
  output$wrist = eventReactive(input$go,{ifelse(input$wrist_unit == "cm",input$wrist,2.54*input$wrist)})
  output$esti = eventReactive(input$go,{round(as.numeric(predict(fit,data.frame(WEIGHT =weight(),ABDOMEN = abdomen(),WRIST = wrist()))),2)})
  
  output$value = renderText({
    perc = round(mean(esti()[1] > BodyFat$BODYFAT)*100)
    paste0("Your estimated body fat is: ",esti()[1],"%, exceeds ",perc, " percent of people in the dataset.")
  })
  
  output$CI = renderText({
    paste0("The 95% confident interval is: [",max(0,esti()[2]),"%,",min(100,esti()[3]),"%].")
  })
  
  output$status = renderText({
    if (esti()[1] <= 2){"This body fat value is too low for people, are you sure you imported the right value?"}
    else if ((esti()[1] < 6) & (esti()[1] > 2)){"Your body status is: Essential."}
    else if ((esti()[1] < 14) & (esti()[1] >= 6)){"Your body status is: Athletes."}
    else if ((esti()[1] < 18) & (esti()[1] >= 14)){"Your body status is: Fitness."}
    else if ((esti()[1] < 25) & (esti()[1] >= 18)){"Your body status is: Average."}
    else if ((esti()[1] < 50) & (esti()[1] >= 25)){"Your body status is: Obese."}
    else if (esti()[1] >50){"This body fat value is too high for people, are you sure you imported the right value?"}
  })
  
  output$plot = renderPlot({
    ggplot(BodyFat, aes(x=BODYFAT))+geom_density(color="grey", fill="skyblue",size=1,alpha=0.4)+
    geom_vline(aes(xintercept=esti()[1]),color="darkblue", size=1.5) + 
    geom_vline(aes(xintercept=max(0,esti()[2])), colour="darkred", linetype="dashed", size=1.5) +
    geom_vline(aes(xintercept=min(100,esti()[3])), colour="darkred", linetype="dashed", size=1.5) +
    theme_minimal() +theme(legend.title = element_blank()) +
    scale_x_continuous(limits=c(0, 50)) +
    labs(title="Density Plot of BodyFat%",
         caption = "The dark blue line stands for your estimated bodyfat, the dark red dashed line stands for the 95% confidence interval.") +
    theme(plot.title = element_text(size = 20,hjust = 0.5),plot.caption = element_text(size = 12, face = "italic"),axis.title = element_text(size=14))
    #abline(v = esti,col = "red")
  }, height = 300, width = 800)
  
  output$plot2 = renderPlot({
    myPalette = colorRampPalette(c("green", "yellow", "orange", "red"))
    plot(0:1, 0:1, type="n", bty="n", xaxs="i",
         xaxt="n", yaxt="n", xlab="", ylab="")
    colorbar.plot(0.5, 0.95, 1:100, col=myPalette(100),
                  strip.width = 0.2, strip.length = 4.2)
    axis(side=3, at=c(0.035,0.09,0.15,0.195,0.28)/50*100, tick=FALSE,
         labels=c("Essential\n2~5%", "Athletes\n6~13%", "Fitness\n14~17%", "Average\n18~25%","Obese\n25%+")) 
    arrows(esti()[1]/50, 0.85, esti()[1]/50, 1.05, length=0, lwd=4.5,col = "darkblue")
  }, height = 300, width = 800)
  
  outputOptions(output, 'weight', suspendWhenHidden=FALSE)
  outputOptions(output, 'abdomen', suspendWhenHidden=FALSE)
  outputOptions(output, 'wrist', suspendWhenHidden=FALSE)
  outputOptions(output, 'esti', suspendWhenHidden=FALSE)
}




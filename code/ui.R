#Jiawei Huang: shinyapp developer
library(shiny)
library(fields)
setwd(getwd())
BodyFat = read.csv("BodyFat_new.csv")
n = dim(BodyFat)[1]
fit = lm(BODYFAT~(WEIGHT+ABDOMEN+WRIST), data = BodyFat)
predict(fit,newdata=data.frame(WEIGHT=154.25,ABDOMEN=85.2,WRIST = 17.1),interval="predict",level = 0.95)

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
      
      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.5;
      }

    "))
  ),

  headerPanel(h1("Body Fat Calculator")),
  sidebarPanel(width = 3,style = "background:rgba(135, 206, 235, 0.3)",
               h4("Please import features:"),
               #weight
               div(style="display: inline-block;vertical-align:top; width: 120px;",numericInput("weight", "Weight",round(mean(BodyFat$WEIGHT)))),
               div(style="display: inline-block;vertical-align:top; width: 90px;",selectInput("weight_unit", "unit",c('lbs','kg'), selected='lbs')),br(),
               #abdomen
               div(style="display: inline-block;vertical-align:top; width: 120px;",numericInput("abdomen", "Abdomen circum", round(mean(BodyFat$ABDOMEN)))),
               div(style="display: inline-block;vertical-align:top; width: 90px;",selectInput("abdomen_unit", "unit",c('cm',"inches"), selected='cm')),br(),
               #wrist
               div(style="display: inline-block;vertical-align:top; width: 120px;",numericInput("wrist", "Wrist circum", round(mean(BodyFat$WRIST)))),
               div(style="display: inline-block;vertical-align:top; width: 90px;",selectInput("wrist_unit", "\n unit",c('cm','inches'), selected='cm')),br(),
               actionButton("go",style = "padding:8px; font-size:100%;background:rgba(0, 69, 107, 0.2);font-family:'Anton';font-weight: Bold;", "Calculate Body Fat!"),
               h5(div(HTML("*<em>Note: this calculator is for adult male only.</em>")))),            

  mainPanel(
    tabsetPanel(
      tabPanel("Body Fat Estimation",
       wellPanel(style = "background: transparent;border-color:transparent",
                 conditionalPanel(
                   condition = "output.weight > 5 && output.weight <= 1000 && output.abdomen > 10 && output.abdomen <=500 && output.wrist > 5 && output.wrist <= 80 && output.esti > 0 && output.esti < 100",
                   h4(textOutput("value")),
                   h4(textOutput("CI")),
                   h4(textOutput("status")),
                   plotOutput("plot"),
                   plotOutput("plot2")),
                 conditionalPanel(
                   condition = "output.weight <= 5 || output.weight > 1000 || output.abdomen <= 10 || output.abdomen > 500 || output.wrist <= 5 || output.wrist > 80 || output.esti <= 0 || output.esti >= 100",
                   h4(style="color:red","Opps! Seems that you have imported a wrong value, please check and input again."),br(),
                   h4("This might because:"),
                   h4("1. You imported a empty value in either the 3 input boxes."),
                   h4("2. You imported a value too low or too high for people in either the 3 input boxes."),
                   h4("3. The estimated body fat can't be real for people.(around 100% or apprximate 0%)")
                 ))),
      tabPanel("Contact info",h5("For any questions concerning this app, please contact the developer"),
               h4(div(HTML("Jiawei Huang, Email: <em>jhuang455@wisc.edu</em>")))))
  )
)




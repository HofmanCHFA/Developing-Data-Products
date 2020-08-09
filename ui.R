#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application
shinyUI(fluidPage(

    # Application title
    titlePanel("MPG prediction based on mtcars data"),

  
    # Sidebar with options selectors
    sidebarLayout(
        sidebarPanel(
            helpText("This application is a predictor for MPG of a car based on its weight and other characteristics."),
                h3(helpText("Select:")),
                selectInput("am", label = h4("Transmission Type"),
                        choices = list("Automatic" = 0, "Manual" = 1)),
                numericInput("wt", label = h4("Weight"), step = 0.1, value = 3.2, min = 1),
                numericInput("cyl", label = h4("Number of Cylinders"), step = 1, value = 4, min = 1),
                numericInput("disp", label = h4("Displacement"), step = 0.1, value = 230.7, min = 100),
                numericInput("hp", label = h4("Horse Power"), step = 1, value = 147, min = 1),
                numericInput("qsec", label = h4("1/4 mile time"), step = 0.01, value = 17.85, min = 0),
                numericInput("gear", label = h4("Number of Forward gears"), step = 1, value = 4, min = 1),
                numericInput("carb", label = h4("Number of Carburators"), step = 1, value = 1, min = 1)
            ),
        # Show a plot with mpg and regression line
        mainPanel(
            plotOutput("distPlot"),
            h4("Predicted value of MPG is:"),
            h3(textOutput("result"))
        )
    )
    ))
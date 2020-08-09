#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(rsconnect)

# Define server logic
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        #enter data and fix formats
        cars <- as_tibble(mtcars)
        cars$cyl <- as.integer(cars$cyl)
        cars$gear <- factor(cars$gear, ordered = TRUE)
        cars$carb <- factor(cars$carb, ordered = TRUE)
        cars$am <- as.factor(cars$am)
        cars$cyl <- as.factor(cars$cyl)
        cars <- filter(mtcars, grepl(input$am, am))
        # build linear regression model
        fit <- lm( mpg ~ wt + cyl + disp + qsec + gear + carb + hp, data = cars, na.action=na.exclude)

        # predicts the mpg
        pred <- predict(fit, newdata = data.frame(cyl = input$cyl,
                                                  disp = input$disp,
                                                  wt = input$wt,
                                                  qsec = input$qsec,
                                                  hp = input$hp,
                                                  gear = input$gear,
                                                  carb = input$carb))
        # Draw the plot using ggplot2
        plot <- ggplot(data=cars, aes(x=wt, y = mpg))+
            geom_point(aes(color = as.factor(cyl)), alpha = 0.3)+
            geom_smooth(method = "lm")+
            geom_vline(xintercept = input$wt, color = "red")+
            geom_hline(yintercept = pred, color = "red")
        plot

    })

    output$result <- renderText({
        # Renders the text for the prediction below the graph
        cars <- filter(mtcars, grepl(input$am, am))
        fit <- lm( mpg~wt  + cyl + disp + qsec + gear + carb + hp, cars, na.action=na.exclude)
        pred <- predict(fit, newdata = data.frame(cyl = input$cyl,
                                                  disp = input$disp,
                                                  wt = input$wt,
                                                  qsec = input$qsec,
                                                  hp = input$hp,
                                                  gear = input$gear,
                                                  carb = input$carb))
        res <- paste(round(pred),"MPG" )
        res
    })
    
})

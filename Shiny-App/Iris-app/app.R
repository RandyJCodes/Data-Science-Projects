### Author Randall Jackson
# Built in R 3.6.3 
# Run successfully on Windows 10
# Purpose: Shiny app that compares correlation variables for Sepal Width, petal Length, and petal width from the Iris Dataset. 

head(iris) # For reference in R console
library(shiny)
library(ggplot2)

ui <- dashboardPage(

    dashboardHeader(title = "Analysis on Iris Dataset"),


    dashboardSidebar(
	#Sidebar menu can be updated with more tabs. 
        sidebarMenu(
            menuItem("Correlation", tabName = "Correlation", icon = icon("dashboard"))
        )

    ),


    dashboardBody(
	# Created as tab option because that would allow for future updates to the app for other types of analysis on the Iris data. 

            tabItem("Correlation", 
                    box(plotOutput("corr.plot"), width = 8, solidHeader = TRUE, status = "primary"), 
                    box(selectInput(inputId = "selection", label = "selection: ", 
                                    choices = c("Sepal.Width", "Petal.Length", "Petal.Width")), width = 4,
                        collapsible = TRUE, status = "primary")),
))


server <- function(input, output) {

	#Interactive function included with Correlation Plot
    output$corr.plot <- renderPlot({
        plot(iris$Sepal.Length, iris[[input$selection]], xlab = "sepal length", ylab = "selection", 
             main = "Correlation plot between variables")
    })

}


shinyApp(ui, server)

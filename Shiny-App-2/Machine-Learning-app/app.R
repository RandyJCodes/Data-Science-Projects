### Author Randall Jackson
# Built in R 3.6.3 
# 
# Purpose: A few Visualization challenges for an R assignment. 
# install.packages("shinydashboard") 
# install.packages("shiny") 
# install.packages("ggplot2") 

library(shiny)
library(ggplot2)
library(shinydashboard)


data <- read.csv('housing.csv')
head(data) # For reference in R console



ui <- dashboardPage(

    dashboardHeader(title = "Data Visualization on Housing Dataset"),


    dashboardSidebar(

        sidebarMenu(
           selectInput(inputId = "Choice", label = "Select a chart:", c("Total of homes"= "Home Data", "Population Vs Households"= "Pop Vs Household", "Total Rooms vs Total Bedrooms"= "Room Vs Bedroom") 
        )

    ),

    dashboardBody(

        tabItem(tabName="Home Data", 
            box(PlotOutput(output$homeBar),
        tabItem(tabName="Pop Vs Household", 
            box(PlotOutput(output$popPlot),
        tabItem(tabName="Room Vs Bedroom", 
            box(PlotOutput(output$roomPlot)
        )
    )
)


server <- function(input, output) {


    new_data <- reactive ({
        d = data %>% mutate(selected_choice = input$choice)
    })

    output$corr.plot <- renderPlot({
        plot(data$Sepal.Length, iris[[input$selection]], xlab = "sepal length", ylab = "selection", 
             main = "Correlation plot between variables")
    })

    output$homeBar <- renderPlot({
        newdata =  new_data()
    p <- ggplot(newdata, aes(x='ocean_proximity', y ='households', fill='') +
        geom_bar(stat ='identity', fill="blue")+
        theme_minimal() +
        ggtitle("Total Population")
        p
    })

    output$popPlot <- renderPlot({
        newdata =  new_data()
    p <- ggplot(data, aes(x='population', y ='households', fill='ocean_proximity') +
        geom_point()+
        theme_minimal() +
        ggtitle("Population Vs Household Size")
        p
    })

    output$roomPlot <- renderPlot({
        newdata =  new_data()
    p <- ggplot(data, aes(x='Total_bedrooms', y ='total_rooms', fill='ocean_proximity') +
        geom_point()+
        theme_minimal() +
        ggtitle("Population Vs Household Size")
        p
    })
)}


shinyApp(ui, server)


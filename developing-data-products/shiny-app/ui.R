library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
    
    headerPanel("Shiny App demo for Coursera"),

    sidebarPanel(
        includeMarkdown("documentation.md"),
        radioButtons("dist", "Distribution type:",
                     list("Normal" = "norm",
                          "Exponential" = "exp")),
        br(),
        
        sliderInput("n", 
                    "Number of observations:", 
                    value = 50,
                    min = 1, 
                    max = 100)
    ),
    
    mainPanel(
        tabsetPanel(
            tabPanel("Plot", plotOutput("plot")), 
            tabPanel("Summary", verbatimTextOutput("summary")), 
            tabPanel("Table", tableOutput("table"))
        )
    )
))
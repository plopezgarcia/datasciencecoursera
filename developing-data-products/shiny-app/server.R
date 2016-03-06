library(shiny)
library(markdown)

shinyServer(function(input, output) {
    
    data <- reactive({  
        dist <- switch(input$dist,
                       norm = rnorm,
                       exp = rexp,
                       rnorm)
        
        dist(input$n)
    })
    
    output$plot <- renderPlot({
        dist <- input$dist
        n <- input$n
        
        hist(data(), 
             main=paste('r', dist, '(', n, ')', sep=''))
    })
    
    output$summary <- renderPrint({
        summary(data())
    })
    
    output$table <- renderTable({
        data.frame(x=data())
    })
})
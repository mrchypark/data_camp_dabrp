# 모듈화 되기 전                                        
library(shiny)                                            
                                    
  ui <- fluidPage(                                   
    sliderInput(inputId = "num",         
                label = "Choose a number",        
                 value = 25, min = 1, max = 100),   
    plotOutput("hist"),                 
    verbatimTextOutput("stats")         
  )                                                         
                              
    server <- function(input, output) {  
                            
      data <- rnorm(input$num)                
               
          output$hist <- renderPlot({               
            hist(data )                           
          })                                                        
          output$stats <- renderPrint({        
            summary(data)                     
          })                                                            
    }                                                                
                                      
shinyApp(ui = ui, server = server)     
      
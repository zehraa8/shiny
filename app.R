library(shiny)
library(shinythemes)
library(highcharter)
library(reactable)
library(formattable)
library(reactablefmtr)
library(data.table)
library(tidyverse)
library(dplyr)
library(plotly)


data<-iris
# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme("cosmo"),
  tags$head(tags$style('
   body {
      font-family: Montserrat; 
      font-size: 15px; 
   }'
  )),
  navbarPage('Deneme 1',
             tabPanel('Page 1.1',
                      tabsetPanel(
                        tabPanel('a',
                                 h1(textOutput("baslik1")),
                                 br(),
                                 # fluidRow(splitLayout(cellWidths = c("35%","35%","30%"),selectInput('input1','Tür Seç!!:', choices = unique(data$Species), multiple = T))
                                 #          ),
                                 
                                 fluidRow(column(6,selectInput('input1','Tür Seç!!:', choices = unique(data$Species), multiple = T)),column(6, ) ),
                                 
                                 
                                 br(),
                                 reactableOutput('reactable1'),br(),
                                
                                 
                                 dataTableOutput("datatable1")
                                 
                                 
                                 ),
                        tabPanel('b'),
                        
                        tabPanel('c')
                      )
               
             ),
             
             tabPanel('Page 1.2',
               tabsetPanel(
                 tabPanel('d'),
                 tabPanel('e')
               )
               
             )
             
             
    
  )
  
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$baslik1<-renderText(paste(input$input1,"  bla bla"))
  
  data1<-reactive({
    iris[iris$Species %in% input$input1,]
  })
  
  output$reactable1<-renderReactable({
    reactable(data1(),minRows = 8,defaultPageSize = 8,outlined=T,filterable = T,
              bordered = TRUE,)
  })
  output$datatable1<-renderDataTable({
    datatable(
      data1(), extensions = 'Buttons', options = list(pageLength = 5,
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
      ), filter = "top"
    )
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

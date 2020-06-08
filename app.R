# test
dkfjdkdfkdjdfd
more changes 
MOOOORE
back to default!!

  
library(shiny)
library(htmltools)

dataset <- diamonds
ui <- fluidPage(
  
  fluidRow(
    column(3,
           numericInput("num", label = h3("# items in hunt"), value = 5),
           br(),
           textInput("p1", label = "Person 1", value = "name 1"),
           textInput("p2", label = "Person 2", value = "name 2"),
           actionButton("add", "Add list")
    ),
    
    column(4,
           
           checkboxGroupInput("items1", label = h3("Person 1 list"), 
                              choices = list("salt" = 1, "soy sauce" = 2),
                              selected =  NULL)
    ), 
    
    column(4,
           checkboxGroupInput("items2", label = h3("Person 2 list"), 
                              choices = list("salt" = 1, "soy sauce" = 2),
                              selected =  NULL)
    )
  )
)
server <- function(input, output, session) {
  
  observeEvent(input$add, {
    for(i in input$num:1){
      insertUI(
        selector = "#add",
        where = "afterEnd",
        ui = tags$div(
          textInput(paste0('txt', i), "insert")
        )
      )
    }
  })
  
  observe( {
    if(is.null(input$num)){
      num_items <- numeric(0)
    }else{
      num_items <- input$num
    }
    if(is.null(input$p1)){
      p1 <- character(0)
    }else{p1 <- input$p1}
    
    if(is.null(input$p2)){
      p2 <- character(0)
    }else{p2 <- input$p2}
    
    if (is.null(input$txt1)){
      my_choices <- character(0)
    } else{
      
      my_choices <- list()
      for(i in 1:num_items){
        my_choices[[i]] = input[[paste0('txt', i)]]
      }
      updateCheckboxGroupInput(session, "items1",
                               label = p1 ,
                               choices = my_choices,
                               selected = NULL
      )
      updateCheckboxGroupInput(session, "items2",
                               label = p2,
                               choices = my_choices,
                               selected = NULL
      )
    }
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

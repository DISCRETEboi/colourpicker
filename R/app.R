library(shiny)

ui <- fluidPage(
  actionButton("launch", "Launch Shiny Gadget"),
  textOutput("text")
)

server <- function(input, output, session) {
  observeEvent(input$launch,
               colourPickerGadget()
               )
  output$text <- renderText("Yes")
}

shinyApp(ui, server)

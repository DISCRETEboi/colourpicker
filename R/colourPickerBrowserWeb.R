library(shiny)
library(miniUI)

#colourPicker <- function(numCols = 3) {
#  colourPickerGadget(numCols)
#}
#
#colourPickerGadget <- function(numCols = 3) {

  shiny::addResourcePath("cpg", system.file("gadgets", "colourpicker", package = "colourpicker"))

  ui <- fluidPage(
    shinyjs::useShinyjs(),
    shinyjs::extendShinyjs(
      script = file.path("cpg", "js", "shinyjs-funcs.js"),
      functions = c()
    ),
    tags$head(
      tags$link(rel="stylesheet", href = file.path("cpg", "css", "app.css")),
    ),
#
#     gadgetTitleBar(
#       span(strong("Colour Picker"),
#            span(id = "author", "By",
#                 a(href = "https://deanattali.com", "Dean Attali")))
#     ),
    div(
      actionButton("cancel", "Cancel", width = '80px'),
      actionButton("done", "Done", width = '80px',
                   style = "color:white; background-color:#005090; float:right")
    ),
    hr(),
    # Header section - shows the selected colours
    div(
      id = "header-section",
      div(
        id = "header-title",
        "Selected colours"
      ),
      div(
        id = "selected-cols-row",
        div(id = "addColBtn",
            icon("plus"),
            title = "Add another colour"
        ),
        div(id = "removeColBtn",
            icon("trash-alt"),
            title = "Remove selected colour"
        ),
        uiOutput("selectedCols", inline = TRUE)
      ),
      checkboxInput(
        "returnTypeName",
        "Return colour name (eg. \"white\") instead of HEX value (eg. #FFFFFF) when possible",
        width = "100%"
      ),
      actionLink("showShortcuts", "Show keyboard shortcuts")
    ),

    tabsetPanel(

      # Tab 1 - choose any colour
      tabPanel(
        "Any colour",
        icon = icon("globe"),
#        miniContentPanel(
          div(
            id = "anycolarea",
            br(),
            colourpicker::colourInput(
              "anyColInput", "Select any colour", showColour = "both",
              value = "white", allowTransparent = TRUE)
          )
#        )
      ),

      # Tab 2 - choose an R colour similar to a colour you choose
      tabPanel(
        "Find R colour",
        icon = icon("search"),
#        miniContentPanel(
          fluidRow(
            column(
              6,
              colourpicker::colourInput(
                "rclosecolInput", "Show R colours similar to this colour",
                showColour = "both", value = "orange")
            ),
            column(
              6,
              div(id = "customSliderContainer",
                  sliderInput("numSimilar", "How many colours to show",
                              min = 1, max = 40, value = 8, step = 1)
              )
            )
          ),
          br(),
          strong("Click a colour to select it"),
          uiOutput("rclosecolsSection")
#        )
      ),

      # Tab 3 - choose any R colour
      tabPanel(
        "All R colours",
        icon = icon("paint-brush"),
#        miniContentPanel(
          strong("Click a colour to select it"),
          br(),
          img(id = "allcols-spinner",
              src = file.path("cpg", "img", "ajax-loader.gif")
          ),
          uiOutput("allColsSection")
#        )
      )
    )
  )

  server <- function(input, output, session) {

  }

  shinyApp(ui, server)
#}

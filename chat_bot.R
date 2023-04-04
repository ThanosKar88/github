library(shiny)

ui <- fluidPage(
  titlePanel("Chat Bot"),
  sidebarLayout(
    sidebarPanel(
      textInput("input", "Enter message:")
    ),
    mainPanel(
      verbatimTextOutput("output")
    )
  )
)

server <- function(input, output) {
  
  bot <- function(message) {
    if (grepl("hello|hi|hey", message, ignore.case = TRUE)) {
      return("Hello! How can I help you?")
    } else if (grepl("bye|goodbye", message, ignore.case = TRUE)) {
      return("Goodbye! Have a nice day.")
    } else if (grepl("thanks|thank you", message, ignore.case = TRUE)) {
      return("You're welcome!")
    } else {
      return("I'm sorry, I don't understand. Can you please rephrase your message?")
    }
  }
  
  output$output <- renderText({
    message <- input$input
    bot_response <- bot(message)
    paste("You:", message, "\n", "Bot:", bot_response)
  })
}

shinyApp(ui = ui, server = server)

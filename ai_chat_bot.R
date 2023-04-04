# Load necessary packages
library(shiny)
library(googleAuthR)
library(googleCloudRunner)

# Authenticate with GCP
options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/cloud-platform",
                                        "https://www.googleapis.com/auth/dialogflow"))
gar_auth()

# Set up the Dialogflow CX project and credentials
project_id <- "your_project_id"
location_id <- "your_location_id"
agent_id <- "your_agent_id"
session_id <- paste("session_", as.numeric(Sys.time()), sep = "")
client <- dfcx_auth(project_id, location_id, agent_id)

# Define UI
ui <- fluidPage(
  titlePanel("AI Chatbot"),
  sidebarLayout(
    sidebarPanel(
      textInput("user_input", "Enter your message:"),
      actionButton("send", "Send")
    ),
    mainPanel(
      textOutput("bot_output")
    )
  )
)

# Define server
server <- function(input, output) {
  # Define function to handle user input
  process_input <- function(input_text) {
    # Send user input to Dialogflow CX for processing
    query_input <- dfcx_text_query_input(input_text)
    response <- dfcx_detect_intent(client, session_id, query_input)
    response_text <- response$query_result$fulfillment_text
    
    return(response_text)
  }
  
  # Define action for the send button
  observeEvent(input$send, {
    bot_output <- process_input(input$user_input)
    output$bot_output <- renderText(bot_output)
  })
}

# Run the app
shinyApp(ui = ui, server = server)

shinyUI(fluidPage(
  # Add Javascript
  tags$head(
    tags$link(rel="stylesheet", type="text/css",href="style.css"),
    tags$script(type="text/javascript", src = "md5.js"),
    tags$script(type="text/javascript", src = "passwdInputBinding.js")
  ),
  useShinyjs(),
  
  #titlePanel(""),
  
  uiOutput("app")
))























# ui <- navbarPage("Rilievi Visite Ispettive Interne",
# 
# 
# 
#                  tabPanel("Database rilievi",
#                           useShinyalert(),
#                           mainPanel("",
# 
#                                     DT::dataTableOutput("dt")
# 
#                           )
#                  ),
#  tabPanel("Risultati totale IZSLER",
# 
#           sidebarPanel(
#             sliderInput("anno2",
#                         label = "anno",
#                         min = 2012, max = 2018, value = c(2018)),
#             selectInput("rilievo2", label = "tipo di rilievo",
#                         choices = c("NC", "COMM"),
#                         selected="NC")
#           ),
# 
#           mainPanel(
#           fluidPage(
# 
#             column(12,
#                           plotOutput("plot1", height = "600px")
#                     )
#                  )
#           )),
#   tabPanel("Risultati per struttura",
# 
#     sidebarPanel(
#       selectInput("struttura",
#                   label = "Struttura",
#                   choices = c("BG", "BS",
#                               "BR", "BT","CR","FE","FO","GE","LA",
#                               "LO","LU", "MC","MI","MN","MO","PC","PR",
#                               "PV","RE","RS","SC","SE","SO","SQ","UAQ","VA",
#                               "VI","AM","BE+TR"),
#                   selected = "BG"),
# 
#       sliderInput("anno",
#                   label = "anno",
#                   min = 2012, max = 2018, value = c(2018)),
# 
#       selectInput("rilievo", label = "tipo di rilievo",
#                          choices = c("NC", "COMM"),
#                   selected="NC")
#     ),
# 
# mainPanel("Numero rilievi per anno, struttura e tipologia",
#           plotOutput("plot", height="600px")
#          )
# 
#    )
# 
# 
# )


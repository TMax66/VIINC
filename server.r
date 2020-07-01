credentials <- list("VIINC" = "2019", "test"="123")
server <- function(input, output) {

  USER <- reactiveValues(Logged = FALSE)
  
  observeEvent(input$.login, {
    if (isTRUE(credentials[[input$.username]]==input$.password)){
      USER$Logged <- TRUE
    } else {
      show("message")
      output$message = renderText("Invalid user name or password")
      delay(2000, hide("message", anim = TRUE, animType = "fade"))
    }
  })
  
  output$app = renderUI(
    if (!isTRUE(USER$Logged)) {
      fluidRow(column(width=4, offset = 4,
                      wellPanel(id = "login",
                                textInput(".username", "Username:"),
                                passwordInput(".password", "Password:"),
                                div(actionButton(".login", "Log in"), style="text-align: center;")
                      ),
                      textOutput("message")
      ))
    } else {
      
      ui <- navbarPage("Rilievi Visite Ispettive Interne",
                       theme = shinytheme("cerulean"),        
                       
                       
                       
                       tabPanel("Risultati totale IZSLER",
                                
                                sidebarPanel(
                                  sliderInput("anno2",
                                              label = "anno",
                                              min = 2012, max = 2019, value = c(2019)),
                                  selectInput("rilievo2", label = "tipo di rilievo",
                                              choices = c("NC", "COMM"),
                                              selected="NC"), 
                                  br(),
                                  hr(),
                                  tags$b("n. rilievi per anno"),
                                  plotOutput("trend")
                                ),
                                
                                mainPanel(
                                  fluidPage(
                                    
                                    column(12,
                                           plotOutput("plot1", height = "600px")
                                    )
                                  )
                                )),
                       tabPanel("Risultati per struttura",
                                
                                sidebarPanel(
                                  selectInput("struttura",
                                              label = "Struttura",
                                              choices = c("BG", "BS",
                                                          "BR", "BT","CR","FE","FO","GE","LA",
                                                          "LO","LU", "MC","MI","MN","MO","PC","PR",
                                                          "PV","RE","RS","SC","SE","SO","SQ","UAQ","VA",
                                                          "VI","AM","BE+TR"),
                                              selected = "BG"),
                                  
                                  sliderInput("anno",
                                              label = "anno",
                                              min = 2012, max = 2019, value = c(2019)),
                                  
                                  selectInput("rilievo", label = "tipo di rilievo",
                                              choices = c("NC", "COMM"),
                                              selected="NC"),
                                  hr(),
                                  plotOutput("plot", height="400px"),
                                  hr(),
                                  tags$b("numero di rilievi per anno"),
                                  plotOutput("trends")
                                ),
                                
                                mainPanel("",
                                          DT::dataTableOutput("dt2")

                                )
                                
                       ),
                       tabPanel("Database rilievi",
                                useShinyalert(),
                                mainPanel("",
                                      fluidRow( 
                                        column(12, 
                                          DT::dataTableOutput("dt", width="1200px")
                                        )
                                      )
                                )
                       )
                       
                       
      )})

 ##########codici per il grafico IZSLER############### 
    dx1<-reactive({
        df %>% 
        group_by(anno,p.norma,tiporilievo) %>% 
        summarise('n.rilievi'=n()) %>% 
        filter(!is.na(p.norma)) %>% 
        filter(anno==input$anno2, tiporilievo==input$rilievo2) %>% 
        arrange(n.rilievi)
    })
    
    
output$plot1<- renderPlot({
    dx1() %>% 
    as.data.frame()%>%
    mutate(p.norma = factor(p.norma, unique(p.norma))) %>% 
    ggplot(aes(x=p.norma,y=n.rilievi,label=n.rilievi))+
    geom_point(stat='identity',col="lightblue", size=8)+
    geom_text(color="black", size=3)+ 
    geom_segment(aes(x=p.norma, 
                     xend=p.norma, 
                     y=0,
                     yend= n.rilievi -0.1
    ))+
    labs(title="n rilievi",caption=Sys.Date()) +  
    coord_flip()
  })

######################################################
  
dx2<-reactive({df %>% 
    group_by(anno,strutture, p.norma,tiporilievo, rilievo) %>% 
    filter(anno==input$anno,strutture==input$struttura, tiporilievo==input$rilievo) %>% 
    select(anno, "punto della norma"=p.norma, "tipo rilievo"=tiporilievo, rilievo, -strutture, reiterata)
})


  output$dt2<- DT::renderDataTable(
    dx2(),class = 'cell-border stripe', 
    rownames = FALSE, options = list(paging = TRUE, autoWidth = TRUE,pageLength = 20, searching=FALSE)
  )
  
  
  
  dx<-reactive({df %>% 
      group_by(anno,strutture,p.norma,tiporilievo) %>% 
      summarise('n.rilievi'=n()) %>% 
      filter(!is.na(p.norma)) %>% 
      filter(anno==input$anno,strutture==input$struttura, tiporilievo==input$rilievo) %>% 
      arrange(n.rilievi)
  })
  
  
  output$plot<- renderPlot({

    if(dim(dx()[1])==0) 
    {shinyalert("Oops!", "Non ci sono dati per gli input inseriti.", type = "error")} 
    else{
      dx() %>% 
      as.data.frame()%>%
      mutate(p.norma = factor(p.norma, unique(p.norma))) %>% 
      ggplot(aes(x=p.norma,y=n.rilievi,label=n.rilievi))+
      geom_point(stat='identity',col="lightblue", size=8)+
      geom_text(color="black", size=3)+
      geom_segment(aes(x=p.norma, 
                       xend=p.norma, 
                       y=0,
                       yend=n.rilievi-0.1
      ))+
      labs(title="n rilievi",caption=Sys.Date()) +  
      coord_flip()+ theme_clean()
    }
  })

  # df2<-reactive({ 
  #   df %>%
  #     mutate_if(is.character, as.factor) %>% 
  #     mutate(anno, "anno"=factor(anno)) %>% 
  #     select(anno,strutture, "tipologia rilievo"=tiporilievo, rilievo, 
  #            "punto della norma"=p.norma, ispettore) %>% 
  #     as.data.frame()
  # 
  #   })
  
  dfx<-reactive({df2})
  
  output$dt<- DT::renderDataTable(
    dfx(),  server= FALSE,filter = 'top', extensions = 'Buttons',class = 'cell-border stripe', 
    rownames = FALSE, options = list(
      dom = 'Bfrtip',paging = TRUE, autoWidth = TRUE,
      pageLength = 20,buttons = c("csv",'excel'))
    )
  

  output$trends<-renderPlot({df2 %>% 
    group_by(anno) %>% 
    filter(strutture==input$struttura) %>% 
    summarise('n.rilievi'=n()) %>% 
    ggplot(aes(x=anno, y=n.rilievi, group=1))+geom_line()+ geom_point(color="navy", size=2)+
    theme_clean()})
  
  output$trend<-renderPlot({df2 %>% 
      group_by(anno) %>% 
      summarise('n.rilievi'=n()) %>% 
      ggplot(aes(x=anno, y=n.rilievi, group=1))+geom_line()+ geom_point(color="navy", size=2)+
      theme_clean()})
  
  
  
  
}





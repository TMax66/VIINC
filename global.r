library(shiny)
library(tidyverse)
library(shinyalert)
library(shinyjs)
library(readxl)
library(shinythemes)
library(ggthemes)

######codici per ottenere l'autorizzazione al drive di google da fare una sola volta###
# library(googledrive)
# options(gargle_oauth_cache = ".secrets")
# gargle::gargle_oauth_cache()
# drive_auth()
# list.files(".secrets/")#<---questo codice fa solo vedere il file presente nella cartella .secrets creata dal codice
##precedente... la cartella .secrets deve essere inserita tra i documenti da mettere nel deploy per le applicazioni shiny

 
df <- read_excel("NCdbase.xls")


df2 <-df %>%
  mutate_if(is.character, as.factor) %>% 
  mutate(anno, "anno"=factor(anno)) %>% 
  select(anno,strutture, "tipologia rilievo"=tiporilievo, rilievo, 
         "punto della norma"=p.norma, ispettore, reiterata) %>% 
  as.data.frame()
  
  

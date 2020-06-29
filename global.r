library(shiny)
library(tidyverse)
library(googlesheets)
library(shinyalert)
library(shinyjs)

rm(list=ls())
sheet <- gs_title("NCdbase")
df<-gs_read(sheet)


df2 <-df %>%
  mutate_if(is.character, as.factor) %>% 
  mutate(anno, "anno"=factor(anno)) %>% 
  select(anno,strutture, "tipologia rilievo"=tiporilievo, rilievo, 
         "punto della norma"=p.norma, ispettore) %>% 
  as.data.frame()
  
  

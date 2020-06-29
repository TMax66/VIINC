library(tidyverse)
library(googlesheets)

rm(list=ls())
sheet <- gs_title("NCdbase")
df<-gs_read(sheet)

df<-df %>% 
  group_by(anno,strutture,p.norma,tiporilievo) %>% 
  summarise('n.rilievi'=n()) %>% 
  filter(!is.na(p.norma)) %>% 
  as.data.frame()%>%
  filter(anno==2015,strutture=="BG", tiporilievo=="NC") %>% 
  arrange(n.rilievi) %>% 
  mutate(p.norma = factor(p.norma, unique(p.norma))) %>% 
  ggplot(aes(x=p.norma,y=n.rilievi,label=n.rilievi))+
  geom_point(stat='identity',col="lightblue", size=8)+
  geom_text(color="black", size=3)+
  geom_segment(aes(x=p.norma, 
                   xend=p.norma, 
                   # y=min(`%resistenti`),
                   y=0,
                   yend= n.rilievi -0.1
                   # linetype="dashed", 
                   #
  ))+
  labs(title="n rilievi",caption=Sys.Date()) +  
  coord_flip()

################################################################
df<-gs_read(sheet)
df %>% 
  group_by(anno,p.norma,tiporilievo) %>% 
  summarise('n.rilievi'=n()) %>% 
  filter(!is.na(p.norma)) %>% 
  as.data.frame()%>%
  #filter(anno==2015,strutture=="BG", tiporilievo=="NC") %>% 
  arrange(n.rilievi) %>% 
  mutate(p.norma = factor(p.norma, unique(p.norma))) %>% 
  ggplot(aes(x=p.norma,y=n.rilievi,label=n.rilievi))+
  geom_point(stat='identity',col="lightblue", size=3.5)+
  geom_text(color="black", size=2)+ 
  geom_segment(aes(x=p.norma, 
                   xend=p.norma, 
                   # y=min(`%resistenti`),
                   y=0,
                   yend= n.rilievi -0.1
                   # linetype="dashed", 
                   #
  ))+
  labs(title="n rilievi",caption=Sys.Date()) +  
  coord_flip()+
  facet_wrap(~ anno)
  

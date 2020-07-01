 df %>% 
    group_by(anno,strutture,p.norma,tiporilievo) %>% 
    summarise('n.rilievi'=n()) %>% 
    filter(!is.na(p.norma))
    
 df %>% 
   group_by(anno) %>% 
   filter(strutture==input$struttura)
   summarise('n.rilievi'=n()) %>% 
   ggplot(aes(x=anno, y=n.rilievi))+geom_line()+ geom_point()+
     theme_clean()
 
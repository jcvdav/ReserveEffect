abundance <- function(x, com, spp = NULL){
  
  if(!is.null(spp)){
    x %<>% filter(generoespecie == spp)
  }
  
  results <- x %>% 
    filter(comunidad == com) %>%
    mutate(ano = as.factor(ano),
           year = as.factor(year)) %>% 
    group_by(rc, ano, year, sitio, zona, transecto, generoespecie) %>% 
    summarize(indicador = sum(abundancia)) %>% 
    ungroup()
    
    return(results)
}

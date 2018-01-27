abundance <- function(x, com, spp = NULL){
  
  if(!is.null(spp)){
    x %<>% filter(GeneroEspecie == spp)
  }
  
  results <- x %>% 
    filter(Comunidad == com) %>%
    mutate(Ano = as.factor(Ano)) %>% 
    group_by(Comunidad, RC, Ano, Sitio, Zona, Transecto, GeneroEspecie) %>% 
    summarize(Indicador = sum(Abundancia))
    
    return(results)
}

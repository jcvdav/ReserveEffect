richness <- function(x, com){
  results <- x %>% 
    filter(Comunidad == com) %>%
    filter(Abundancia > 0) %>%
    mutate(Ano = as.factor(Ano)) %>% 
    group_by(RC, Ano, Sitio, Zona, Transecto) %>% 
    summarize(Indicador = n())
  
  return(results)
}
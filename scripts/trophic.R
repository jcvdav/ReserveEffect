trophic <- function(x, com){
  resutls <- x %>% 
    filter(Comunidad == com) %>% 
    filter(Abundancia > 0) %>% 
    left_join(species_bio, by = c("GeneroEspecie")) %>% 
    reshape::untable(df = ., num = .$Abundancia) %>% 
    mutate(Ano = as.factor(Ano)) %>% 
    group_by(RC, Ano, Sitio, Zona, Transecto) %>% 
    summarize(Indicador = mean(NT, na.rm = T))
  
  return(resutls)
}
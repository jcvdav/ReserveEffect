biomass <- function(x, com){
  results <- x %>% 
    filter(Comunidad == com) %>% 
    filter(Abundancia > 0) %>% 
    left_join(species_bio, by = c("GeneroEspecie")) %>% 
    mutate(Ano = as.factor(Ano),
           biomass = Abundancia * a * (Talla^b)/1000) %>% 
    group_by(RC, Ano, Sitio, Zona, Transecto, GeneroEspecie) %>% 
    summarize(Indicador = sum(biomass, na.rm = T))
  
  return(results)
}
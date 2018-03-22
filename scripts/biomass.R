biomass <- function(x, com){
  results <- x %>% 
    filter(comunidad == com) %>% 
    mutate(ano = as.factor(ano),
           year = as.factor(year),
           biomass = abundancia * a * (talla^b)/1000) %>% 
    group_by(rc, ano, year, sitio, zona, transecto, generoespecie) %>% 
    summarize(indicador = sum(biomass, na.rm = T)) %>% 
    ungroup()
  
  return(results)
}
abundance <- function(x, com, spp = NULL){
  
  if(!is.null(spp)){
    x <- x %>% 
      filter(generoespecie == spp)
  }
  
  results <- x %>% 
    filter(comunidad == com) %>%
    mutate(ano = as.factor(ano),
           year = as.factor(year),
           year = fct_relevel(year, "0")) %>% 
    group_by(rc, ano, year, sitio, zona, transecto) %>% 
    summarize(indicador = sum(abundancia)/60) %>% 
    ungroup()
    
    return(results)
}

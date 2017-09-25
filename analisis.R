analisis <- function(peces, invert, comunidad, ano.imp){
  
  # "Índice de diversidad de shannon", "Riqueza", "Organismos > LT50", "Densidad", "Densidad de especies objetivo", "Nivel trófico", "Biomasa", "Biomasa de especies objetivo"
  
  results <- tibble(Indicador = c("ShannonP", "RiquezaP", "DensidadP", "TroficoP", "BiomasaP", "ShannonI", "RiquezaI", "DensidadI"),
                    Modelo = list(NA))
  
  results$Modelo[[1]] <- shannon(data = peces, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[2]] <- richness(data = peces, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[3]] <- density(data = peces, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[4]] <- trophic(data = peces, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[5]] <- fish_biomass(data = peces, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[6]] <- shannon(data = peces, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[7]] <- richness(data = peces, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[8]] <- density(data = peces, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  return(results)
}
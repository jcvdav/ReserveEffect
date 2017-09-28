analisis <- function(peces, invert, comunidad, ano.imp, obj.spp = NULL){
  
  results <- tibble(Indicador = c("ShannonP", "RiquezaP", "DensidadP", "TroficoP", "BiomasaP", "ShannonI", "RiquezaI", "DensidadI", "DensidadObj1", "DensidadObj2", "DensidadObj3", "DensidadObj4", "DensidadObj5", "DensidadObj6", "DensidadObj7"),
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
  
  results$Modelo[[6]] <- shannon(data = invert, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[7]] <- richness(data = invert, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  results$Modelo[[8]] <- density(data = invert, location = comunidad) %>% 
    mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
           Ano = as.factor(Ano)) %>% 
    modelo()
  
  ## Especies objetivo
  
  ### Densidades
  
  if(length(obj.spp) >= 1){
    n <-  1
    if(obj.spp[n] %in% unique(peces$GeneroEspecie)){data <- peces}
    if(obj.spp[n] %in% unique(invert$GeneroEspecie)){data <- invert}
    
    results$Modelo[[n+8]] <- density(data = data, location = comunidad, species = obj.spp[n]) %>% 
      mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
             Ano = as.factor(Ano)) %>% 
      modelo()
  }
  
  if(length(obj.spp) >= 2){
    n <-  2
    if(obj.spp[n] %in% unique(peces$GeneroEspecie)){data <- peces}
    if(obj.spp[n] %in% unique(invert$GeneroEspecie)){data <- invert}
    
    results$Modelo[[n+8]] <- density(data = data, location = comunidad, species = obj.spp[n]) %>% 
      mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
             Ano = as.factor(Ano)) %>% 
      modelo()
  }
  
  if(length(obj.spp) >= 3){
    n <-  3
    if(obj.spp[n] %in% unique(peces$GeneroEspecie)){data <- peces}
    if(obj.spp[n] %in% unique(invert$GeneroEspecie)){data <- invert}
    
    results$Modelo[[n+8]] <- density(data = data, location = comunidad, species = obj.spp[n]) %>% 
      mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
             Ano = as.factor(Ano)) %>% 
      modelo()
  }
  
  if(length(obj.spp) >= 4){
    n <-  4
    if(obj.spp[n] %in% unique(peces$GeneroEspecie)){data <- peces}
    if(obj.spp[n] %in% unique(invert$GeneroEspecie)){data <- invert}
    
    results$Modelo[[n+8]] <- density(data = data, location = comunidad, species = obj.spp[n]) %>% 
      mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
             Ano = as.factor(Ano)) %>% 
      modelo()
  }
  
  if(length(obj.spp) >= 5){
    n <-  5
    if(obj.spp[n] %in% unique(peces$GeneroEspecie)){data <- peces}
    if(obj.spp[n] %in% unique(invert$GeneroEspecie)){data <- invert}
    
    results$Modelo[[n+8]] <- density(data = data, location = comunidad, species = obj.spp[n]) %>% 
      mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
             Ano = as.factor(Ano)) %>% 
      modelo()
  }
  
  if(length(obj.spp) >= 6){
    n <-  6
    if(obj.spp[n] %in% unique(peces$GeneroEspecie)){data <- peces}
    if(obj.spp[n] %in% unique(invert$GeneroEspecie)){data <- invert}
    
    results$Modelo[[n+8]] <- density(data = data, location = comunidad, species = obj.spp[n]) %>% 
      mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
             Ano = as.factor(Ano)) %>% 
      modelo()
  }
  
  if(length(obj.spp) >= 7){
    n <-  7
    if(obj.spp[n] %in% unique(peces$GeneroEspecie)){data <- peces}
    if(obj.spp[n] %in% unique(invert$GeneroEspecie)){data <- invert}
    
    results$Modelo[[n+8]] <- density(data = data, location = comunidad, species = obj.spp[n]) %>% 
      mutate(Post = ifelse(Ano <= ano.imp, 0, 1),
             Ano = as.factor(Ano)) %>% 
      modelo()
  }
  
  return(results)
}
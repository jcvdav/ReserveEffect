model <- function(x, family = "gaussian", sfe = T, spfe = T){
  
  # x %<>% filter(Comunidad == com)
  
  if(sfe){
    if(spfe){model <- glm(Indicador ~ Ano * Zona + Sitio + GeneroEspecie, data = x, family = family)} #Site FE and Spp FE
    if(!spfe){model <- glm(Indicador ~ Ano * Zona + Sitio, data = x, family = family)} #Site FE, no Spp FE
  }
  
  if(!sfe){
    if(spfe){model <- glm(Indicador ~ Ano * Zona + GeneroEspecie, data = x, family = family)} #No site FE and Spp FE
    if(!spfe){model <- glm(Indicador ~ Ano * Zona, data = x, family = family)} #No site and no Spp FE
  }
  
  return(model)
}

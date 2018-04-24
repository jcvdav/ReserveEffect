model <- function(x, sfe = T, spfe = T){
  
  # x %<>% filter(Comunidad == com)
  
  if(sfe){
    if(spfe){model <- lm(indicador ~ zona * year + sitio + generoespecie, data = x)} #Site FE and Spp FE
    if(!spfe){model <- glm(indicador ~ zona * year + sitio, data = x)} #Site FE, no Spp FE
  }
  
  if(!sfe){
    if(spfe){model <- lm(indicador ~ zona * year + generoespecie, data = x)} #No site FE and Spp FE
    if(!spfe){model <- lm(indicador ~ zona * year, data = x)} #No site and no Spp FE
  }
  
  return(model)
}

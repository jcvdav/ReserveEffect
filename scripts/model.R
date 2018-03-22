model <- function(x, family = "gaussian", sfe = T, spfe = T){
  
  # x %<>% filter(Comunidad == com)
  
  if(sfe){
    if(spfe){model <- glm(indicador ~ year * zona + sitio + generoespecie -1, data = x, family = family)} #Site FE and Spp FE
    if(!spfe){model <- glm(indicador ~ year * zona + sitio -1, data = x, family = family)} #Site FE, no Spp FE
  }
  
  if(!sfe){
    if(spfe){model <- glm(indicador ~ year * zona + generoespecie -1, data = x, family = family)} #No site FE and Spp FE
    if(!spfe){model <- glm(indicador ~ year * zona -1, data = x, family = family)} #No site and no Spp FE
  }
  
  return(model)
}

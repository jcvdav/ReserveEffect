model <- function(x, com, family = "gaussian", sfe = T){
  data <- x %>%  
    dplyr::filter(Comunidad == com)
  
  if(sfe){
    glm(Abundancia ~ Ano * Zona + Sitio -1, data = data, family = family)
  }
  
  if(!sfe){
    glm(Abundancia ~ Ano * Zona -1, data = data, family = family)
  }
}

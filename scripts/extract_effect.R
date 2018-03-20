extract_effect <- function(x){
  
  extraction <- filter(x, !is.na(Modelo)) %$%
    Modelo %>% 
    map_df(robust_se) %>% 
    filter(term == "ZonaReserva:Post")
  
  Indicador = c("ShannonP", "RiquezaP", "DensidadP", "TroficoP", "BiomasaP", "ShannonI", "RiquezaI", "DensidadI", "DensidadObj1", "DensidadObj2", "DensidadObj3", "DensidadObj4", "DensidadObj5", "DensidadObj6", "DensidadObj7")
  
  extraction$Indicador <- Indicador[1:dim(extraction)[1]]
  
  return(extraction)
    
}
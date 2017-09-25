extract_effect <- function(x){
  
  x$Modelo %>%
    map_df(robust_se) %>% 
    filter(term == "ZonaReserva:Post") %>% 
    mutate(Indicador = c("ShannonP", "RiquezaP", "DensidadP", "TroficoP", "BiomasaP", "ShannonI", "RiquezaI", "DensidadI"))
}
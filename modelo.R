modelo <- function(data){
  lm(Indicador ~ Ano + Zona + Post*Zona, data)
}

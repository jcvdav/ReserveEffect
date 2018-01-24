abundance_model <- function(x){
  x %>% 
    mutate(Ano = as.factor(Ano)) %>% 
    group_by(RC, Ano, Sitio, Zona, Transecto) %>% 
    summarize(Abundancia = sum(Abundancia)) %>% 
    ungroup() %>% 
    glm(Abundancia ~ Ano * Zona, data = ., family = "quasipoisson")
}

my_ggplot <- function(x, y.label){
  
  x$model %>% 
    mutate(Ano = as.numeric(as.character(Ano))) %>% 
    ggplot(aes(x = Ano, y = Indicador, color = Zona, fill = Zona)) +
    geom_jitter(height = 0, width = 0.1) +
    stat_summary(geom = "ribbon", fun.data = "mean_se", alpha = 0.5)+
    stat_summary(geom = "point", fun.data = "mean_se", color = "black")+
    stat_summary(geom = "line", fun.data = "mean_se", color = "black") +
    theme_bw() +
    theme(legend.position = "None") +
    scale_color_brewer(palette = "Set1") +
    scale_fill_brewer(palette = "Set1") +
    labs(x = "Año", y = y.label)
  
}
plot_model <- function(model, model_names = NULL, legend = F){
  
  extract_and_filter <- function(model, name){
    model %>% 
      robust_se() %>% 
      filter(grepl(pattern = "zonaReserva:year", x = term)) %>% 
      mutate(Ano = as.numeric(gsub(pattern = "zonaReserva:year",
                                   replacement = "",
                                   x = term)),
             Community = name)
  }
  
  if(is.null(model_names)){model_names <- letters[1:length(model)]}
  
  pd <- position_dodge(width = 0.4)
  
  p <- purrr::map2_df(model, model_names, extract_and_filter) %>% 
    ggplot(aes(x = Ano, y = estimate, color = Community)) +
    geom_errorbar(aes(ymin = estimate - std.error, ymax = estimate + std.error), width = 0, size = 1, position = pd) +
    geom_point(aes(shape = Community), size = 4, position = pd, alpha = 0.5) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    scale_fill_brewer(palette = "Set1") +
    theme(text = element_text(size = 12)) +
    labs(x = "Years since implementation", y = quo(lambda[t])) +
    scale_color_brewer(guide = guide_legend(title.position = "top", nrow = 2), palette = "Set1") +
    scale_x_continuous(breaks = seq(-1, 10, by = 1))
  
  if(!legend){
    p <- p +
      theme(legend.position = "None")
  }
  
  return(p)
}




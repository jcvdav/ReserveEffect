plot_socioeco <- function(model_list, model_names, ylab){
  
  extract_filter <- function(model, name){
    model %>% 
      robust_se() %>% 
      filter(grepl(pattern = "zonaReserva:year", x = term)) %>% 
      mutate(years_centered = as.numeric(gsub(pattern = "zonaReserva:year",
                                              replacement = "",
                                              x = term)),
             Community = name)
  }
  
  purrr::map2_df(model_list, model_names, extract_filter) %>% 
    ggplot(aes(x = years_centered, y = estimate, group = Community)) +
    geom_hline(yintercept = 0,
               linetype = "dashed",
               size = 1) +
    geom_vline(xintercept = 0,
               linetype = "dashed",
               size = 1) +
    geom_errorbar(aes(color = Community,
                      ymin = estimate-std.error,
                      ymax = estimate + std.error),
                  width = 0.1,
                  size = 1,
                  position = position_dodge(width = 0.4)) +
    geom_point(aes(color = Community, shape = Community),
               size = 4,
               position = position_dodge(width = 0.4),
               alpha = 0.5) +
    scale_color_brewer(palette = "Set1") +
    labs(x = "Years since implementation", y = ylab) +
    theme(text = element_text(size = 12))
}
plot_model <- function(model, various = F, model_names = NULL){
  
  if(various){
    
    if(is.null(model_names)){model_names <- letters[1:length(model)]}
    
    p_all <- data.frame(term = NULL,
                        estimate = NULL,
                        std.error = NULL,
                        statistic = NULL,
                        p.value = NULL,
                        model = NULL,
                        stringsAsFactors = F)
    
    for(i in 1:length(model)){
      tidy_terms <- model[[i]] %>% 
        robust_se() %>%
        filter(grepl(":ZonaReserva", term)) %$%
        str_split(term, pattern = ":", simplify = T) %>% 
        as.tibble() %>% 
        set_colnames(c("Ano", "Zona")) %>% 
        select(-Zona) %>% 
        mutate(Ano = as.numeric(gsub(Ano, pattern = "Ano", replacement = "")),
               model = model_names[i])
      
      p_i <- robust_se(model[[i]]) %>%
        filter(grepl(":ZonaReserva", term)) %>% 
        cbind(tidy_terms) %>%
        mutate(p = ifelse(p.value < 0.05, "p < 0.05", "p > 0.05"))
      
      p_all <- rbind(p_all,  p_i)
    }
    
    p <- p_all %>% 
      ggplot(aes(x = Ano, y = estimate)) +
      geom_errorbar(aes(ymin = estimate - std.error, ymax = estimate + std.error), width = 0, color = "red", size = 1) +
      geom_point(aes(shape = model), size = 4) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      scale_fill_brewer(palette = "Set1") +
      theme(legend.justification = c(0, 1),
            legend.position = c(0, 1)) +
      labs(x = "Year", y = "Effect size") +
      geom_line(aes(group = model))
    
  }
  
  if(!various){
    tidy_terms <- model %>% 
      robust_se() %>%
      filter(grepl(":ZonaReserva", term)) %$%
      str_split(term, pattern = ":", simplify = T) %>% 
      as.tibble() %>% 
      set_colnames(c("Ano", "Zona")) %>% 
      select(-Zona) %>% 
      mutate(Ano = as.numeric(gsub(Ano, pattern = "Ano", replacement = "")))
    
    p <- robust_se(model) %>%
      filter(grepl(":ZonaReserva", term)) %>% 
      cbind(tidy_terms) %>%
      mutate(p = ifelse(p.value < 0.05, "p < 0.05", "p > 0.05")) %>% 
      ggplot(aes(x = Ano, y = estimate)) +
      geom_errorbar(aes(ymin = estimate - std.error, ymax = estimate + std.error), width = 0, color = "red", size = 1) +
      geom_point(aes(fill = p), size = 4, shape = 21, color = "black") +
      geom_hline(yintercept = 0, linetype = "dashed") +
      scale_fill_brewer(palette = "Set1") +
      theme(legend.justification = c(1, 1), 
            legend.position = c(1, 1)) +
      labs(x = "Year", y = "Effect size")
  }
  
  return(p)
}




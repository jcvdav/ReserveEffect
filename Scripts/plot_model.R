plot_model <- function(model, various = F, model_names = NULL, legend = F){
  
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
        filter(grepl(":zonaReserva", term)) %$%
        str_split(term, pattern = ":", simplify = T) %>% 
        as.tibble() %>% 
        set_colnames(c("ano", "zona")) %>% 
        select(-zona) %>% 
        mutate(Ano = as.numeric(gsub(ano, pattern = "year", replacement = "")),
               Community = model_names[i])
      
      p_i <- robust_se(model[[i]]) %>%
        filter(grepl(":zonaReserva", term)) %>%
        cbind(tidy_terms) %>%
        mutate(p = ifelse(p.value < 0.05, "p < 0.05", "p > 0.05"))
      
      p_all <- rbind(p_all,  p_i)
    }
    
    pd <- position_dodge(width = 0.4)
    
    p <- p_all %>% 
      ggplot(aes(x = Ano, y = estimate, color = Community)) +
      geom_errorbar(aes(ymin = estimate - std.error, ymax = estimate + std.error), width = 0, size = 1, position = pd) +
      geom_point(aes(shape = Community), size = 4, position = pd, alpha = 0.5) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      scale_fill_brewer(palette = "Set1") +
      theme(text = element_text(size = 12)) +
      labs(x = "Years since implementation", y = quo(lambda[t])) +
      scale_color_brewer(palette = "Set1") +
      scale_x_continuous(breaks = seq(0, 10, by = 1))
    
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
  
  if(!legend){
    p <- p +
      theme(legend.position = "None")
  }
  
  return(p)
}




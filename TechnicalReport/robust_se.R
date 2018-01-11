robust_se <- function(model){
  
  RSE <- model %>%
    lmtest::coeftest(vcov = sandwich::vcovHC(., type = "HC1")) %>%
    broom::tidy()
  
  return(RSE)
}
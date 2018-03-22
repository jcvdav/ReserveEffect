robust_se <- function(model){
  
  RSE <- model %>%
    lmtest::coeftest(vcov = sandwich::vcovHC(., type = "HC2")) %>%
    broom::tidy()
  
  return(RSE)
}

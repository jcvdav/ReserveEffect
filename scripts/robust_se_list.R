robust_se_list <- function(model){
  robust_data_frame <- robust_se(model)
  
  robust_se_errors <- robust_data_frame$std.error
  names(robust_se_errors) <- robust_data_frame$term
  
  return(robust_se_errors)
}
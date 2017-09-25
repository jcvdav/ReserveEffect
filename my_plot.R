my_plot <- function(x) {
  
  p1 <- my_ggplot(x$Modelo[[1]], y.label = "Shannon")
  p2 <- my_ggplot(x$Modelo[[2]], y.label = "Riqueza")
  p3 <- my_ggplot(x$Modelo[[3]], y.label = "Densidad")
  p4 <- my_ggplot(x$Modelo[[4]], y.label = "Nivel trófico")
  p5 <- my_ggplot(x$Modelo[[5]], y.label = "Biomasa")
  p6 <- my_ggplot(x$Modelo[[6]], y.label = "Shannon")
  p7 <- my_ggplot(x$Modelo[[7]], y.label = "Riqueza")
  p8 <- my_ggplot(x$Modelo[[8]], y.label = "Densidad")
  
  gridExtra::grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8)
  
}
shannon <- function(x, com){
  N <- x %>%
    filter(Comunidad == com) %>%
    filter(Abundancia > 0) %>%
    mutate(Ano = as.factor(Ano)) %>%
    group_by(Ano,
             Zona,
             Sitio,
             Transecto) %>%
    summarize(N = sum(Abundancia)) %>%
    ungroup() %>%
    mutate(ID = paste(Ano, Zona, Sitio, Transecto)) %>%
    select(ID, N)

  H <- x %>%
    filter(Comunidad == com) %>%
    filter(Abundancia > 0) %>%
    mutate(Ano = as.factor(Ano)) %>%
    group_by(Ano,
             Zona,
             Sitio,
             Transecto,
             GeneroEspecie) %>%
    summarize(ni = sum(Abundancia)) %>%
    ungroup() %>%
    mutate(ID = paste(Ano, Zona, Sitio, Transecto)) %>%
    left_join(N, by = "ID") %>%
    mutate(pi = ni/N) %>%
    group_by(Ano,
             Zona,
             Sitio,
             Transecto) %>%
    summarize(H = -1*sum(pi*log2(pi))) %>%
    ungroup() %>%
    select(Ano, Zona, Sitio, Transecto, Indicador = H)

  return(as.data.frame(H))
}

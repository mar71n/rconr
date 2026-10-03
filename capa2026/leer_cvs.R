library(dplyr)
library(readxl)
# install.packages("readxl")  # also installing the dependencies ‘rematch’, ‘cellranger’
# Tablas con la Función Generalizada de Variancia
FGV_Poblacion_Comunas <- read_excel(
  "datos/eah2025_bu_ampliada/eah2025_bu_ampliada_calculo_cv.xls", 
  sheet = "FGV_Poblacion_Comunas", range = "B5:Q55")

# El reciclado (o recycling rule) en R es el mecanismo por el cual el lenguaje 
# repite automáticamente los elementos de un vector más corto para igualar 
# la longitud de un vector más largo al realizar operaciones por elementos.
nombrecolumnas <- c("Total", paste("Comuna", 1:15, sep = ""))
names(FGV_Poblacion_Comunas) <- nombrecolumnas


n <- 95800
actual <- options("scipen")
options(scipen=10)
fila <- max(FGV_Poblacion_Comunas[FGV_Poblacion_Comunas$Total<n, "Total"])
options(scipen=actual[[1]])


comuna <- "Comuna15"
FGV_Poblacion_Comunas %>% filter(Total == fila) %>% select(as.character(comuna))

FGV_Poblacion_Comunas[FGV_Poblacion_Comunas$Total == fila, as.character(comuna)][[1]]

traercv <- function(n, comuna){
  #n = 5000
  #comuna = 6
  # El máximo de los totales menores o iguales al pedido
  fila <- bind_rows(
                FGV_Poblacion_Comunas %>% select(Total) %>% filter(Total <= n),
                FGV_Poblacion_Comunas %>% select(Total) %>% arrange(Total)
          ) %>% slice_head() %>% pull()
  retcv <- FGV_Poblacion_Comunas[FGV_Poblacion_Comunas$Total == fila, comuna]
  retcv <- case_when(retcv >= 0.2 ~ 'b',
                     retcv >= 0.1 ~ 'a',
                     .default = '')
  return(retcv)
}

traercv(20000, "Comuna1")

traercv(2500, "Comuna8")

traercv(5000, 5)

traercv(6000, 5)


traercv(13500, 2)


abc <- 7

abc


traercv(117000, 5)
traercv(2500, 5)
traercv(2400, 5)



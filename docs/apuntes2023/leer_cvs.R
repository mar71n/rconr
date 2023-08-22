library(readxl)
# install.packages("readxl")  # also installing the dependencies ‘rematch’, ‘cellranger’
# MODIFICO EL EXCEL: los datos que dice "." (punto) los reemplazo por 0 (cero)
FGV_Poblacion_Comunas <- read_excel("datos/eah2021_bu_ampliada/eah2021_bu_ampliada_calculo_cv.xls", sheet = "FGV_Poblacion_Comunas", range = "B5:Q55")


nombrecolumnas <- c("Total", 1:15)
names(FGV_Poblacion_Comunas) <- nombrecolumnas


n <- 95800
actual <- options("scipen")
options(scipen=10)
fila <- max(FGV_Poblacion_Comunas[FGV_Poblacion_Comunas$Total<n, "Total"])
options(scipen=actual[[1]])


comuna <- 15
FGV_Poblacion_Comunas %>% filter(Total == fila) %>% select(as.character(comuna))

FGV_Poblacion_Comunas[FGV_Poblacion_Comunas$Total == fila, as.character(comuna)][[1]]

traercv <- function(total, comuna){
  #total = 120001
  #comuna = 5
  # El máximo de los totales menores o iguales al pedido
  #fila <- max(FGV_Poblacion_Comunas[FGV_Poblacion_Comunas$Total <= total, "Total"])
  fila <- FGV_Poblacion_Comunas %>% filter(Total <= total) %>% select(Total) %>% max()
  retcv <- FGV_Poblacion_Comunas[FGV_Poblacion_Comunas$Total == fila, as.character(comuna)][[1]]
  retcv <- case_when(retcv >= 0.1 ~ 'a',
                     retcv >= 0.2 ~ 'b',
                     .default = '')
  return(retcv)
}


traercv(117000, 5)
traercv(2500, 5)
traercv(2400, 5)



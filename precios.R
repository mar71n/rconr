library(readxl)
#install.packages("readxl")
library(dplyr)
library(lubridate)

# jul 2012 - feb 2022
download.file("https://www.estadisticaciudad.gob.ar/eyc/wp-content/uploads/2022/02/Incidencia_div_niv_gral.xlsx", "datos/Incidencia_div_niv_gral.xlsx")

ipcba_a <- read_excel("datos/Incidencia_div_niv_gral.xlsx", sheet = "Incidencia_div_niv_gral", col_names=FALSE, skip=2, n_max=2)

dim(ipcba_a)

typeof(ipcba_a)

names(ipcba_a)

names(ipcba_a)

ipcba_a[[3]]
ipcba_a[[3]][[1]]
ipcba_a[[3]][[2]]



ipcba_a[,1:5]

ipcba_a[1,1:5]

ipcba_a[2,1:5]

ipcba_b <- t(ipcba_a)

str(ipcba_b)

dim(ipcba_b)

head(ipcba_b)

dimnames(ipcba_b)

ipcba_b[3:118,1]
ipcba_b[3:118,2]

ipcba_df <- data.frame(fecha = as.Date(as.numeric(ipcba_b[3:118,1]), origin="1899-12-30") , mensual = as.numeric(ipcba_b[3:118,2]))

str(ipcba_df)


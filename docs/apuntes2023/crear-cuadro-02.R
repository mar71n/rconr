library(dplyr)
library(readr)
library(tidyr)

# #############################################################
# Cargar individuales y controlar totales
eah2021_ind <- read_csv2("datos/eah2021_bu_ampliada/eah2021_bu_ampliada_ind.txt")

# Cuadro 2 : P01B.xlsx
titulo <- "Distribución porcentual de la población por grupos de edad según comuna. Ciudad de Buenos Aires. Año 2021"

# Hasta 9	10 - 19		20 - 29	30 - 39	40 - 49	50 - 59	60 - 69		70 y más
niveles <- c('Hasta 9','10 - 19','20 - 29','30 - 39','40 - 49','50 - 59','60 - 69','70 y mas')

# calculo la variable "rango" con dplyr::case_when
# lo convierto en factor (ordeno por edad para que aparescan en orden los niveles)
porgruposedad <- eah2021_ind %>% arrange(edad) %>%
  mutate(rango = case_when(  edad <= 9 ~ 'Hasta 9',
                             edad <= 19 ~ '10 - 19',
                             edad <= 29 ~ '20 - 29',
                             edad <= 39 ~ '30 - 39',
                             edad <= 49 ~ '40 - 49',
                             edad <= 59 ~ '50 - 59',
                             edad <= 69 ~ '60 - 69',
                             edad >= 70 ~ '70 y mas',)) %>%
  mutate(rango = as_factor(rango)) %>%
  group_by(comuna) %>%
  count(rango, wt = fexp) %>% 
  mutate(tot = sum(n), porc = n / sum(n)) %>% arrange(comuna, rango)

porgruposedad_porc <- porgruposedad %>%  pivot_wider(id_cols = comuna, names_from = rango, values_from = porc)

porgruposedad %>%  pivot_wider(id_cols = comuna, names_from = rango, values_from = c(porc, n))

porgruposedad_tot <- porgruposedad %>%  pivot_wider(id_cols = comuna, names_from = rango, values_from = c(n))

for (tn in porgruposedad_tot[14,2:9]){
  print(tn)
  print(traercv(tn, 14))
}

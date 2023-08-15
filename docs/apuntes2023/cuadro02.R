library(dplyr)
library(readr)
library(readxl)
library(tidyr)

# #############################################################
# Cargar individuales y controlar totales
eah2021_ind <- read_csv2("datos/eah2021_bu_ampliada/eah2021_bu_ampliada_ind.txt")
totales <- read_csv2("datos/totales-control.csv")

# Cuadro 2 : P01B.xlsx
titulo <- "Distribución porcentual de la población por grupos de edad según comuna. Ciudad de Buenos Aires. Año 2021"

# case_when() o cut()

# Hasta 9	10 - 19		20 - 29	30 - 39	40 - 49	50 - 59	60 - 69		70 y más
niveles <- c('Hasta 9','10 - 19','20 - 29','30 - 39','40 - 49','50 - 59','60 - 69','70 y mas')

# calculo la variable "rango" con base::cut
eah2021_ind %>% mutate(rango = cut(edad, breaks = c(-Inf, 9,19,29,39,49,59,69, Inf), labels = niveles)) %>%
  count(rango, wt = fexp) %>% 
  mutate(tot = sum(n), porc = n / sum(n)) %>% arrange(rango) # %>% str()


# calculo la variable "rango" con dplyr::case_when
eah2021_ind %>% mutate(rango = case_when( edad <= 9 ~ 'Hasta 9',
                                          edad <= 19 ~ '10 - 19',
                                          edad <= 29 ~ '20 - 29',
                                          edad <= 39 ~ '30 - 39',
                                          edad <= 49 ~ '40 - 49',
                                          edad <= 59 ~ '50 - 59',
                                          edad <= 69 ~ '60 - 69',
                                          edad >= 70 ~ '70 y mas',)) %>%
  count(rango, wt = fexp) %>% 
  mutate(rango = factor(rango, levels = niveles)) %>% 
  mutate(tot = sum(n), porc = n / sum(n)) %>% arrange(rango)



porgruposedad <- eah2021_ind %>% mutate(rango = case_when( edad <= 9 ~ 'Hasta 9',
                                                           edad <= 19 ~ '10 - 19',
                                                           edad <= 29 ~ '20 - 29',
                                                           edad <= 39 ~ '30 - 39',
                                                           edad <= 49 ~ '40 - 49',
                                                           edad <= 59 ~ '50 - 59',
                                                           edad <= 69 ~ '60 - 69',
                                                           edad >= 70 ~ '70 y mas',)) %>%
  group_by(comuna) %>%
  count(rango, wt = fexp) %>% 
  mutate(tot = sum(n), porc = n / sum(n)) %>% arrange(comuna, rango)
  

eah2021_ind %>% filter(comuna == 6) %>% mutate(rango = cut(edad, breaks = c(-Inf, 9,19,29,39,49,59,69, Inf), labels = niveles)) %>%
  count(rango, wt = fexp) %>% 
  mutate(tot = sum(n), porc = n / sum(n)) %>% arrange(rango) # %>% str()

porgruposedad <- eah2021_ind %>% mutate(rango = cut(edad, breaks = c(-Inf, 9,19,29,39,49,59,69, Inf), labels = niveles)) %>%
  group_by(comuna) %>%
  count(rango, wt = fexp) %>% 
  mutate(tot = sum(n), porc = n / sum(n)) %>% arrange(comuna, rango)

porgruposedad %>%  pivot_wider(id_cols = comuna, names_from = rango, values_from = porc)

porgruposedad %>%  pivot_wider(id_cols = comuna, names_from = rango, values_from = c(porc, n))

porgruposedad %>%  pivot_wider(id_cols = comuna, names_from = rango, values_from = c(n))

# para cada comuna hay un n a partir del cual el CV es mayor que 10%(a) ó 20%(b) ó 30%(---)
# Ver eah2021_bu_ampliada_calculo_cv.xls


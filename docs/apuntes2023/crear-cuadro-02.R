library(dplyr)
library(readr)
library(tidyr)
library(forcats)


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

#porgruposedad %>%  pivot_wider(id_cols = comuna, names_from = rango, values_from = c(porc, n))

porgruposedad_tot <- porgruposedad %>%  pivot_wider(id_cols = comuna, names_from = rango, values_from = c(n))

mp01Br <- porgruposedad_tot %>% mutate(cv_hasta9 = traercv(`Hasta 9`, comuna)) %>%
  mutate(cv_hasta19 = traercv(`10 - 19`, comuna)) %>%
  mutate(cv_hasta29 = traercv(`20 - 29`, comuna)) %>%
  mutate(cv_hasta39 = traercv(`30 - 39`, comuna)) %>%
  mutate(cv_hasta49 = traercv(`40 - 49`, comuna)) %>%
  mutate(cv_hasta59 = traercv(`50 - 59`, comuna)) %>%
  mutate(cv_hasta69 = traercv(`60 - 69`, comuna)) %>%
  mutate(cv_70ymas = traercv(`70 y mas`, comuna)) %>%
  full_join(porgruposedad_porc, by = c('comuna')) %>%
  select(`Hasta 9` = `Hasta 9.y`, cv_hasta9, `10 - 19.y`, cv_hasta19, `20 - 29.y`, cv_hasta29, `30 - 39.y`, cv_hasta39,
         `40 - 49.y`, cv_hasta49, `50 - 59.y`, cv_hasta59, `60 - 69.y`, cv_hasta69, `70 y mas.y`, cv_70ymas)


# con kableExtra #############################
library(kableExtra)

cuadro02kbl <- kbl(mp01Br) %>%
  kable_paper("striped", full_width = F) %>%
  add_header_above(c(" " = 1, "Grupo de edad" = 16))
  

cuadro02kbl

save_kable(cuadro02kbl, file = "resultados/cuadro02_kbl.html")



library(dplyr)
library(readr)

# Distribución porcentual de la población, los hogares y las viviendas 
# por tipo de vivienda. Ciudad de Buenos Aires. Año 2025

# usamos read_csv2 porque el delimitador del archivo es ";"

eah2025_ind <- read_csv2("./datos/eah2025_bu_ampliada/eah2025_bu_ampliada_ind.txt")


eah2025_hog <- read_csv2("./datos/eah2025_bu_ampliada/eah2025_bu_ampliada_hog.txt")

# v2_2 tipo de vivienda
eah2025_hog %>% count(v2_2)

# Del diseño de registros par aeah2025_bu_ampliada_hog
# Universo v2_2 : Total de viviendas (nhogar = 1)
# resultan 1.372.088 hogares (número de viviendas)
####################################################
# Viviendas por tipo de vivienda
####################################################
eah2025_hog %>% filter(nhogar == 1) %>%
  mutate( v2_2 = factor(v2_2, levels = c(0, 1, 2, 9, 10, 5, 8),
                            labels = c("Sin dato",
                                       "Casa",
                                       "Departamento",
                                       "Pieza de inquilinato/ conventillo",
                                       "Pieza de hotel/ pensión",
                                       "Construcción no destinada a vivienda",
                                       "Otro"
                                       )
                            )   
) %>% count(v2_2, wt = fexp) %>% mutate(total = sum(n), porc = 100 * n / total)

# para nhogar = 1 resultan 1.372.088 (coincide con las vivendas)
eah2025_hog %>% count(nhogar, wt = fexp) %>% mutate(total = sum(n))


####################################################
# Hogares por tipo de vivienda
####################################################
eah2025_hog %>% # filter(nhogar == 1) %>%
  mutate( v2_2 = factor(v2_2, levels = c(0, 1, 2, 9, 10, 5, 8),
                        labels = c("Sin dato",
                                   "Casa",
                                   "Departamento",
                                   "Pieza de inquilinato/ conventillo",
                                   "Pieza de hotel/ pensión",
                                   "Construcción no destinada a vivienda",
                                   "Otro"
                        )
  )   
  ) %>% count(v2_2, wt = fexp) %>% mutate(total = sum(n), porc = 100 * n / total)

eah2025_hog %>% select(id, nhogar, v2_2, fexp)

eah2025_ind %>% select(id, nhogar, edad, sexo, fexp)


####################################################
# Población por tipo de vivienda
####################################################

eah2025_ind %>%
  left_join(eah2025_hog %>% select(id, nhogar, v2_2),
            by = c("id", "nhogar")) %>%
  mutate(v2_2 = factor(v2_2,
                       levels = c(0, 1, 2, 5, 8, 9, 10),
                       labels = c("Sin dato",
                                  "Casa",
                                  "Departamento",
                                  "Construcción no destinada a vivienda",
                                  "Otro",
                                  "Pieza de inquilinato/ conventillo",
                                  "Pieza de hotel/ pensión"))) %>%
  count(v2_2, wt = fexp, .drop = FALSE) %>%
  mutate(porc = n / sum(n),
         porc_fmt = scales::percent(porc, accuracy = 0.1, decimal.mark = ","))


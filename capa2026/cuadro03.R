#### 6) Cuadro 3: Distribución porcentual de la población por grupos de edad según sexo y zona.
##### Pasar sexo a factor y crear grupo de edad y zona con mutate, también como factores.
##### Agrupamiento de comunas contiguas y de características similares.
##### La zona Norte está conformada por las comunas 2, 13 y 14; 
##### la zona Centro, por las comunas 1, 3, 5, 6, 7, 11, 12 y 15; 
##### la zona Sur, por las comunas 4, 8, 9 y 10

library(dplyr)
library(readr)
#install.packages("gt")
#library(gt)
library(tidyr)

eah2025_ind <- read_csv2( "./datos/eah2025_bu_ampliada/eah2025_bu_ampliada_ind.txt")

eah2025_ind <- eah2025_ind %>% 
  mutate(sexo = factor(sexo, levels = c(1,2), labels =  c('Varon','Mujer'))) %>%
  mutate(comuna = factor(comuna))

eah2025_ind[1:7]

# Hasta 9	10 - 19		20 - 29	30 - 39	40 - 49	50 - 59	60 - 69		70 y más
niveles <- c('Hasta 9','10 - 19','20 - 29','30 - 39','40 - 49','50 - 59','60 - 69','70 y mas')

eah2025_ind <- eah2025_ind %>% 
  mutate(rango = cut(edad, breaks = c(-Inf, 9,19,29,39,49,59,69, Inf), labels = niveles))

eah2025_ind %>% select(1:7, rango)

eah2025_ind <- eah2025_ind %>% 
  mutate(zona = case_when(
    as.numeric(as.character(comuna)) %in% c(2, 13, 14)                 ~ "Norte",
    as.numeric(as.character(comuna)) %in% c(1, 3, 5, 6, 7, 11, 12, 15) ~ "Centro",
    as.numeric(as.character(comuna)) %in% c(4, 8, 9, 10)               ~ "Sur"
  )) %>% 
  mutate(zona = factor(zona, levels = c("Norte", "Centro", "Sur")))

eah2025_ind %>% select(1:7, rango, zona)


porc_rango_zona <- eah2025_ind %>% 
  count(zona, rango, wt = fexp) %>% # conteos ponderados por factor de expansión
  group_by(zona) %>%                # agrupamos por zona
  mutate(
    tot  = sum(n),                  # total de la zona
    porc = n / tot                  # porcentaje dentro de la zona
  ) %>% 
  ungroup() %>% 
  arrange(zona, rango)

porc_rango_zona  

porc_rango_zona %>% 
  mutate(porc = round(100 * porc, 1)) %>%
  select(zona, rango, porc) %>% 
  pivot_wider(
    names_from  = rango,
    values_from = porc
  )


library(ggplot2)
library(scales)

porc_rango_zona %>% 
  ggplot(aes(x = zona, y = porc, fill = rango)) +
  geom_col(position = "stack", width = 0.7) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    x = NULL, y = "Porcentaje",
    fill = "Grupo de edad",
    title = "Composición por grupo de edad según zona",
    subtitle = "CABA 2025"
  ) +
  theme_minimal(base_size = 13)

porc_rango_zona %>% 
  ggplot(aes(x = rango, y = porc, fill = zona)) +
  geom_col(position = "dodge", width = 0.75) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    x = "Grupo de edad", y = "Porcentaje",
    fill = "Zona",
    title = "Distribución por grupo de edad y zona"
  ) +
  theme_minimal(base_size = 13) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

porc_rango_zona %>% 
  ggplot(aes(x = porc, y = rango, fill = zona)) +
  geom_col(position = "dodge", width = 0.75) +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    x = "Porcentaje", y = NULL, fill = "Zona",
    title = "Distribución por grupo de edad y zona"
  ) +
  theme_minimal(base_size = 13)

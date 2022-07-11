library(dplyr)
library(lubridate)
library(readr)
library(ggplot2)

dmy("28FEB2021")

dmy("28/02/2021")

dmy("29/02/2021")

dmy("29/02/2020")

dmy_hms("28FEB2021:15:15:20")

as_date(dmy_hms("28FEB2021:15:15:20"))

# Dataset de vacunas:
vacunas <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv")
# vacunas <- read_csv("datos/dataset_total_vacunas.csv")

# 0 en los valor NA de DOSIS_3
vacunas[which(is.na(vacunas$DOSIS_3)), "DOSIS_3"] <- 0

# Agrego la columna de *total* para cada registro
vacunas <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3))

# FECHA_ADMINISTRACION es un texto y tiene que ser una fecha.
head(vacunas$FECHA_ADMINISTRACION)

# FECHA_ADMINISTRACION con *lubridate*
# siempre uso el tipo más simple posible, en este caso **date** por sobre **date-time** ya que la hora no la preciso
vacunas <- vacunas %>% mutate(FECHA_ADMINISTRACION = as_date(dmy_hms(FECHA_ADMINISTRACION)))

# total por día
vacunas %>% count(FECHA_ADMINISTRACION, wt = total, name = "total")

# total por día
# geom_line
vacunas %>% count(FECHA_ADMINISTRACION, wt = total, name = "total") %>%
  ggplot(aes(FECHA_ADMINISTRACION, total)) +
  geom_line()

# geom_line
# geom_smooth
vacunas %>% count(FECHA_ADMINISTRACION, wt = total, name = "total") %>%
  ggplot(aes(FECHA_ADMINISTRACION, total)) +
  geom_line() + geom_smooth(method = "gam")

vacunas %>% mutate(annio = year(FECHA_ADMINISTRACION)) %>% 
  count(FECHA_ADMINISTRACION, annio, wt = total, name = "total") %>%
  ggplot(aes(FECHA_ADMINISTRACION, total, colour = factor(annio))) +
  geom_line()


# total por semana
# count
vacunas %>% mutate(semana = floor_date(FECHA_ADMINISTRACION, "week")) %>%
  count(semana, wt = total, name = "TOTAL") %>%
  ggplot(aes(semana, TOTAL)) +
    geom_line()

vacunas %>% mutate(semana = floor_date(FECHA_ADMINISTRACION, "week"), annio = year(FECHA_ADMINISTRACION)) %>%
  count(semana, annio, wt = total, name = "TOTAL") %>%
  ggplot(aes(semana, TOTAL, colour = factor(annio))) +
  geom_line()

# total por semana
# group by
vacunas %>% mutate(semana = floor_date(FECHA_ADMINISTRACION, "week")) %>%
  group_by(semana) %>%
  summarise(TOTAL = sum(total)) %>%
  ggplot(aes(semana, TOTAL)) +
  geom_line()

# total por mes
# geom_line
vacunas %>% mutate(mes = floor_date(FECHA_ADMINISTRACION, "month")) %>%
  count(mes, wt = total, name = "TOTAL") %>%
  ggplot(aes(mes, TOTAL)) +
  geom_line()

# total por mes 
# geom_bar
vacunas %>% mutate(mes = floor_date(FECHA_ADMINISTRACION, "month")) %>%
  count(mes, wt = total, name = "TOTAL") %>%
  ggplot(aes(mes, TOTAL)) +
  geom_bar(stat = "identity")




vacunas %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GRUPO_ETARIO, GENERO) %>% 
  summarise(t = sum(total, na.rm=TRUE)) %>%
  ggplot(aes(x = GRUPO_ETARIO, y = t)) +
    geom_boxplot()

ggsave()


## para tablas: 

vacunas %>% count(GENERO, wt = total, name = "APLICADAS")

library(knitr)  
library(kableExtra)

library(magrittr)

t2 <- vacunas %>% count(GENERO, wt = total, name = "APLICADAS") %>%
  kbl(caption = "Vacunas por género", center = TRUE) %>%
  kable_styling(bootstrap_options = "striped", full_width = F) %>%
  footnote(general_title = "Notas", c("Fuente: www.databuenosaires.gob.ar"))

save_kable(t2, "tabla02.png", expand = 10)

vacunas %>% count(GENERO, wt = total, name = "APLICADAS") %>%
  kbl(caption = "Vacunas por género", center = TRUE) %>%
  kable_styling(bootstrap_options = "striped", full_width = F) %>%
  footnote(general_title = "Notas", c("Fuente: www.databuenosaires.gob.ar")) %>%
  kable_styling() %>%
  save_kable(file = "tabla02.png")


library(webshot)
library(htmltools)

library(gt)

t1 <- vacunas %>% count(GENERO, wt = total, name = "APLICADAS") %>%
  gt() %>% 
  tab_header(
    title = "Vacunas por género",
  ) %>%
  tab_source_note("Fuente : www.databuenosaires.gob.ar")

t1

gtsave(t1, "tabla01.png", expand = 10)





data1 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

vacunas %>% count(GENERO, wt = total, name = "APLICADAS")

data2 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GRUPO_ETARIO, GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

data1


# [**stringr**](https://stringr.tidyverse.org/)
library(stringr)

vacunas %>% count(VACUNA) 

vacunas %>% count(VACUNA) %>% .$VACUNA 

strvacunas <- vacunas %>% count(VACUNA) %>% .$VACUNA 

str_extract(strvacunas, "Coronavirus")

str_extract(strvacunas, "\\d\\w\\w")

str_extract_all(strvacunas, "\\d\\w\\w")

str_extract_all(strvacunas, "\\(\\w+\\)")

str_extract_all(strvacunas, "\\([:upper:]*\\)")

str_extract_all(strvacunas, "[:upper:]{4,}")

vacunas %>% count(VACUNA) %>% .$VACUNA  %>%
str_extract(pattern =  "\\([A-Z]+\\)|AstraZeneca|Sinopharm|Moderna|Sputnik") %>%
  str_replace_all("\\(|\\)", "") %>% 
  str_to_upper()

  
vacunas$VAC <-  vacunas$VACUNA %>%
  str_extract( pattern =  "\\([A-Z]+\\)|AstraZeneca|Sinopharm|Moderna|Sputnik") %>%
  str_replace_all("\\(|\\)", "") %>% str_to_upper()

vacunas %>% mutate(VAC = VACUNA %>%
                     str_extract( pattern =  "\\([A-Z]+\\)|AstraZeneca|Sinopharm|Moderna|Sputnik") %>%
                     str_replace_all("\\(|\\)", "") %>% str_to_upper())


vacunas %>% count(VAC, wt = total, name = "DOSIS")


shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
str_extract(shopping_list, "\\d")
str_extract(shopping_list, "[a-z]+")
str_extract(shopping_list, "[a-z]{1,4}")
str_extract(shopping_list, "\\b[a-z]{1,4}\\b")



vacunas <- read_csv("datos/dataset_total_vacunas.csv")

vacunas[which(is.na(vacunas$DOSIS_3)), "DOSIS_3"] <- 0

vacunas <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3))

vacunas <- vacunas %>% mutate(FECHA_ADMINISTRACION = as_date(dmy_hms(FECHA_ADMINISTRACION)))

vacunas %>% count(FECHA_ADMINISTRACION, wt = total, name = "total") %>%
  ggplot(aes(FECHA_ADMINISTRACION, total)) +
  geom_line()






vacunas %>% count(VACUNA)

vacunas %>% count(VACUNA) %>% .$VACUNA 

vacunas %>% count(VACUNA) %>% .$n

vacunas$GENERO


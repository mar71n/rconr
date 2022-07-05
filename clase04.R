library(dplyr)
library(lubridate)
library(readr)
library(ggplot2)

dmy("28FEB2021")
dmy("28/02/2021")
dmy("29/02/2021")
dmy("29/02/2020")

dmy_hms("28FEB2021:15:15:00")

as_date(dmy_hms("28FEB2021:15:15:00"))

vacunas <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv")
vacunas <- read_csv("datos/dataset_total_vacunas.csv")

vacunas[which(is.na(vacunas$DOSIS_3)), "DOSIS_3"] <- 0

vacunas <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3))

# siempre uso el tipo más simple posible, en este caso date por sobre date-time ya que la hora no la preciso
vacunas <- vacunas %>% mutate(FECHA_ADMINISTRACION = as_date(dmy_hms(FECHA_ADMINISTRACION)))

# total por día
vacunas %>% count(FECHA_ADMINISTRACION, wt = total, name = "total")

vacunas %>% count(FECHA_ADMINISTRACION, wt = total, name = "total") %>%
  ggplot(aes(FECHA_ADMINISTRACION, total)) +
  geom_line()

# total por semana
# count
vacunas %>% mutate(semana = floor_date(FECHA_ADMINISTRACION, "week")) %>%
  count(semana, wt = total, name = "TOTAL") %>%
  ggplot(aes(semana, TOTAL)) +
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



## para tablas: 
vacunas %>% count(GENERO, wt = total, name = "APLICADAS")
  





data1 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

vacunas %>% count(GENERO, wt = total, name = "APLICADAS")

data2 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GRUPO_ETARIO, GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

data1

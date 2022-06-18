library(dplyr)
library(readr)
# install.packages("readr")
library(lubridate)

# https://data.buenosaires.gob.ar/dataset/plan-de-vacunacion-covid-19
# vacunas <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv", "datos/dataset_total_vacunas.csv")
vacunas <- read_csv("datos/dataset_total_vacunas.csv")

spec(vacunas)

head(vacunas)

dmy_hms(head(vacunas$FECHA_ADMINISTRACION))

max(dmy_hms(vacunas$FECHA_ADMINISTRACION))

summary(vacunas)
# veo que en DOSIS_3 hay 83 NAs

vacunas[which(is.na(vacunas$DOSIS_3)),]

# pongo cero en esos NAs 
vacunas[which(is.na(vacunas$DOSIS_3)), "DOSIS_3"] <- 0


str(vacunas)

names(vacunas)

table(vacunas$GENERO)

vacunas %>% group_by(GENERO) %>% summarise(total = n())

table(vacunas$GRUPO_ETARIO)

table(vacunas$VACUNA)

vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  filter(GENERO == "F")

vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  filter(GRUPO_ETARIO == "51 a 60") %>%
  arrange(desc(total))

library(ggplot2)

datos <- vacunas %>% mutate(total = as.numeric(DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) 

summary(datos)

table(datos$GENERO)

vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
 group_by(GENERO) %>% dplyr::summarise(t=sum(total, na.rm = TRUE))

vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GENERO) %>% dplyr::summarise(t=sum(total))

data1 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
group_by(GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

ggplot(data1, aes(GENERO,t, fill = GENERO)) + 
  geom_bar(stat="identity", colour = "grey") +
  geom_text(aes(label= t), vjust= -0.5, color="black", size=4)

data2 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GRUPO_ETARIO, GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

ggplot(data2, aes(GENERO,t, fill=GRUPO_ETARIO)) + 
  geom_bar(stat="identity") 

ggplot(data2, aes(GRUPO_ETARIO, t, fill=GENERO)) + 
  geom_bar(stat="identity") 

# grafico de torta:
# https://es.stackoverflow.com/questions/411130/c%C3%B3mo-hacer-un-gr%C3%A1fico-y-sub-gr%C3%A1ficos-de-pie-en-r
# https://germangfeler.github.io/datascience/barras-y-tortas/
 

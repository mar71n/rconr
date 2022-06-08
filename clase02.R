library(dplyr)
library(readr)
#install.packages("readr")
library(lubridate)

# https://data.buenosaires.gob.ar/dataset/plan-de-vacunacion-covid-19
#vacunas <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv")
vacunas <- read_csv("datos/dataset_total_vacunas.csv")

head(vacunas)

dmy_hms(head(vacunas$FECHA_ADMINISTRACION))

max(dmy_hms(vacunas$FECHA_ADMINISTRACION))

summary(vacunas)

str(vacunas)

table(vacunas$GENERO)

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

datos[which(is.na(datos$total)), "total"] <- 0

vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
 group_by(GENERO) %>% dplyr::summarise(t=sum(as.numeric(total)))


ggplot(datos, aes(x=, y=total)) + 
  geom_line()


data1 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
group_by(GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

ggplot(data1, aes(GENERO,t)) + 
  geom_bar(stat="identity") 


data2 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GRUPO_ETARIO, GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

ggplot(data2, aes(GENERO,t, fill=GRUPO_ETARIO)) + 
  geom_bar(stat="identity") 

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

vacunas %>% filter(is.na(vacunas$DOSIS_3)) %>% select(-FECHA_ADMINISTRACION, -ID_CARGA) %>% mutate(DOSIS_3 = 0)

# pongo cero en esos NAs 
vacunas[which(is.na(vacunas$DOSIS_3)), "DOSIS_3"] <- 0

vacunas %>% count(GENERO)

vacunas %>% count(GENERO, wt = DOSIS_1)



str(vacunas)

names(vacunas)

table(vacunas$GENERO)

vacunas %>% group_by(GENERO) %>% summarise(total = n())

table(vacunas$GRUPO_ETARIO)

table(vacunas$VACUNA)

vacunas %>% select(GENERO, GRUPO_ETARIO)

vacunas %>% select(GENERO, GRUPO_ETARIO, DOSIS_1, DOSIS_2, DOSIS_3)

vacunas %>% select(GENERO, GRUPO_ETARIO, starts_with("DOSIS"))

vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  filter(GENERO == "F")

vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  filter(GRUPO_ETARIO == "51 a 60") %>%
  arrange(desc(total))

vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  filter(total > 1000) %>%
  arrange(GENERO, desc(GRUPO_ETARIO))

vacunas$FECHA_ADMINISTRACION <- dmy_hms(vacunas$FECHA_ADMINISTRACION)

vac_tot <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3))%>%  group_by(FECHA_ADMINISTRACION) %>% summarise(Tot = cumsum(total))

tail(vac_tot)

library(ggplot2)

datos <- vacunas %>% mutate(total = as.numeric(DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) 

summary(datos)

table(datos$GENERO)

#vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
# group_by(GENERO) %>% dplyr::summarise(t=sum(total, na.rm = TRUE))

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
  geom_bar(stat="identity", colour = "grey") 

ggplot(data2, aes(GRUPO_ETARIO, t, fill=GENERO)) + 
  geom_bar(stat="identity") 

# grafico de torta:
# https://es.stackoverflow.com/questions/411130/c%C3%B3mo-hacer-un-gr%C3%A1fico-y-sub-gr%C3%A1ficos-de-pie-en-r
# https://germangfeler.github.io/datascience/barras-y-tortas/
 
data2 %>% tally()

data3 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GENERO, GRUPO_ETARIO) %>% summarise(t = sum(total, na.rm=TRUE))

data1 %>% tally()
data2 %>% tally()
data3 %>% tally()

ggplot(data3, aes(GRUPO_ETARIO, t, fill=GENERO)) + 
  geom_bar(stat="identity") 

ggplot(data3, aes(GENERO, t, fill=GRUPO_ETARIO)) + 
  geom_bar(stat="identity") 



#### Aproximandonos a ggplot
##### ggplot, aes, stat, position, facet
# geom_bar por defecto solo requiere aes(x) y hace un count
dfa <- data.frame(a = c(1,2,3,1), b=c(2,5,2,1))
ggplot(dfa, aes(a)) + 
  geom_bar() 

ggplot(dfa, aes(a)) + 
  geom_bar(stat="count") 

# geom_bar con stat = identity agrupa por x ademas suma todos los casos
# requiere aes(x, y)
dfa <- data.frame(a = c(1,2,3), b=c(3,5,2))
ggplot(dfa, aes(a, b)) + 
   geom_bar(stat="identity") 

dfa <- data.frame(a = c(1,2,3,1), b=c(2,5,2,1))
ggplot(dfa, aes(a, b)) + 
  geom_bar(stat="identity") 

# por defecto position es "stack"
ggplot(data2, aes(GRUPO_ETARIO, t, fill=GENERO)) + 
  geom_bar(stat="identity", position = "stack") 

ggplot(data2, aes(GRUPO_ETARIO, t, fill=GENERO)) + 
  geom_bar(stat="identity", position = "dodge", colour = "grey") 
# el el grafico de arriba, algunos tienen tres columnas otros dos (no hay casos GENERO = N)

# preserve (anchos de columna)
ggplot(data2, aes(GRUPO_ETARIO, t, fill=GENERO)) + 
  geom_bar(stat="identity", position = position_dodge2(preserve = "single"), colour = "grey") 

ggplot(data2, aes(GRUPO_ETARIO, t, fill=GENERO)) + 
  geom_bar(stat="identity", position = position_dodge2(preserve = "total"), colour = "grey") 


# DOSIS_1, DOSIS_2, DOSIS_3, no son tres variables, son tres valore de la variable DOSIS...
# install.packages("tidyr")
library(tidyr)

vacunas %>% pivot_longer(cols = c(DOSIS_1, DOSIS_2, DOSIS_3), names_to = "DOSIS", values_to = "aplicadas") %>%
  select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, DOSIS, aplicadas) %>%
  group_by(GRUPO_ETARIO, GENERO, DOSIS) %>% summarise(t = sum(aplicadas)) %>%
  ggplot(aes(x = GENERO, y = t, fill = GRUPO_ETARIO)) +
    geom_bar(stat="identity") +
    facet_wrap(~ DOSIS)










## clase2

vacunas %>% filter(is.na(vacunas$DOSIS_3)) %>% select(-FECHA_ADMINISTRACION, -ID_CARGA)

filter(vacunas, is.na(vacunas$DOSIS_3))

select(filter(vacunas, is.na(vacunas$DOSIS_3)), -FECHA_ADMINISTRACION, -ID_CARGA)


ls()

vacunas %>% filter(DOSIS_1 > 10, DOSIS_2 > 20)


actual <- options("scipen")
actual[[1]]
options(scipen=0)
#### scipen: Los valores positivos sesgan hacia la notación fija y los negativos hacia la notación científica: se preferirá la notación fija a menos que sea más que dígitos scipen más anchos.
#### Por defecto es cero.





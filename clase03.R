library(dplyr)
library(ggplot2)
library(sf)

# https://data.buenosaires.gob.ar/dataset/establecimientos-educativos
# establecimientos <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/establecimientos-educativos/establecimientos_educativos_WGS84.csv")
establecimientos <- read_csv("datos/establecimientos_educativos_WGS84.csv")

str(establecimientos)

table(establecimientos$comuna)

table(establecimientos$barrio)

# poblacion <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv")
poblacion <- read_csv("datos/caba_pob_barrios_2010.csv")

sum(table(poblacion$BARRIO))

establecimientos %>% group_by(barrio) %>% summarise(ESTABLECIMIENTOS = n()) %>% mutate(BARRIO = barrio) %>%
  left_join(poblacion) 

establecimientos %>% group_by(barrio) %>% summarise(ESTABLECIMIENTOS = n()) %>% mutate(BARRIO = barrio) %>%
  anti_join(poblacion) 

which(establecimientos[, "barrio"] == "MONTSERRAT")
which(poblacion[, "BARRIO"] == "MONSERRAT")

which(establecimientos[, "barrio"] == "SAN NIICOLAS")
which(poblacion[, "BARRIO"] == "SAN NICOLAS")

establecimientos[which(establecimientos[, "barrio"] == "MONTSERRAT"),"barrio"] <- "MONSERRAT"
establecimientos[which(establecimientos[, "barrio"] == "SAN NIICOLAS"),"barrio"] <- "SAN NICOLAS"

establecimientos %>% group_by(barrio) %>% summarise(ESTABLECIMIENTOS = n()) %>%
  left_join(poblacion, by = c("barrio" = "BARRIO") ) 

names(establecimientos)
names(establecimientos)[22]
names(establecimientos)[names(establecimientos) == "barrio"]
names(establecimientos)[names(establecimientos) == "barrio"] <- "BARRIO"

establecimientos %>% group_by(BARRIO) %>% summarise(ESTABLECIMIENTOS = n()) %>%
  left_join(poblacion) 

establecimientos %>% group_by(BARRIO) %>% summarise(ESTABLECIMIENTOS = n()) %>%
  left_join(poblacion) %>%
  mutate(CADA_1000 = (ESTABLECIMIENTOS * 1000) / POBLACION)

library(readr)

barrios2 <- st_read("datos/barrios.csv")
barrios3 <- establecimientos %>% group_by(BARRIO) %>% summarise(ESTABLECIMIENTOS = n()) %>%
  left_join(poblacion) %>%
  mutate(CADA_1000 = (ESTABLECIMIENTOS * 1000) / POBLACION)


ggplot(barrios2 %>% left_join(barrios3, by = c("barrio" = "BARRIO") )) + 
  geom_sf(aes(fill=CADA_1000))


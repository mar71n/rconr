library(dplyr)
library(ggplot2)
library(readr)
library(sf)

# https://data.buenosaires.gob.ar/dataset/establecimientos-educativos
# establecimientos <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/establecimientos-educativos/establecimientos_educativos_WGS84.csv")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/establecimientos-educativos/establecimientos_educativos_WGS84.csv", "datos/establecimientos_educativos_WGS84.csv")
establecimientos <- read_csv("datos/establecimientos_educativos_WGS84.csv")

spec(establecimientos)

head(establecimientos)

names(establecimientos)

names(establecimientos) <- toupper(names(establecimientos))

establecimientos %>% distinct(BARRIO)

c(establecimientos %>% distinct(BARRIO))

n_distinct(establecimientos$BARRIO)

# poblacion <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv")
poblacion <- read_csv("datos/caba_pob_barrios_2010.csv")

poblacion %>% count(BARRIO) %>% filter(n != 1)

poblacion %>% distinct(BARRIO)

n_distinct(poblacion$BARRIO)

c(poblacion %>% distinct(BARRIO))

setdiff(establecimientos$BARRIO, poblacion$BARRIO)

setdiff(poblacion$BARRIO, establecimientos$BARRIO)

which(establecimientos[, "BARRIO"] == "MONTSERRAT")
which(poblacion[, "BARRIO"] == "MONSERRAT")

which(establecimientos[, "BARRIO"] == "SAN NIICOLAS")
which(poblacion[, "BARRIO"] == "SAN NICOLAS")

establecimientos[which(establecimientos[, "BARRIO"] == "MONTSERRAT"),"BARRIO"] <- "MONSERRAT"
establecimientos[which(establecimientos[, "BARRIO"] == "SAN NIICOLAS"),"BARRIO"] <- "SAN NICOLAS"

establecimientos %>% group_by(BARRIO) %>% 
  summarise(ESTABLECIMIENTOS = n()) %>% 
  left_join(poblacion) 


establecimientos %>% group_by(barrio) %>% summarise(ESTABLECIMIENTOS = n()) %>%
  left_join(poblacion, by = c("barrio" = "BARRIO") ) 


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


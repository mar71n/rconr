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

establecimientos %>% anti_join(poblacion, by = "BARRIO") %>% filter() %>% select(BARRIO)
poblacion %>% anti_join(establecimientos, by = "BARRIO") %>% filter()

establecimientos %>% full_join(poblacion, by = "BARRIO") %>% 
  select(starts_with("NOMBRE"), BARRIO, POBLACION) %>% 
  filter(is.na(NOMBRE_EST) | is.na(POBLACION) ) %>% 
  arrange(POBLACION)

full_join(band_members, band_instruments)
  
  
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

# left_join(), la mayoria de las veces
# right_join(), por ejemplo cuando la clave de uno de los lados es compuesta y está en dos tablas

establecimientos %>% count(DE, NIVEL)

establecimientos %>% distinct( NIVEL)











# https://data.buenosaires.gob.ar/dataset/plan-de-vacunacion-covid-19
# vacunas <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv", "datos/dataset_total_vacunas.csv")
vacunas <- read_csv("datos/dataset_total_vacunas.csv")

names(vacunas)

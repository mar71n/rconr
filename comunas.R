library(dplyr)

barrios <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/barrios.csv", encoding = "UTF-8")

barrios <- read.csv("barrios.csv")

poblacion <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv", encoding = "UTF-8")

comunas <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", encoding = "UTF-8")

comunas <- read.csv("comunas.csv")

names(barrios)

str(barrios)

summary(barrios)

# library(dplyr)
barrios %>% select(!WKT)

barrios %>% select(barrio, comuna)

names(comunas)

str(comunas)

names(poblacion)

str(poblacion)

comunas %>% select(COMUNAS, BARRIOS)

library(ggplot2)
library(sf)

ggplot(barrios) +
  geom_bar(aes(x = barrio, weight = area)) +
             coord_flip()

ggplot(barrios %>% select(barrio, area)) +
  geom_bar(aes(x = reorder(barrio, area), weight = area)) +
  coord_flip()

write.csv(barrios, "datos/barrios.csv", row.names = FALSE)

barrios2 <- st_read("datos/barrios.csv")

ggplot(barrios2) + 
  geom_sf(aes(fill=comuna))


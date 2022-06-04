
barrios <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/barrios.csv", encoding = "UTF-8")

barrios <- read.csv("barrios.csv")

comunas <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", encoding = "UTF-8")

comunas <- read.csv("comunas.csv")

names(barrios)

str(barrios)

barrios %>% select(!WKT)

barrios %>% select(barrio, comuna)

names(comunas)

str(comunas)

comunas %>% select(COMUNAS, BARRIOS)

readWKT(barrior$WKT[1])
library(ggplot2)
library(sf)
library(dplyr)

write.csv(barrios, "barrios.csv", row.names = FALSE)


barrios2 <- st_read("barrios.csv")

ggplot(barrios2) + 
  geom_sf(aes(fill=comuna))

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


dplyr::setdiff(establecimientos$BARRIO, poblacion$BARRIO)

dplyr::setdiff(poblacion$BARRIO, establecimientos$BARRIO)

which(establecimientos[, "BARRIO"] == "MONTSERRAT")
which(poblacion[, "BARRIO"] == "MONSERRAT")

establecimientos %>% anti_join(poblacion, by = "BARRIO") %>% filter() %>% select(BARRIO)
poblacion %>% anti_join(establecimientos, by = "BARRIO") %>% filter()

establecimientos %>% full_join(poblacion, by = "BARRIO") %>% 
  select(starts_with("NOMBRE"), BARRIO, POBLACION) %>% 
  filter(is.na(NOMBRE_EST) | is.na(POBLACION) ) %>% 
  arrange(POBLACION)

full_join(band_members, band_instruments)
  
establecimientos %>% anti_join(poblacion, by = "BARRIO") %>% select(NOMBRE_ABR, BARRIO)

poblacion %>% anti_join(establecimientos, by = "BARRIO")



  
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


# https://ggplot2-book.org/introduction.html#what-is-the-grammar-of-graphics
# Un grafico esta compuesto por los datos que vamos a graficar.
# Y por mapping: la definicion de como las variables de esos datos son mostrados
# Hay 5 componentes de mapping:
# - Layer : coleccion de elementos geometricos y estadisticas. 
#           geom : puntos, lineas, poligonos
#           stats : conteo, ajuste de un modelo lineal, etc 
# - Scales : asigna los valores en el espacio de datos al espacio estético.
#            Incluye el color, relleno, tamaño. Tambien leyendas y ejes
# - Coord : Sistema de coordenadas. Por lo general cartesianas, pero pude ser polares
#           proyecciones geograficas, etc
# - Facet : especifica como dividir y mostrar sub conjuntos de datos
# - Theme : controla puntos mas finos, tamaño de fuente, color de fondo  

# https://ggplot2-book.org/getting-started.html#basic-use
# Tres componentes claves:
# - data
# - aesthetic mappings
# - al menos un layer, creado con geom

ggplot(mpg, aes(cty, hwy)) + geom_point()

ggplot(diamonds, aes(carat, price)) + geom_point()

ggplot(economics, aes(date, unemploy)) + geom_line()

ggplot(mpg, aes(cty)) + geom_histogram()

ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(colour = "blue"))
ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")


ggplot(mpg, aes(displ, colour = drv)) + 
  geom_freqpoly(binwidth = 0.5)
ggplot(mpg, aes(displ, fill = drv)) + 
  geom_histogram(binwidth = 0.5) + 
  facet_wrap(~drv, ncol = 1)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = factor(cyl))) + 
  labs(
    x = "Engine displacement (litres)", 
    y = "Highway miles per gallon", 
    colour = "Number of cylinders",
    title = "Mileage by engine size and cylinders",
    subtitle = "Source: http://fueleconomy.gov",
    caption = "Fuente: www.databuenosaires.gob.ar"
  ) + geom_smooth()


# https://data.buenosaires.gob.ar/dataset/plan-de-vacunacion-covid-19
# vacunas <- read_csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/plan-de-vacunacion-covid-19/dataset_total_vacunas.csv", "datos/dataset_total_vacunas.csv")
vacunas <- read_csv("datos/dataset_total_vacunas.csv")

names(vacunas)

data1 <- vacunas %>% 
  mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% 
  select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GRUPO_ETARIO) %>% 
  summarise(TGRUPO = sum(total, na.rm=TRUE))

data1

data2 <- vacunas %>% 
  mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% 
  select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GRUPO_ETARIO, GENERO) %>% 
  summarise(TGG = sum(total, na.rm=TRUE)) %>%
  left_join(data1, by = "GRUPO_ETARIO") %>%
  mutate(PPGG = round(TGG / TGRUPO * 100, 2))

data2

ggplot(data2, aes(GRUPO_ETARIO, TGG, fill=GENERO)) + 
  geom_bar(stat="identity", position = "stack", colour = "grey") +
  geom_text(aes(label= TGG), vjust= -0.5, color="black", size=3, position = position_stack(vjust = 0.5)) +
  labs(
    x = "Grupo Etario", 
    y = "Total por Género", 
    fill = "Género",
    title = "Vacunados por Grupo Etario",
    subtitle = "Por Género",
    caption = "Fuente: www.databuenosaires.gob.ar"
  )


ggplot(data2, aes(GRUPO_ETARIO, TGG, fill=GENERO)) + 
  geom_bar(stat="identity", position = "fill", colour = "grey") +
  geom_text(aes(label= round(PPGG, 2)), vjust= -0.5, color="black", size=3, position = position_fill(vjust = 0.5)) +
  labs(
    x = "Grupo Etario", 
    y = "% por Género", 
    fill = "Género",
    title = "Vacunados por Grupo Etario",
    subtitle = "Porciento del Genero",
    caption = "Fuente: www.databuenosaires.gob.ar"
  )

dput(data2)


p1 <- ggplot(data2, aes(GRUPO_ETARIO, TGG, fill=GENERO)) + 
  geom_bar(stat="identity", position = "fill", colour = "grey") +
  geom_text(aes(label= round(PPGG, 2)), vjust= -0.5, color="black",  position = position_fill(vjust = 0.5)) +
  labs(
    x = "Grupo Etario", 
    y = "% por Género", 
    fill = "Género",
    title = "Vacunados por Grupo Etario",
    subtitle = "Porciento del Genero",
    caption = "Fuente: www.databuenosaires.gob.ar"
  ) +
  theme_bw()

# https://ggplot2.tidyverse.org/reference/ggsave.html

ggsave("salidas/vacunas_x_grupo_etario.png", p1)



p <- ggplot(mtcars, aes(mpg, wt, colour = cyl)) + geom_point()
p + labs(colour = "Cylinders")
p + labs(x = "New x label")

p + labs(title = "title", tag = "A")






























datos <- structure(list(GRUPO_ETARIO = c("30 o menos", "30 o menos", "30 o menos", 
                                         "31 a 40", "31 a 40", "31 a 40", "41 a 50", "41 a 50", "41 a 50", 
                                         "51 a 60", "51 a 60", "61 a 70", "61 a 70", "61 a 70", "71 a 80", 
                                         "71 a 80", "81 a 90", "81 a 90", "91 o mas", "91 o mas"), GENERO = c("F", 
                                                                                                              "M", "N", "F", "M", "N", "F", "M", "N", "F", "M", "F", "M", "N", 
                                                                                                              "F", "M", "F", "M", "F", "M"), TGG = c(1210000, 1157366, 20, 
                                                                                                                                                     683382, 630074, 9, 660293, 593204, 1, 524800, 450708, 449852, 
                                                                                                                                                     347727, 1, 385841, 248420, 218723, 105779, 53467, 15660), TGRUPO = c(2367386, 
                                                                                                                                                                                                                          2367386, 2367386, 1313465, 1313465, 1313465, 1253498, 1253498, 
                                                                                                                                                                                                                          1253498, 975508, 975508, 797580, 797580, 797580, 634261, 634261, 
                                                                                                                                                                                                                          324502, 324502, 69127, 69127), PPGG = c(51.11, 48.89, 0, 52.03, 
                                                                                                                                                                                                                                                                  47.97, 0, 52.68, 47.32, 0, 53.8, 46.2, 56.4, 43.6, 0, 60.83, 
                                                                                                                                                                                                                                                                  39.17, 67.4, 32.6, 77.35, 22.65)), class = c("grouped_df", "tbl_df", 
                                                                                                                                                                                                                                                                                                               "tbl", "data.frame"), row.names = c(NA, -20L), groups = structure(list(
                                                                                                                                                                                                                                                                                                                 GRUPO_ETARIO = c("30 o menos", "31 a 40", "41 a 50", "51 a 60", 
                                                                                                                                                                                                                                                                                                                                  "61 a 70", "71 a 80", "81 a 90", "91 o mas"), .rows = structure(list(
                                                                                                                                                                                                                                                                                                                                    1:3, 4:6, 7:9, 10:11, 12:14, 15:16, 17:18, 19:20), ptype = integer(0), class = c("vctrs_list_of", 
                                                                                                                                                                                                                                                                                                                                                                                                                     "vctrs_vctr", "list"))), class = c("tbl_df", "tbl", "data.frame"
                                                                                                                                                                                                                                                                                                                                                                                                                     ), row.names = c(NA, -8L), .drop = TRUE))


datos


p1 <- ggplot(datos, aes(GRUPO_ETARIO, TGG, fill=GENERO)) + 
  geom_bar(stat="identity", position = "fill", colour = "grey") +
  geom_text(aes(label= round(PPGG, 2)), vjust= -0.5, color="black",  position = position_fill(vjust = 0.5)) +
  labs(
    x = "Grupo Etario", 
    y = "% por Género", 
    fill = "Género",
    title = "Vacunados por Grupo Etario",
    subtitle = "Porciento del Genero",
    caption = "Fuente: www.databuenosaires.gob.ar"
  ) +
  theme_bw()


p1



# http://www.sthda.com/english/wiki/ggplot2-essentials
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html





entorno <- Sys.getenv()
str(entorno)
"SHELL" %in% names(entorno)
"HTTP_PROXY" %in% names(entorno)
Sys.getenv("http_proxy")
Sys.getenv("HTTP_PROXY")
Sys.setenv(HTTP_PROXY="http://proxy.xxxx:1234/")
Sys.setenv(HTTPS_PROXY="http://proxy.xxxx:1234/")

#### Evaluacion
library(dplyr)

#  1 - cuantos elementos tiene el subset resultado?

m1 <- matrix(c(1, 2, 3, sample(15, )), ncol = 3, byrow = TRUE)
c(9,7,1,13,2,3,15,5,4,6,11,12,10,14,8)
m1 <- matrix(c(1, 2, 3, 9,7,1,13,2,3,15,5,4,6,11,12,10,14,8), ncol = 3, byrow = TRUE)

t1 <- as_tibble(m1)

t1[2,]

subset(t1, V1 > 2 & V2 < 10)

# 4, 6, 3, 1

#  2 - 
# Dado
c1 <- c(7, 1, 3L, 12.3)

# en cual de los siguientes casos, 1 es el primer elemento de la salida

order(c1, decreasing = FALSE)

sort(c1, decreasing = TRUE)

sort(c1, decreasing = FALSE)

arrange(c1)

m1 <- matrix(c(1, 2, 3, sample(15)), ncol = 3, byrow = TRUE)
m1
m1 <- as_tibble(m1)
arrange(m1, V1)

m1 <- as.data.frame(m1)
arrange(m1, V1)

#  3 - cardinalidad de joins

#  4 -

#  5 - reconocer geom_

# geom_bar geom_poin geom_area geom_density

#  6 - cuantas variables se grafican ?

# 1, 2, 3, más

#  7 - reconocer otros elementos graficos 

#  8 - 

# 9 - fechas

# 10 -





library(dplyr)

barrios <- read.csv("datos/barrios.csv")
poblacion <- read.csv("datos/caba_pob_barrios_2010.csv", encoding = "UTF-8")

names(barrios)
names(poblacion)

barrios_pob <- barrios %>% select(BARRIO = barrio, AREA = area) %>% left_join(poblacion) %>% mutate(POBDENS = POBLACION / AREA)
head(barrios_pob)
sum(barrios_pob$POBLACION)


options(scipen=999)  # turn-off scientific notation like 1e+48 penalidad por usar notacion cientifica
library(ggplot2)
theme_set(theme_bw())  # pre-set the bw theme.

gg <- ggplot(barrios_pob, aes(x=AREA, y=POBLACION)) + 
  geom_point(aes(col=BARRIO, size=POBDENS)) + 
  #geom_smooth(method="loess", se=F) + 
  #xlim(c(0, 0.1)) + 
  #ylim(c(0, 500000)) + 
  labs(subtitle="Area Vs Population", 
       y="Population", 
       x="Area", 
       title="Scatterplot", 
       caption = "Source: midwest")

gg

table(t1$V1)

library(lubridate)

dmy_hms("23/05/2022:15:24:00")

typeof(dmy_hms("23 may 2022:15:24:00"))
class(dmy_hms("23 may 2022:15:24:00"))
mode(dmy_hms("23 may 2022:15:24:00"))
is.Date("23 may 2022:15:24:00")
is.timepoint(dmy_hms("23 may 2022:15:24:00"))
is.timepoint(dmy("23 may 2022"))



dmy_hms("23 feb 2022 15:24:00")


# reciclado

v1 <- c(1:6)
v2 <- c(1:5)

v1 + v2

# 7, 6, 1



tipo <- c(rep("baja", 10), rep("media", 10), rep("alta", 12))

caballos <- mtcars %>% select(hp) %>% arrange(hp) %>% mutate(tipo = tipo)
caballos <- mtcars %>% select(hp) %>% arrange(hp) %>% mutate(hptipo = factor(tipo, levels=c("baja", "media", "alta")))

str(caballos)

caballos %>% arrange(hptipo) %>% filter(hp > 200)

caballos %>% arrange(hptipo)

caballos <- caballos %>% arrange(row.names(caballos))

caballos[sample(10),]

head(caballos)

caballos <- as_tibble(caballos, rownames = "modelo")

caballos %>% filter(as.numeric(hptipo) == 2)

caballos %>% filter(hptipo == "media")

caballos %>% filter(hptipo != "alta" & hptipo != "baja")

caballos %>% filter(!(hptipo %in% c("baja", "alta")))

typeof(caballos$hptipo)
is.factor(caballos$hptipo)

levels(caballos$hptipo)

cars
mtcars

dput(t1)


dput(caballos)
caballos <- structure(list(modelo = c("Honda Civic", "Merc 240D", "Toyota Corolla", 
                          "Fiat 128", "Fiat X1-9", "Porsche 914-2", "Datsun 710", "Merc 230", 
                          "Toyota Corona", "Valiant", "Volvo 142E", "Mazda RX4", "Mazda RX4 Wag", 
                          "Hornet 4 Drive", "Lotus Europa", "Merc 280", "Merc 280C", "Dodge Challenger", 
                          "AMC Javelin", "Hornet Sportabout", "Pontiac Firebird", "Ferrari Dino", 
                          "Merc 450SE", "Merc 450SL", "Merc 450SLC", "Cadillac Fleetwood", 
                          "Lincoln Continental", "Chrysler Imperial", "Duster 360", "Camaro Z28", 
                          "Ford Pantera L", "Maserati Bora"), hp = c(52, 62, 65, 66, 66, 
                                                                     91, 93, 95, 97, 105, 109, 110, 110, 110, 113, 123, 123, 150, 
                                                                     150, 175, 175, 175, 180, 180, 180, 205, 215, 230, 245, 245, 264, 
                                                                     335), hptipo = structure(c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
                                                                                                1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 
                                                                                                3L, 3L, 3L, 3L, 3L, 3L, 3L), levels = c("baja", "media", "alta"
                                                                                                ), class = "factor")), row.names = c(NA, -32L), class = c("tbl_df", 
                                                                                                                                                          "tbl", "data.frame"))


m2 <- structure(c(1, 9, 13, 15, 6, 10, 2, 7, 2, 5, 11, 14, 3, 1, 3, 4, 12, 8), dim = c(6L, 3L))
m2


set.seed(5)
id1 <- sample.int(999999, 5)
id1
set.seed(7)
id1 <- c(id1, sample.int(999999, 5))
set.seed(6)
id2 <- sample.int(999999, 5)
id2
set.seed(7)
id2 <- c(id2, sample.int(999999, 5))

tid1 <- as_tibble(id1)
tid1 <- tid1 %>% cbind(t1 = rep("A", 10))
tid2 <- as_tibble(id2)
tid2 <- tid2 %>% cbind(t2 = rep("B", 10))

full_join(tid1, tid2)

left_join(tid1, tid2)

inner_join(tid1, tid2)

anti_join(tid1, tid2) 
anti_join(tid2, tid1)

semi_join(tid2, tid1)
semi_join(tid1, tid2)

tid1 %>% inner_join(tid2)

tid1 %>% left_join(tid2)

v1 <- as_tibble(cbind(id = 1:10, ta = rep("A", 10)))
v2 <- as_tibble(cbind(id = 6:15, tb = rep("B", 10)))

full_join(v1, v2)

anti_join(v1, v2)
anti_join(v2, v1)

# porque da lo mismo el orden de los parametros
# porque en los dos hay 5 elementos que coinciden
# porque en los dos hay 5 elementos que no coinciden
# porque es la mitad de 10


L1 <- list(1, "A", list(2, "B"))
L1

L1[3]
L1[[3]][[2]]
L1[3][2]
L1[[3]][2]




t1 <-
  structure(list(V1 = c(1, 9, 13, 15, 6, 10), V2 = c(2, 7, 2, 5,
                                                     11, 14), V3 = c(3, 1, 3, 4, 12, 8)), class = c("tbl_df", "tbl",
                                                                                                    "data.frame"), row.names = c(NA, -6L))

subset(t1, V1 > 2 & V2 < 10)


c1 <- c(7, 1, 3L, 12.3)

order(c1, decreasing = FALSE)
sort(c1, decreasing = TRUE)
sort(c1, decreasing = FALSE)
arrange(c1)

library(lubridate)

dmy_hms("23 feb 2022 15:24:00")

v1 <- c(1:6)
v2 <- c(1:5)
v1 + v2

caballos <-
  structure(list(modelo = c("Honda Civic", "Merc 240D", "Toyota Corolla",
                            "Fiat 128", "Fiat X1-9", "Porsche 914-2", "Datsun 710", "Merc 230",
                            "Toyota Corona", "Valiant", "Volvo 142E", "Mazda RX4", "Mazda RX4 Wag",
                            "Hornet 4 Drive", "Lotus Europa", "Merc 280", "Merc 280C", "Dodge Challenger",
                            "AMC Javelin", "Hornet Sportabout", "Pontiac Firebird", "Ferrari Dino",
                            "Merc 450SE", "Merc 450SL", "Merc 450SLC", "Cadillac Fleetwood",
                            "Lincoln Continental", "Chrysler Imperial", "Duster 360", "Camaro Z28",
                            "Ford Pantera L", "Maserati Bora"), hp = c(52, 62, 65, 66, 66,
                                                                       91, 93, 95, 97, 105, 109, 110, 110, 110, 113, 123, 123, 150,
                                                                       150, 175, 175, 175, 180, 180, 180, 205, 215, 230, 245, 245, 264,
                                                                       335), hptipo = structure(c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                  1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L,
                                                                                                  3L, 3L, 3L, 3L, 3L, 3L, 3L), levels = c("baja", "media", "alta"
                                                                                                  ), class = "factor")), row.names = c(NA, -32L), class = c("tbl_df",
                                                                                                                                                            "tbl", "data.frame"))

caballos

caballos %>% filter(as.numeric(hptipo) == 2)

caballos %>% filter(hptipo == "media")

caballos %>% filter(hptipo != "alta" & hptipo != "baja")

caballos %>% filter(!(hptipo %in% c("baja", "alta")))


v1 <- as_tibble(cbind(id = 1:10, ta = rep("A", 10)))
v2 <- as_tibble(cbind(id = 6:15, tb = rep("B", 10)))

full_join(v1, v2)

anti_join(v1, v2)

anti_join(v2, v1)

L1 <- list(1, "A", list(2, "B"))
L1[[3]][[2]]

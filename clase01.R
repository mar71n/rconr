
?Arithmetic # Operadores aritméticos

?log  # logaritmo y exponenciacón

?sin  # trigonometricas

# cos(x)
# sin(x)
# tan(x)

# acos(x)
# asin(x)
# atan(x)

?Special  # factorial

# factorial(x)
# lfactorial(x)

?sqrt  # raiz cuadrada

# abs(x)
# sqrt(x)

x <- 10^-(1+2*1:5)
cbind(x, log(1+x), log1p(x), exp(x)-1, expm1(x))

plot(cbind(x, log(1+x), log1p(x), exp(x)-1, expm1(x)), type = "l")
?plot
plot(cbind(x, log1p(x), exp(x)-1, expm1(x)), type = "l")

plot(sin, seq(0, 2*pi, 0.1), type = "l")


# barrios <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/barrios.csv", encoding = "UTF-8")
barrios <- read.csv("datos/barrios.csv", encoding = "UTF-8")

# poblacion <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv", encoding = "UTF-8")
poblacion <- read.csv("datos/caba_pob_barrios_2010.csv", encoding = "UTF-8")

# comunas <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", encoding = "UTF-8")
comunas <- read.csv("datos/comunas.csv", encoding = "UTF-8")

library(dplyr)
barrios %>% select(barrio, comuna)

head(
  barrios[c("barrio", "comuna")]
)

head(
  barrios[c(2,3)]
)

head(
  barrios[c(-1,-4,-5)]
)



str(barrios[2])

str(barrios[[2]])

library(readr)
poblacion <- read_csv("datos/caba_pob_barrios_2010.csv")

str(poblacion[1])
str(poblacion[[1]])


barrios[5,c(2,3)]

barrios[5:10,c(2,3)]

barrios[2:3,c(2,3)]
barrios[2,-1]

barrios[[2,3]]

barrios$barrio
barrios[[2]]
barrios[2]
barrios[2]


barplot(barrios$area ~  barrios$barrio)

barrios_x_area <- barrios[order(barrios$area),-1]

barrios_x_area$barrio <- as.factor(barrios_x_area$barrio)

head(barrios_x_area)

barplot(barrios_x_area$area ~  barrios_x_area$barrio)



precio_anterior = 85.23
precio_actual = 99.0
diferencia = precio_actual - precio_anterior
# Que % aumento ? (del precio inicial)
diferencia / precio_anterior * 100
# más "estable"
((precio_actual / precio_anterior) - 1) * 100

aumento <- function(x, y){
  ((y / x) - 1) * 100
}

aumento1 <- function(x, y){
  (y - x) / x * 100
}


print(aumento(1.0023, 1.0023 * 1.00000001), 10)
print(aumento1(1.0023, 1.0023 * 1.00000001), 10)

1.0023 * 1.00000001 / 1.003

(1.0023 - 1.00000001) 


c(1, 4, 7, 3)

c("a", "23", "abc")

c(TRUE, FALSE, FALSE, TRUE)

vnumeros <- c(1, 4, 7, 3, 4, 3, 5)

vnumeros > 3

vnumeros[vnumeros > 3] 

which(vnumeros > 3)

vnumeros[which(vnumeros > 3)] 

order(vnumeros)

vnumeros[order(vnumeros)]

sort(vnumeros)

matriz <- matrix(c(18, 8.10, 20, 9, 21,	9.45, 22,	9.90, 23,	10.35), ncol = 2, byrow = TRUE )

matriz

# https://www.argentina.gob.ar/redsube/tarifas-de-transporte-publico-amba-2021

matriz_colectivo <- matrix(
  filas <- c(18, 8.10, 20, 9, 21,	9.45, 22,	9.90, 23,	10.35),
  nrow = 5, byrow = TRUE,
  dimnames = list(c("0 a 3 km", "3 a 6 km", "6 a 12 km", "12 a 27 km", "más de 27 km"),
                  c("Tarifa"	,"Con tarifa social"))
)

matriz_colectivo

matriz_colectivo * 1.4

decreciente <- order(matriz_colectivo[,1], decreasing = TRUE)
matriz_colectivo[decreciente, ]

matriz_colectivo[,"Tarifa"] * 1.4

aumentos <- matrix(c(rep(1.4,5), rep(1,5)), nrow = 5, byrow = FALSE)

aumentos

matriz_colectivo * aumentos


matriz <- matrix(c(18, 8.10, 20, 9, 21,	9.45, 22,	9.90, 23,	10.35), ncol = 2, byrow = TRUE )

matriz

matriz[,1]

matriz[3,]

matriz[3,1]

matriz[1:3,1:2]

matriz[2:4,]

matriz[[7]]

head(matriz)

v1 <- c(1,2,3,4,5)
length(v1)
v1[3]
v1[6] <- 6
v1

l1 <- list(1,2,3,c(4,5,6), "A", c("B","C"), list(c(1,2,3), c("a","b", "c")))
l1
length(l1)
l1[[8]] <- c("c", "b", "a")

l1[1]

l1[[1]]

l1[4]

l1[[4]]

l1[[4]][2]

l1[[7]]

l1[[7]][[2]]

l1[[7]][[2]][1]

l1[8]


lista_cole <- list(matriz_colectivo, aumentos)
lista_cole

lista_cole <- list(matriz_colectivo, aumentos)

sapply(matriz_colectivo["Tarifa"], mean)

matriz_colectivo[,c(1,2)]

mean(matriz_colectivo[,1])

mean(matriz_colectivo[,2])



lt <- list(t = matriz_colectivo[,1], ts = matriz_colectivo[,2])

sapply(lt, mean)

lt

ll <- list(matriz_colectivo)

sapply(ll, mean)

#' ---
#' title: "Clase 01"
#' output: html_document
#' #date: '2023-07-12'
#' knit: (function(inputFile, encoding) {
#'   out_dir <- '../docs/apuntes2023';
#'   rmarkdown::render(inputFile,
#'                     encoding="UTF-8",
#'                     output_file=file.path(dirname(inputFile), out_dir, 'clase01.html')); 
#'   knitr::purl("clase01.Rmd", documentation = 2L, output = "../docs/apuntes2023/clase01.R")  })
#' ---
#' 
## ----klippy, echo=FALSE, include=TRUE-----------------------------------------
klippy::klippy('')

#' 
#' ```
#' Instalación, ayuda, búsquedas:
#' R, CRAN, R-seek, RStudio, install.packages, library
#' Variables y tipos, importar datos:
#' vectores, matrices, factores, list, asignación
#' dataframe, tibles
#' ```
#' 
#' Una versión actualizada de este material en : [clase01](https://mar71n.github.io/rconr/clase01.html)
#' 
#' ***
#' 
#' ## Instalar:
#' 
#' ### Página principal de R:
#' - [https://www.r-project.org/](https://www.r-project.org/)
#' 
#' - Descargas o CRAN lleva a : [https://cran.r-project.org/mirrors.html](https://cran.r-project.org/mirrors.html)
#' 
#' - Donde vemos una lista de "mirrors".
#' 
#' - De Argentina : El de la [Facultad de Ciencias Astronómicas y Geofísicas - UNLP](https://www.fcaglp.unlp.edu.ar/)
#' 
#' http://mirror.fcaglp.unlp.edu.ar/CRAN/
#' 
#' - O uno general https://cloud.r-project.org/ que de alguna manera elije entre los disponibles.
#' 
#' Descargamos el instalador para el SO y arquitectura correspondiente.
#' 
#' En caso de tener una versión anterior instalada, lo mejor es desinstalarla. Ver: [Upgrade en CRAN](upgrade.html)
#' 
#' En redes que usan un proxy para conectarse a internet: [configurar proxy](clase01_proxy.html)
#' 
#' ### Rtools :
#' Para algunas instalaciones de paquetes en Windows
#' 
#' - para R4.2:
#' [https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html](https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html)
#' 
#' - para R3.6 o menos :
#' [https://cran.r-project.org/bin/windows/Rtools/history.html](https://cran.r-project.org/bin/windows/Rtools/history.html)
#' 
#' ### Rstudio :
#' - [www.rstudio.com](https://www.rstudio.com/)
#' - [www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/)
#' 
#' #### RStudio se convierte en **Posit** en Octubre. [**posit.co**](https://posit.co/)
#' 
#' ***
#' 
#' ### Búsquedas y ayuda :
#' 
#' - [https://rseek.org/](https://rseek.org/)
#' 
#' - [https://www.rdocumentation.org/](https://www.rdocumentation.org/)
#' 
#' - [https://community.rstudio.com/](https://community.rstudio.com/)
#' 
#' - [versión en español de Stack Overflow](https://es.stackoverflow.com/)
#' 
#' ***
#' 
#' ### Paquetes:
#' 
#' #### Librería estándar :
#' ##### Estos paquetes se instalan junto con R. Por lo que no hace falta instalarlos con *install.packages()*
#' ##### [*Paquetes de la librería estándar*](https://stat.ethz.ch/R-manual/R-devel/doc/html/packages.html)
#' ##### Algunos de ellos se cargan al comenzar, por lo que tampoco hace falta cargarlos con *library()*
#' - [base](https://stat.ethz.ch/R-manual/R-devel/library/base/html/00Index.html)
#' - [stats](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/00Index.html)
#' - [utils](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/00Index.html)
#' - [datasets](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html)
#' - ...
#' 
#' #### Tidyverse :
#' - [www.tidyverse.org](https://www.tidyverse.org/packages/)
#'   - [**dplyr**](https://dplyr.tidyverse.org/)
#'   - [**ggplot2**](https://ggplot2.tidyverse.org/)
#'   - [**readr**](https://readr.tidyverse.org/)
#'   - [**lubridate**](https://lubridate.tidyverse.org/)
#'   - [**stringr**](https://stringr.tidyverse.org/)
#' 
#' #### sf :
#' - [r-spatial.github.io/sf/](https://r-spatial.github.io/sf/)
#' 
#' ***
#' 
#' #### Con este link se puede crear un R-notebook en Google Drive, que nos vá a servir para seguir la mayoría de los ejemplos que encontramos en la web:
#' #### [colab.to/r](https://colab.to/r)
#' 
#' ## Variables y tipos, importar algunos datos:
#' 
#' #### Con la función *typeof(x)* vemos el *type* al que pertenece x
#' ##### Ejemplos de los principales tipos en R:
#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
typeof(1.2)

typeof(1L)

typeof("abc")

typeof(TRUE)

typeof(2+1i)


#' 
#' #### Con los tipos numéricos, R es una "calculadora"
#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# Suma
15 + 35 

# Resta
50 - 35 

# Multiplicación
3 * 5

# Division
(15 + 35) / 2 

# Potencia
2^8

# Division
29 / 6

# Division entera
29 %/% 6

# Modulo o resto
29 %% 6

#' 
#' #### Con _**?**item_ nos muestra ayuda sobre el _item_
#' ##### Los ejemplos siguientes nos muestran en el panel de *Help* las funciones matemáticas disponibles con la librería estándar.
## ---- eval=FALSE--------------------------------------------------------------
## ?Arithmetic # Operadores aritméticos
## 
## # x + y
## # x - y
## # x * y
## # x / y
## # x ^ y
## # x %% y
## # x %/% y
## 
## ?log  # logaritmo y exponenciacón
## 
## # log(x, base = exp(1))
## # logb(x, base = exp(1))
## # log10(x)
## # log2(x)
## # exp(x)
## 
## ?sin  # trigonometricas
## 
## # cos(x)
## # sin(x)
## # tan(x)
## 
## # acos(x)
## # asin(x)
## # atan(x)
## 
## ?Special  # factorial
## 
## # factorial(x)
## # lfactorial(x)
## 
## ?sqrt  # raiz cuadrada
## 
## # abs(x)
## # sqrt(x)

#' 
#' #### Podemos graficar una función
#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
plot(x <- seq(0, 2*pi, 0.2), sin(x), type = "l")

#' 
#' #### Puedo usar variables :
#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
precio_anterior = 85.23
precio_actual = 99.0
diferencia = precio_actual - precio_anterior
# La suma y la resta son peligrosas, porque cuando hay involucrados números de diferentes órdenes de magnitud, los dígitos del más pequeño se pierden
# Que % aumento ? (del precio inicial)
diferencia / precio_anterior * 100
((precio_actual / precio_anterior) - 1) * 100

#' #### Lo puedo poner en una funcion : 
#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# esta es la definición de la función
aumento <- function(x, y){
  ((y / x) - 1) * 100
}

# acá llamo a la función y obtengo el resultado
aumento(precio_anterior, precio_actual)

#' 
#' ***
#' ***
#' 
#' ## Vectores
#' #### Los vectores solo pueden contener valores de un mismo tipo. Todos numericos, o todos caracteres, etc.
#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
c(1, 4, 7, 3)

c("a", "23", "abc")

c(TRUE, FALSE, FALSE, TRUE)

#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
vnumeros <- c(1500, 4750, 7300, 3250, 4701, 3302, 5200)

#' 
#' #### Podemos extraer el valor almacenado indicando la posición o índice:
#' #### con [*\[*](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Extract)
#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# el segundo elemento:
vnumeros[2]

# el segundo y el quinto elementos:
vnumeros[c(2,5)]

# del quinto al septimo elementos:
vnumeros[5:7]

vnumeros[TRUE]
#[1] 1500 4750 7300 3250 4701 3302 5200
vnumeros[FALSE]
#numeric(0)
vnumeros[c(TRUE, FALSE)]
#[1] 1500 7300 4701 5200

# que pasa aca? reciclado

#' #### Tambien pordemos extraer los valores que cumplan alguna condición:
#' #### La función [base::*which*](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/which) nos responde qué índices son verdaderos.
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# Al vectorizar, R evalúa la comparación elemento por elemento
# vector booleano con TRUE donde el elemento es mayor que 4000, y FALSE en caso contrario.
vnumeros > 4000

# elementos que cumplen la condición
vnumeros[vnumeros > 4000] 

# índices de los elementos que cumplen la condición
which(vnumeros > 4000)

vnumeros[which(vnumeros > 4000)] 

# índice del menor elemento seguido del índice del segundo valor, y así..
order(vnumeros)

# elementos ordenados
vnumeros[order(vnumeros)]

# elementos ordenados
sort(vnumeros)

#' 
#' 
#' #### Puedo hacer operaciones con los vectores, o pasarlos como argumento de funciones que así lo admitan:
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
precios_enero <- c(100, 600, 20000, 45)
precios_marzo <- c(110, 650, 21000, 45)

# la función *sum(x)* devuelve la suma de los valores almacenados en x
total_enero <- sum(precios_enero)
total_marzo <- sum(precios_marzo)

aumento(total_enero, total_marzo)

precios_marzo - precios_enero

aumento(precios_enero, precios_marzo)

#' 
#' #### Hay disponibles muchas funciones
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
max(precios_enero)
min(precios_enero)
length(precios_enero)
mean(precios_enero)

#' 
#' 
#' ***
#' ***
#' 
#' ### Matrices
#' #### Las matrices, igual que los vectores,  solo pueden contener valores de un mismo tipo. Todos numericos, o todos caracteres, etc.
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
matriz <- matrix(c(18, 8.10, 20, 9, 21,	9.45, 22,	9.90, 23,	10.35), ncol = 2, byrow = TRUE )

matriz

# La columna 1
matriz[,1]

# La fila 3
matriz[3,]

# El elemeneto guardado en la fila 3, columna 1
matriz[3,1]

# Las filas desde la 2 a la 4
matriz[2:4,]

#' 
#' #### Puedo ponerle nombre a las dimensiones de una matriz:
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# https://www.argentina.gob.ar/redsube/tarifas-de-transporte-publico-amba-2021

matriz_colectivo <- matrix(
  filas <- c(18, 8.10, 20, 9, 21,	9.45, 22,	9.90, 23,	10.35),
  nrow = 5, byrow = TRUE,
  dimnames = list(c("0 a 3 km", "3 a 6 km", "6 a 12 km", "12 a 27 km", "más de 27 km"),
                  c("Tarifa"	,"Con tarifa social"))
)

matriz_colectivo

#' 
#' #### Puedo hacer operaciones, por ejemplo multiplicar por un escalar:
#' ##### En este ejemplo estaría calculando un incremento de 40% sobre toda la matriz
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
matriz_colectivo * 1.4

#' 
#' #### Puedo invocar una dimensión, en este caso una columna, por su nombre:
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
matriz_colectivo[,"Tarifa"] * 1.4

#' 
#' ### También podemos multiplicarla por otra matriz, elemento a elemento
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
aumentos <- matrix(c(rep(1.4,5), rep(1,5)), nrow = 5, byrow = FALSE)

aumentos

matriz_colectivo * aumentos

#' 
#' #### Ordenar la matriz según alguna de sus dimensiones
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
decreciente <- order(matriz_colectivo[,1], decreasing = TRUE)
matriz_colectivo[decreciente, ]

#' 
#' ***
#' ***
#' 
#' ### Listas
#' #### Las listas sí pueden almacenar objetos de distintos tipos.
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
l1 <- list(1,2,3,c(4,5,6), "A", c("B","C"), list(c(1,2,3), c("a","b", "c")))
l1
length(l1)
# Así le agrego un elemento a la lista:
l1[[8]] <- c("c", "b", "a")

l1[1]

l1[[1]]

l1[4]

l1[[4]]

l1[[4]][2]

l1[[7]][[2]]

l1[[7]][[2]][1]

lt <- list(t = matriz_colectivo[,1], ts = matriz_colectivo[,2])

sapply(lt, mean)

#' 
#' ***
#' ***
#' 
#' ### Algunos datasets
#' 
#' [Buenos Aires Data - Barrios](https://data.buenosaires.gob.ar/dataset/barrios)
#' 
#' [Buenos Aires Data - Comunas](https://data.buenosaires.gob.ar/dataset/comunas)
#' 
#' #### data.frame
#' 
## ---- echo=TRUE, class.source='klippy'----------------------------------------

# barrios <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/barrios.csv", encoding = "UTF-8")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/barrios.csv", "../datos/barrios.csv")
barrios <- read.csv("../datos/barrios.csv", encoding = "UTF-8")

# poblacion <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv", encoding = "UTF-8")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv", "../datos/caba_pob_barrios_2010.csv")
poblacion <- read.csv("../datos/caba_pob_barrios_2010.csv", encoding = "UTF-8")

# comunas <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", encoding = "UTF-8")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", "../datos/comunas.csv")
comunas <- read.csv("../datos/comunas.csv", encoding = "UTF-8")

names(barrios)

str(barrios)

summary(barrios)

#' 
#' #### Usamos *%>%* y  *select()* del paquete [*dplyr*](https://dplyr.tidyverse.org/)
#' ##### [%>%](https://magrittr.tidyverse.org/reference/pipe.html)
#' ###### **Estaremos usando paquetes que integran *tidyverse* y que se instalan al instalar este último.**
#' ###### **Pero recomiendo ir instalando a medida que los usemos.**
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# install.packages("dplyr")

library(dplyr)

names(barrios)

#' 
#' #### [dplyr::select](https://dplyr.tidyverse.org/reference/select.html)
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
select(barrios, barrio, comuna)

barrios %>% select(barrio, comuna)

barrios %>% select(!WKT)

#' 
#' #### De la librería estándar, podemos usar
#' [*$*](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Extract.html) ó
#' [*\[*](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Extract) para seleccionar columnas
#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------

# head() nos muestra los primeros elementos de un objeto

head(
  barrios$area
)

head(
  barrios[c("barrio", "comuna")]
)

# con el %>% resulta más claro

barrios[c("barrio", "comuna")] %>% head

barrios[c(2,3)] %>% head

barrios[c(-1,-4,-5)] %>% head

#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# names() nos muestra los nombres de columnas (u otros nombres definidos si los hubiera)
names(comunas)

str(comunas)

names(poblacion)

str(poblacion)

comunas %>% select(COMUNAS, BARRIOS)

#' 
#' EAH
## -----------------------------------------------------------------------------
# https://readr.tidyverse.org/
library(readr)

eah2021_ind <- read_csv2("../datos/eah2021_bu_ampliada/eah2021_bu_ampliada_ind.txt")

head(eah2021_ind)
# tiene que coincidir con los 12868 que dice eah2021_bu_ampliada_totales_de_control.xls
nrow(eah2021_ind)
ncol(eah2021_ind)

# https://dplyr.tidyverse.org/
library(dplyr)

# tiene que coincidir con los 3.078.939 que dice eah2021_bu_ampliada_totales_de_control.xls
eah2021_ind %>% count(sexo, wt=fexp) %>% summarise(tot = sum(n))
eah2021_ind %>% count(sexo, wt=fexp) %>% mutate(porc = n / sum(n))

eah2021_ind %>% count(comuna, sexo, wt=fexp)

eah2021_ind$sexo <- factor(eah2021_ind$sexo, c(1,2), c('Varon','Mujer'))

eah2021_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n))

# https://tidyr.tidyverse.org/
# install.packages("tidyr") # also installing the dependencies ‘stringi’, ‘purrr’, ‘stringr’
library(tidyr)
eah2021_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n)) %>%
  pivot_wider(names_from = sexo, values_from = c(n, porc))

library(readxl)
# install.packages("readxl")  # also installing the dependencies ‘rematch’, ‘cellranger’
p01 <- read_excel("../datos/eahcuadros/P01.xlsx", sheet = "2021")

names(p01)

head(p01)

# https://cienciadedatos.github.io/r4ds/20-vectors.html

p01[[1]][3:18]

as.numeric(p01[[3]][3:18])
as.numeric(p01[[4]][3:18])

mp01 <- matrix(c(as.numeric(p01[[3]][3:18]), as.numeric(p01[[4]][3:18])), ncol = 2,
       dimnames = list(p01[[1]][3:18], c("Varon","Mujer")))

str(mp01)

mp01

mp01[12,]
mp01["11",]
mp01[, "Varon"]
mp01["Total",]

marginSums(mp01,1)
cbind(mp01, total = marginSums(mp01,1))


#' 
#' 
#' 
#' ##### Para crear gráficos con *ggplot* hay que instalar el paquete con *install.package()*, por única vez.
#' ##### Luego hay que cargarlo con *library()* la primera vez que lo queremos usar en una sesión.
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# install.packages("ggplot2")
library(ggplot2)

#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
ggplot(barrios) +
  geom_bar(aes(x = barrio, weight = area)) +
             coord_flip()

ggplot(barrios %>% select(barrio, area)) +
  geom_bar(aes(x = reorder(barrio, area), weight = area)) +
  coord_flip()

#' 
#' #### Instalar y usar *sf* puede requerir más trabajo que los otros paquetes que vimos.
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
# install.packages("sf")
library(sf)

#' 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
barrios2 <- st_read("../datos/barrios.csv")

#' 
#' ### Como *comuna* es del tipo *caracter* lo ordena alfabeticamente... 
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
ggplot(barrios2) + 
  geom_sf(aes(fill=comuna))

#' 
#' ### Si lo ponemos *numérico* lo ordena mejor, pero lo mustra como una variable continua, no *categórica* que es lo que corresponde.
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
barrios2$comuna <- as.numeric(barrios2$comuna)

ggplot(barrios2) + 
  geom_sf(aes(fill=comuna))

#' 
#' ### Para estos casos, variables categóricas, lo correcto es usar un tipo de R especial.
#' ### Los *factores*
## ---- echo=TRUE,  class.source='klippy'---------------------------------------
barrios2$comuna <- factor(barrios2$comuna, levels = c("1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14","15"))

ggplot(barrios2) + 
  geom_sf(aes(fill=comuna))

#' 
#' ***
#' ***
#' 
#' ### [Ejercicios](clase01_ejercicios.html)
#' 
#' ***
#' ***
#' ***
#' 
#' ### Bibliografia:
#' #### [Cheat Sheet *dplyr*](https://dplyr.tidyverse.org/index.html#cheat-sheet)
#' 
#' ***
#' 
#' [clase01.R](clase01.R)
#' 
#' ***

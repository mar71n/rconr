#' ---
#' title: "Clase 01"
#' output: html_document
#' #date: '2025-09-19'
#' knit: (function(inputFile, encoding) {
#'   out_dir <- '../docs/apuntes2025';
#'   rmarkdown::render(inputFile,
#'                     encoding="UTF-8",
#'                     output_file=file.path(dirname(inputFile), out_dir, 'clase01.html')); 
#'   knitr::purl("clase01.Rmd", documentation = 2L, output = "../docs/apuntes2025/clase01.R")  })
#' ---
#' 
## ----klippy, echo=FALSE, include=TRUE-----------------------------------------
#klippy::klippy('')

#' 
#' ```
#' Instalación, ayuda, búsquedas:
#' R, CRAN, R-seek, RStudio, install.packages, library
#' Variables y tipos, importar datos:
#' vectores, matrices, factores, list, asignación
#' dataframe, tibles
#' ```
#' 
#' Una versión actualizada de este material en : [clase01](https://mar71n.github.io/rconr/apuntes2025/clase01.html)
#' 
#' ***
#' <div style="background-color: #f2dede !important;">
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
#' - para R4.3:
#' [https://cran.r-project.org/bin/windows/Rtools/rtools43/rtools.html](https://cran.r-project.org/bin/windows/Rtools/rtools43/rtools.html)
#' 
#' - para R4.2:
#' [https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html](https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html)
#' 
#' - para R3.6 o menos :
#' [https://cran.r-project.org/bin/windows/Rtools/history.html](https://cran.r-project.org/bin/windows/Rtools/history.html)
#' 
#' ### Rstudio :
#' - [posit.co](https://posit.co/products/open-source/rstudio/)
#' - [posit.co/downloads](https://posit.co/downloads/)
#' 
#' ##### RStudio se conviertio en **Posit** en Octubre de 2022. [**posit.co**](https://posit.co/)
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
#' - [versión en español de Stack Overflow tag [r]](https://es.stackoverflow.com/questions/tagged/r)
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
#'   - [**readxl**](https://readxl.tidyverse.org/)
#'   - [**lubridate**](https://lubridate.tidyverse.org/)
#'   - [**stringr**](https://stringr.tidyverse.org/)
#' 
#' 
#' ***
#' 
#' #### Con este link se puede crear un R-notebook en Google Drive, que nos vá a servir para seguir la mayoría de los ejemplos que encontramos en la web:
#' #### [colab.to/r](https://colab.to/r)
#' 
#' </div>
#' 
#' ## Variables y tipos, importar algunos datos:
#' 
#' #### Con la función *typeof(x)* vemos el *type* al que pertenece x
#' ##### Ejemplos de los principales tipos en R:
#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
typeof(1.2)

typeof(1L)

typeof("abc")

typeof(TRUE)

typeof(2+1i)


#' 
#' #### Con los tipos numéricos, R es una "calculadora"
#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
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
## ----eval=FALSE---------------------------------------------------------------
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
#' #### Puedo guardar datos y resultados en variables :
#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
numero <- 29
division <- numero %/% 6
resto <- numero %% 6
division * 6 + resto

# Interpolacion lineal

n1 <- 35000
cv1 <- 7.9

n2 <- 30000
cv2 <- 8.5

n <- 32500
cv <- cv1 + (n - n1) / (n2 - n1) * (cv2 - cv1)
cv


#' 
#' ###### [Interpolación lineal](https://es.wikipedia.org/wiki/Interpolaci%C3%B3n_lineal)
#' 
#' 
#' ***
#' ***
#' ## Vectores
#' #### Los vectores solo pueden contener valores de un mismo tipo. Todos numericos, o todos caracteres, etc.
#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
c(1, 4, 7, 3)

c("a", "23", "abc")

c(TRUE, FALSE, FALSE, TRUE)

#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
vnumeros <- c(1500, 4750, 7300, 3250, 4701, 3302, 5200)

#' 
#' #### Podemos extraer el valor almacenado indicando la posición o índice:
#' #### con [*\[*](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Extract)
#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# el segundo elemento:
vnumeros[2]

# el segundo y el quinto elementos:
vnumeros[c(2,5)]

# del quinto al septimo elementos:
vnumeros[5:7]

vnumeros[TRUE]
#[1] 1500 4750 7300 3250 4701 3302 5200
vnumeros[c(FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE)]


#' #### Tambien pordemos extraer los valores que cumplan alguna condición:
#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# Al vectorizar, R evalúa la comparación elemento por elemento
# vector booleano con TRUE donde el elemento es mayor que 4000, y FALSE en caso contrario.
vnumeros > 4000

# elementos que cumplen la condición
vnumeros[vnumeros > 4000] 

#' 
#' #### La función [base::*which*](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/which) nos devuelve un vector con los indices que son verdaderos.
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# índices de los elementos que cumplen la condición
which(vnumeros > 4000)

vnumeros[which(vnumeros > 4000)] 

# índice del menor elemento seguido del índice del segundo valor, y así..
order(vnumeros)

# elementos ordenados
vnumeros[order(vnumeros)]

# elementos ordenados
sort(vnumeros)

vnumeros[c(TRUE, FALSE)]
#[1] 1500 7300 4701 5200

# que pasa aca? reciclado


#' 
#' ##### Del sitio web de la versión en español de “R for Data Science”, de Hadley Wickham y Garrett Grolemund:
#' ###### [Escalares y reglas de reciclado](https://cienciadedatos.github.io/r4ds/20-vectors.html#escalares-y-reglas-de-reciclado)
#' 
#' #### Puedo hacer operaciones con los vectores, o pasarlos como argumento de funciones que así lo admitan:
## ----echo=TRUE,  class.source='klippy'----------------------------------------
precios_enero <- c(100, 600, 20000, 45)
precios_marzo <- c(110, 650, 21000, 45)

# la función *sum(x)* devuelve la suma de los valores almacenados en x
total_enero <- sum(precios_enero)
total_marzo <- sum(precios_marzo)

#' 
#' #### Hay disponibles muchas funciones
## ----echo=TRUE,  class.source='klippy'----------------------------------------
max(precios_enero)
min(precios_enero)
length(precios_enero)
mean(precios_enero)

#' #### Tambien operaciones vectoriales
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# La versión vectorial de la interpolación lineal:
p1 <- c(35000, 7.9)
p2 <- c(30000, 8.5)

(p1 + (p2 - p1)/2)


#' 
#' 
#' ***
#' ***
#' 
#' ### Matrices
#' #### Las matrices, igual que los vectores,  solo pueden contener valores de un mismo tipo. Todos numericos, o todos caracteres, etc.
#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# Puedo tener un vector con todos los valores
# con *ncol = 2* le estoy diciendo que arme dos columnas
# y con *byrow = TRUE* le estoy diciendo que los datos vienen x fila
matriz <- matrix(c(18, 8.10, 20, 9, 21,	9.45, 22,	9.90, 23,	10.35), ncol = 2, byrow = TRUE )

matriz

# La columna 1
matriz[,1]

# La fila 3
matriz[3,]

# El elemeneto guardado en la fila 3, columna 1
matriz[3,1]

# Las filas desde la 2 a la 4
matriz

# o puedo tener , por ejemplo las columnas, y pegarlas
# Tomemos la tabla **eah2021_bu_ampliada_totales_de_control.xls**

# Las columnas son:
comunas <- 1:15
viviendas <- c(448, 371, 381, 479, 331, 333, 357, 454, 311, 255, 289, 296, 329, 381, 307)
hogares <- c(451, 371, 390, 483, 333, 334, 363, 454, 311, 255, 289, 298, 331, 382, 310)
poblacion <- c(1130, 728, 863, 1295, 704, 715, 976, 1403, 874, 609, 713, 702, 687, 739, 730)
viviendasexp <- c(100065, 85751, 89318, 83369, 91698, 94368, 90286, 54011, 63826, 66492, 84745, 93949, 119411, 129172, 87674)
hogaresexp <- c(100565, 85751, 91079, 84384, 92230, 94662, 91544, 54011, 63826, 66492, 84745, 94513, 119893, 129431, 88191)
poblacionexp <- c(257249, 149352, 193467, 240420, 187689, 185655, 242203, 229540, 171452, 170694, 190112, 215014, 236469, 227141, 182482)

# podemos armar dos tablas
# Una con los totales de la base
# con *ncol = 4* le estoy diciendo que arme cuatro columnas
# y con *byrow = FALSE* le estoy diciendo que los datos vienen x columna
totalesbase <- matrix(c(comunas, viviendas, hogares, poblacion), byrow = FALSE, ncol = 4)
totalesbase

# Y otra con los totales expandidos
totalesexp <- matrix(c(comunas, viviendasexp, hogaresexp, poblacionexp), byrow = FALSE, ncol = 4)
totalesexp


#' 
#' #### Puedo ponerle nombre a las dimensiones de una matriz:
## ----echo=TRUE,  class.source='klippy'----------------------------------------
str(totalesexp)

attributes(totalesexp)

# dimnames es una lista de 2 elementos. El primero los nombres de las filas, el segundo de las columnas
attr(totalesexp, "dimnames") <- list(NULL, c("Comuna","Viviendas","Hogares","Poblacion"))

attributes(totalesexp)

totalesexp


#' 
#' 
#' #### Puedo invocar las dimenciones por su nombre:
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# todas las filas de Poblacion
totalesexp[,'Poblacion']

# la fila 10, de Poblacion
totalesexp[10, 'Poblacion']

# Sobre las dimenciones puedo poner condiciones, ordenar, etc
# llamandolas tanto por su numero de orden como por su nombre

## Agrupamiento de comunas contiguas y de características similares. 
## La zona Norte está conformada por las comunas 2, 13 y 14; 
## la zona Centro, por las comunas 1, 3, 5, 6, 7, 11, 12 y 15; 
## la zona Sur, por las comunas 4, 8, 9 y 10

zonanorte <- c(2, 13, 14)

totalesexp[zonanorte, 'Poblacion']

sum(totalesexp[zonanorte, 'Poblacion'])

zonasur <- c(1, 3, 5, 6, 7, 11, 12, 15)

totalesexp[zonasur, 'Poblacion']

sum(totalesexp[zonasur, 'Poblacion'])

totalesexp[totalesexp[,'Poblacion'] < 180000 , 'Poblacion']

totalesexp[totalesexp[,'Poblacion'] < 180000 , c('Comuna', 'Poblacion')]


#' 
#' #### Ordenar la matriz según alguna de sus dimensiones
## ----echo=TRUE,  class.source='klippy'----------------------------------------
totalesexp[ order(totalesexp[,'Poblacion']), ]

totalesexp[ order(totalesexp[,'Poblacion'], decreasing = TRUE), ]

totalesexp[ order(totalesexp[,4], decreasing = TRUE), ][zonasur,]

#' 
#' ***
#' ***
#' 
#' ### Listas
#' #### Las listas sí pueden almacenar objetos de distintos tipos.
## ----echo=TRUE,  class.source='klippy'----------------------------------------
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

lt <- list(tv = totalesexp[,2], tp = totalesexp[,4])

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
## ----echo=TRUE, class.source='klippy'-----------------------------------------

# barrios <- read.csv2("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/barrios/barrios.csv", encoding = "UTF-8", dec = ".")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/barrios/barrios.csv", "../docs/apuntes2025/datos/barrios.csv")
barrios <- read.csv("./datos/barrios.csv", encoding = "UTF-8", dec = ".")


# poblacion <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv", encoding = "UTF-8")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv", "../docs/apuntes2025/datos/caba_pob_barrios_2010.csv")
poblacion <- read.csv("./datos/caba_pob_barrios_2010.csv", encoding = "UTF-8")

# comunas <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", encoding = "UTF-8")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", "../docs/apuntes2025/datos/comunas.csv")
comunas <- read.csv("./datos/comunas.csv", encoding = "UTF-8")

names(barrios)

str(barrios)

summary(barrios)

#' 
#' #### Usamos *%>%* y  *select()* del paquete [*dplyr*](https://dplyr.tidyverse.org/)
#' ##### [%>%](https://magrittr.tidyverse.org/reference/pipe.html)
#' ###### **Estaremos usando paquetes que integran *tidyverse* y que se instalan al instalar este último.**
#' ###### **Pero recomiendo ir instalando a medida que los usemos.**
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# install.packages("dplyr")

library(dplyr)

names(barrios)

#' 
#' #### [dplyr::select](https://dplyr.tidyverse.org/reference/select.html)
## ----echo=TRUE,  class.source='klippy'----------------------------------------
select(barrios, nombre, comuna)

barrios %>% select(nombre, comuna)

barrios %>% select(!geometry)

#' 
#' #### De la librería estándar, podemos usar
#' [*$*](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Extract.html) ó
#' [*\[*](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Extract) para seleccionar columnas
#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------

# head() nos muestra los primeros elementos de un objeto

head(
  barrios$AREA
)

head(
  barrios[c("nombre", "comuna")]
)

# con el %>% resulta más claro

barrios[c("nombre", "comuna")] %>% head

barrios[c(2,3)] %>% head

barrios[c(-1,-2,-7)] %>% head

#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# names() nos muestra los nombres de columnas (u otros nombres definidos si los hubiera)
names(comunas)

str(comunas)

names(poblacion)

str(poblacion)

comunas %>% select(BARRIOS, COMUNAS)

#' 
#' ***
#' ***
#' 
#' <div style="background-color: #f2dede !important;">
#' 
#' ### EAH
#' #### Link de acceso a Base usuarios EAH2021:
#' 
#' [Usuarios EAH2024](https://www.estadisticaciudad.gob.ar/eyc/bases-usuarios/?operativo=114304)
#' 
#' https://www.estadisticaciudad.gob.ar/eyc/wp-content/uploads/2025/07/eah2024_bu_ampliada.zip
#' 
#' Esto me descarga un zip que contiene:
#' 
#' 
#' eah2024_bu_ampliada_calculo_cv.xls  **los CV**
#' 
#' eah2024_bu_ampliada_diseño_de_registros.xls  **diseño de registro hogares e individuales**
#' 
#' eah2024_bu_ampliada_hog.txt   **hogares separado por ";"**
#' 
#' eah2024_bu_ampliada_ind.txt     **individuales separado por ";"**
#' 
#' eah2024_bu_ampliada_totales_de_control.xls    **totales de control**
#' 
#' Notas_sobre_clasificadores_de_rama_de_actividad_economica_y_ocupacion.pdf
#' 
#' t_ocup_2.txt  **codificación de la ocupación**
#' 
#' t_rama_2.txt  **codificación de la rama**
#' 
#' #### Links de acceso a todos los tabulados básicoa EAH2025
#' 
#' [tabulados básicoa EAH2025](https://www.estadisticaciudad.gob.ar/eyc/tabulados-basicos/?operativo=114304)
#' 
#' </div>
#' ***
#' ***
#' <div style="background-color: #f2dede !important;">
#' #### Crear un proyecto.
#' 
#' ###### Del sitio web de la versión en español de “R for Data Science”, de Hadley Wickham y Garrett Grolemund:
#' 
#' [Flujo de trabajo: proyectos](https://cienciadedatos.github.io/r4ds/08-workflow-projects.html)
#' 
#' Para facilitar el seguimiento del curso, creemos un proyecto.
#' En la carpeta del proyect, creamos tres carpetas:
#' fuentes, datos, docs (si luego precisamos más podemos ir agregando)
#' 
#' ![](./figuras/arbolproyecto.png){width='400px'}
#' 
#' 
#' 
#' *fuentes* : aqui pondremos nuestro código R.
#' Se puede descargar esta primera clase en [clase01.R](clase01.R)
#' 
#' ![](./figuras/arbolfuentes.png){width='400px'}
#' 
#' 
#' 
#' *datos*: Aca ponemos los datos que iremos descargando.
#' Entre otros, acá descargamos y descomprimimos **eah2021_bu_ampliada.zip** 
#' 
#' ![](./figuras/arboldatos.png){width='400px'}
#' 
#' </div>
#' ***
#' ***
#' 
#' 
## -----------------------------------------------------------------------------
# https://readr.tidyverse.org/
library(readr)

eah2021_ind <- read_csv2("./datos/eah2024_bu_ampliada/eah2024_bu_ampliada_ind.txt")

head(eah2021_ind)
# tiene que coincidir con los 12868 que dice eah2021_bu_ampliada_totales_de_control.xls
nrow(eah2021_ind)
ncol(eah2021_ind)

# dimnames es una lista de 2 elementos. El primero los nombres de las filas, el segundo de las columnas
attr(totalesbase, "dimnames") <- list(NULL, c("Comuna","Viviendas","Hogares","Poblacion"))

sum(totalesbase[,'Poblacion'])

# https://dplyr.tidyverse.org/
library(dplyr)

#' 
#' ![](./figuras/cuadro01.png){width='400px'}
#' 
#' 
## -----------------------------------------------------------------------------
# tiene que coincidir con los 3.078.939 que dice eah2021_bu_ampliada_totales_de_control.xls
eah2021_ind %>% count(sexo, wt=fexp) %>% summarise(tot = sum(n))

sum(totalesexp[,'Poblacion'])

eah2021_ind %>% count(sexo, wt=fexp) %>% mutate(porc = n / sum(n))

eah2021_ind %>% count(comuna, sexo, wt=fexp)

eah2021_ind$sexo <- factor(eah2021_ind$sexo, c(1,2), c('Varon','Mujer'))

eah2021_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n))

# https://tidyr.tidyverse.org/
# install.packages("tidyr") # also installing the dependencies ‘stringi’, ‘purrr’, ‘stringr’
library(tidyr)
eah2021_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n)) %>%
  pivot_wider(names_from = sexo, values_from = c(n, porc))

#' 
#' ***
#' 
## -----------------------------------------------------------------------------
library(readxl)
# install.packages("readxl")  # also installing the dependencies ‘rematch’, ‘cellranger’
p01 <- read_excel("./datos/eahcuadros/P01.xlsx", sheet = "2024")

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
cbind(total = marginSums(mp01,1), mp01)


#' 
#' 
#' 
#' ##### Para crear gráficos con *ggplot* hay que instalar el paquete con *install.package()*, por única vez.
#' ##### Luego hay que cargarlo con *library()* la primera vez que lo queremos usar en una sesión.
## ----echo=TRUE,  class.source='klippy'----------------------------------------
# install.packages("ggplot2")
library(ggplot2)

#' 
## ----echo=TRUE,  class.source='klippy'----------------------------------------
ggplot(eah2021_ind, aes(sexo)) +
  geom_bar()

ggplot(eah2021_ind %>% count(sexo, wt = fexp), aes(sexo, n)) +
  geom_bar(stat="identity")

ggplot(eah2021_ind %>% count(sexo, wt = fexp), aes(sexo, n, fill=sexo)) +
  geom_bar(stat="identity")

xcomuna_totsexo <- eah2021_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp)

xcomuna_totsexo

ggplot(xcomuna_totsexo, aes(comuna, n, fill=sexo)) + 
  geom_bar(stat="identity", colour = "grey")

ggplot(xcomuna_totsexo, aes(comuna, n, fill=sexo)) + 
  geom_bar(stat="identity", position = "fill", colour = "grey")


#' 
#' 
#' 
#' 
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
#' #### [Ciencia de Datos y Políticas Públicas](https://datosgcba.github.io/ciencia-de-datos-politicas-publicas/docs/)
#' #### [Ciencia de Datos para Gente Sociable](https://bitsandbricks.github.io/ciencia_de_datos_gente_sociable/)
#' #### [Introducción a R para Ciencias Sociales. Aplicación practica en la EPH](https://diegokoz.github.io/R_EPH_bookdown/index.html)
#' #### [R Para Ciencia de Datos](https://cienciadedatos.github.io/r4ds/)
#' 
#' 
#' ***
#' 
#' [clase01.R](clase01.R)
#' 
#' ***

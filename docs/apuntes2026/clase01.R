#' ---
#' title: "Clase 01"
#' output: html_document
#' #date: '2026-09-01'
#' knit: (function(inputFile, encoding) {
#'   out_dir <- '../docs/apuntes2026';
#'   rmarkdown::render(inputFile,
#'                     encoding="UTF-8",
#'                     output_file=file.path(dirname(inputFile), out_dir, 'clase01.html')); 
#'   knitr::purl("clase01.Rmd", documentation = 2L, output = "../docs/apuntes2026/clase01.R")  })
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
#' Una versión actualizada de este material en : [clase01](https://mar71n.github.io/rconr/apuntes2026/clase01.html)
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
#' [https://cran.r-project.org/bin/windows/Rtools/](https://cran.r-project.org/bin/windows/Rtools/)
#' 
#' ***
#' 
#' ### Rstudio :
#' - [posit.co](https://posit.co/products/open-source/rstudio/)
#' - [posit.co/downloads](https://posit.co/downloads/)
#' 
#' ##### RStudio se conviertio en **Posit** en Octubre de 2022. [**posit.co**](https://posit.co/)
#' 
#' ##### Posit Cloud. Rstudio en el navegador. Sín instalaciones.
#' - [posit.co/products/enterprise/cloud](https://posit.co/products/enterprise/cloud)
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
#' #### Crear un R-notebook en Google Drive, que nos vá a servir para seguir la mayoría de los ejemplos que encontramos en la web:
#' #### [colab.research.google.com](https://colab.research.google.com)
#' ##### Y seleccionar:
#' - *Nuevo*
#'   - *Entorno de ejecución*
#'     - *Cambiar tipo de entorno de ejecución*
#'       - y en *Tipo de entorno de ejecución* seleccionamos **R**
#' 
#' ***
#' 
#' </div>
#' 
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
#' 
#' <div style="background-color: #f2dede !important;">
#' ### Algunos datasets
#' 
#' [Buenos Aires Data - Barrios](https://data.buenosaires.gob.ar/dataset/barrios)
#' 
#' [Buenos Aires Data - Comunas](https://data.buenosaires.gob.ar/dataset/comunas)
#' 
#' #### data.frame
#' 
## ----echo=TRUE, class.source='klippy'-----------------------------------------

# barrios <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/barrios/barrios.csv", encoding = "UTF-8", dec = ".")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/barrios/barrios.csv", "../docs/apuntes2026/datos/barrios.csv")
barrios <- read.csv("./datos/barrios.csv", encoding = "UTF-8", dec = ".")


# poblacion <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv", encoding = "UTF-8")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv", "../docs/apuntes2026/datos/caba_pob_barrios_2010.csv")
poblacion <- read.csv("./datos/caba_pob_barrios_2010.csv", encoding = "UTF-8")

# comunas <- read.csv("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", encoding = "UTF-8")
# download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", "../docs/apuntes2025/datos/comunas.csv")
comunas <- read.csv("./datos/comunas.csv", encoding = "UTF-8")

names(barrios)

str(barrios)

summary(barrios)

#' 
#' </div>
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
  barrios$area_metro
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
#' #### Link de acceso a Base usuarios EAH202:
#' 
#' [Usuarios EAH2025](https://www.estadisticaciudad.gob.ar/eyc/bases-usuarios/?operativo=114304)
#' 
#' https://www.estadisticaciudad.gob.ar/eyc/wp-content/uploads/2026/04/eah2025_bu_ampliada.zip
#' 
#' Esto me descarga un archivo comprimido que contiene:
#' 
#' eah2025_bu_ampliada_calculo_cv.xls  **los CV**
#' 
#' eah2025_bu_ampliada_diseño_de_registros.xls  **diseño de registro hogares e individuales**
#' 
#' eah2025_bu_ampliada_hog.txt   **hogares separado por ";"**
#' 
#' eah2025_bu_ampliada_ind.txt     **individuales separado por ";"**
#' 
#' eah2025_bu_ampliada_totales_de_control.xls    **totales de control**
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
#' Entre otros, acá descargamos y descomprimimos **eah2025_bu_ampliada.zip** 
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

eah2025_ind <- read_csv2("./datos/eah2025_bu_ampliada/eah2025_bu_ampliada_ind.txt")

head(eah2025_ind)
# tiene que coincidir con los 12868 que dice eah2021_bu_ampliada_totales_de_control.xls
nrow(eah2025_ind)
ncol(eah2025_ind)

# https://dplyr.tidyverse.org/
library(dplyr)

#' 
#' ![](./figuras/cuadro01.png){width='400px'}
#' 
#' 
## -----------------------------------------------------------------------------
# tiene que coincidir con los 3.078.939 que dice eah2021_bu_ampliada_totales_de_control.xls
eah2025_ind %>% count(sexo, wt=fexp) %>% summarise(tot = sum(n))

eah2025_ind %>% count(sexo, wt=fexp) %>% mutate(porc = n / sum(n))

eah2025_ind %>% count(comuna, sexo, wt=fexp)

eah2025_ind$sexo <- factor(eah2025_ind$sexo, c(1,2), c('Varon','Mujer'))

eah2025_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n))

# https://tidyr.tidyverse.org/
# install.packages("tidyr") # also installing the dependencies ‘stringi’, ‘purrr’, ‘stringr’
library(tidyr)
eah2025_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n)) %>%
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
ggplot(eah2025_ind, aes(sexo)) +
  geom_bar()

ggplot(eah2025_ind %>% count(sexo, wt = fexp), aes(sexo, n)) +
  geom_bar(stat="identity")

ggplot(eah2025_ind %>% count(sexo, wt = fexp), aes(sexo, n, fill=sexo)) +
  geom_bar(stat="identity")

xcomuna_totsexo <- eah2025_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp)

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

#' ---
#' title: "Clase 01 - Repaso"
#' output: html_document
#' #date: '2026-10-06'
#' knit: (function(inputFile, encoding) {
#'   out_dir <- '../docs/apuntes2026';
#'   rmarkdown::render(inputFile,
#'                     encoding="UTF-8",
#'                     output_file=file.path(dirname(inputFile), out_dir, 'clase01_repaso.html'));
#'   knitr::purl("clase01_repaso.Rmd", documentation = 2L, output = "../docs/apuntes2026/clase01_repaso.R")  })
#' ---
#' 
#' 
#' ## Repaso del primer encuentro.
#' 
#' ***
#' ***
#' 
#' ### 1. Librería estándar (Base R)
#' 
#' #### Estos paquetes vienen incluidos con la instalación de R.
#' 
#' #### INSTALACIÓN: No es necesario hacer esto.
## ----eval=FALSE---------------------------------------------------------------
## install.packages("base")

#' 
#' #### CARGA: Algunos se cargan automáticamente al abrir R (base, stats, utils, datasets).
#' #### Puedes usar sus funciones directamente sin llamar a library().
## ----eval=FALSE---------------------------------------------------------------
## mean(c(1, 2, 3)) # Función del paquete 'base' / 'stats'

#' 
#' ***
#' 
#' ### 2. Ecosistema Tidyverse (Paquetes externos)
#' 
#' #### Conjunto de paquetes para ciencia de datos (como dplyr, readr, readxl).
#' 
#' #### INSTALACIÓN: Se ejecuta una sola vez en tu consola.
## ----eval=FALSE---------------------------------------------------------------
## # install.packages("tidyverse")
## install.packages("dplyr")
## install.packages("readr")
## install.packages("readxl")
## install.packages("lubridate")

#' 
#' #### CARGA: Se debe incluir en tu script .R y ejecuta antes de intentar usar las funciones de cada paquete.
## ----eval=FALSE---------------------------------------------------------------
## library(dplyr)

#' 
#' #### Con esto puedes usar funciones como *filter(), mutate()* (de dplyr)
## ----eval=FALSE---------------------------------------------------------------
## library(readr)

#' #### Con esto puedes usar funciones como *read_csv()* (de readr).
#' 
#' ***
#' 
#' #### El pipe **%>%**: Pertenece al paquete magrittr. Se carga automáticamente cuando ejecutas *library(tidyverse)* o *library(dplyr)* (ya que dplyr lo incluye/importa).
#' 
#' #### El pipe nativo **|>**: No pertenece a ninguna librería externa. Es el pipe nativo de R introducido a partir de la versión 4.1.0. Forma parte de base R, por lo que viene incluido desde la instalaxión y no requiere cargar ningún paquete para usarse.
#' 
#' ***
#' ***
#' 
#' ### 3. Datasets Barrios, Comunas
#' 
#' #### **download.file()** pertenece al paquete utils, que forma parte de la librería estándar (Base R).
#' #### No es necesarios *instalar* ni *cargar*.
#' #### Si ya tenemos los archivos *barrios.csv* y *comunas.csv* (por ejemplo en Rstudio local en nuestra máquina o en Rstudio en la nube) tampoco hace falta volver a ejecutar esta descarga.
#' #### En una R-notebook de Colab sí tenemos que descargarlos cada vez que cerremos la sesión.
#' 
## ----eval=FALSE---------------------------------------------------------------
## download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/barrios/barrios.csv", "barrios.csv")
## 
## 
## download.file("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/comunas/comunas.csv", "comunas.csv")

#' 
#' #### Cargamos  *readr* para usar las funciones *read\_\**
#' 
## ----eval=FALSE---------------------------------------------------------------
## library(readr)
## 
## barrios <- read_csv("barrios.csv")
## 
## comunas <- read_csv("comunas.csv")

#' 
#' #### Cargamos *dplyr* par apoder usar *%>>%*, *select()*, *filter()* y *arrange()*
#' 
## ----eval=FALSE---------------------------------------------------------------
## library(dplyr)
## barrios %>%
##   select(id, nombre, comuna, area_metro) %>%
##   filter(comuna == 1) %>%
##   arrange(area_metro)

#' 
#' ***
#' 
#' ### 4. Sobre los paquetes y librerias.
#' 
#' #### Si cuando cargamos una libreria:
## ----eval=FALSE---------------------------------------------------------------
## library(dplyr)

#' #### La consola nos muestra un error:
#' ```
#' Error en library(dplyr): no hay paquete llamado ‘dplyr’
#' ```
#' #### Es porque nos falta **instalar** el paquete:
## ----eval=FALSE---------------------------------------------------------------
## installed.packages("dplyr")

#' 
#' ***
#' 
#' #### Recomendación: 
#' ##### Notemos que al cargar la libreria **tidyverse**, esta carga las 9 librerias principales de ese ecosistema.
#' 
## ----eval=FALSE---------------------------------------------------------------
## > library(tidyverse)
## ── Attaching core tidyverse packages ──────────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
## ✔ purrr     1.0.2
## ── Conflicts ────────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package to force all conflicts to become errors

#' 
#' ##### Si instalamos **tidyverse**, se van a instalar los elementos principales: 
#' ##### *dplyr, readr, forcats, stringr, ggplot2, tibble, lubridate, tidyr, purrr*
#' ##### La instalación vá a tardar más, vá a ocupar más espacio, y si alguno falla, falla todo.
#' ##### En general, siempre instalar solo lo que precisamos.
#' ##### Mejor que 
## ----eval=FALSE---------------------------------------------------------------
## install.packages("tidyverse")

#' ##### Instalar solo lo que vamos a usar:
## ----eval=FALSE---------------------------------------------------------------
## install.packages("dplyr") # si vamos a usar %>%, filter, arrange, etc
## install.packages("dplyr") # si vamo sa usar read_csv, etc
## # y así con cada una

#' 
#' ##### Cuando el error dice
#' ```
#' ... no hay un paquete llamado "plinplinplin"
#' ```
#' ##### Es que nos falta un *install.packages*
#' 
#' ##### Cuando el error dice
#' ```
#' ... no pude encontrar la función "planplanplan"
#' ```
#' ##### Es que nos falta un *library()* del paquete que la contiene.
#' 
#' ***

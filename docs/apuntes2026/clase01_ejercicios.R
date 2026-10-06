#' ---
#' title: "Clase 01 - Ejercicios"
#' output: html_document
#' #date: '2026-10-05'
#' knit: (function(inputFile, encoding) {
#'   out_dir <- '../docs/apuntes2026';
#'   rmarkdown::render(inputFile,
#'                     encoding="UTF-8",
#'                     output_file=file.path(dirname(inputFile), out_dir, 'clase01_ejercicios.html'));
#'   knitr::purl("clase01_ejercicios.Rmd", documentation = 2L, output = "../docs/apuntes2026/clase01_ejercicios.R")  })
#' ---
#' 
#' ### Cuadro 01
#' ```
#' tabla_comuna_sexo <- tibble::tribble(
#'   ~Comuna, ~Total, ~Varón, ~Mujer,
#'         1,    100,   50.4,   49.6,
#'         2,    100,   44.6,   55.4,
#'         3,    100,   47.4,   52.6,
#'         4,    100,   48.2,   51.8,
#'         5,    100,   46.2,   53.8,
#'         6,    100,   45.9,   54.1,
#'         7,    100,   47.4,   52.6,
#'         8,    100,   48.4,   51.6,
#'         9,    100,   48.6,   51.4,
#'        10,    100,   47.0,   53.0,
#'        11,    100,   47.3,   52.7,
#'        12,    100,   47.0,   53.0,
#'        13,    100,   45.8,   54.2,
#'        14,    100,   45.3,   54.7,
#'        15,    100,   46.8,   53.2
#' )
#' ```
#' 
#' ### Cuadro 01 con población
#' ```
#' tabla_comuna_sexo_poblacion <- tibble::tribble(
#' ~Comuna, ~n_Varón, ~n_Mujer, ~Varón, ~Mujer, ~Total,
#'    1,     130749,  128483,  50.4,  49.6,   100,
#'    2,      66575,   82823,  44.6,  55.4,   100,
#'    3,      91919,  101990,  47.4,  52.6,   100,
#'    4,     116192,  124992,  48.2,  51.8,   100,
#'    5,      86891,  101156,  46.2,  53.8,   100,
#'    6,      85401,  100604,  45.9,  54.1,   100,
#'    7,     115108,  127785,  47.4,  52.6,   100,
#'    8,     111773,  119002,  48.4,  51.6,   100,
#'    9,      83550,   88367,  48.6,  51.4,   100,
#'   10,      80406,   90508,  47.0,  53.0,   100,
#'   11,      89873,  100326,  47.3,  52.7,   100,
#'   12,     101227,  114289,  47.0,  53.0,   100,
#'   13,     108430,  128363,  45.8,  54.2,   100,
#'   14,     103012,  124338,  45.3,  54.7,   100,
#'   15,      85498,   97084,  46.8,  53.2,   100
#' )
#' ```
#' 
#' 
#' Totales:
#' 
#' 1) del cuadro 01 con población. ¿ Cual es el total de población de la comuna 4?
#' 
#' 2) del cuadro 01 con población. ¿ cual es la comuna con mayor diferencia entr eel número de mujeres y el número de varones?
#' 
#' Gráficos:
#' 
#' 1) Usando los resultados del cuadro 1 hagamos algunos gráficos:
#' 
#' 2) Con datos de población, también hagamos algunos gráficos:

library(dplyr)

tabla_comuna_sexo_poblacion <- tibble::tribble(
  ~Comuna, ~n_Varón, ~n_Mujer, ~Varón, ~Mujer, ~Total,
  1,     130749,  128483,  50.4,  49.6,   100,
  2,      66575,   82823,  44.6,  55.4,   100,
  3,      91919,  101990,  47.4,  52.6,   100,
  4,     116192,  124992,  48.2,  51.8,   100,
  5,      86891,  101156,  46.2,  53.8,   100,
  6,      85401,  100604,  45.9,  54.1,   100,
  7,     115108,  127785,  47.4,  52.6,   100,
  8,     111773,  119002,  48.4,  51.6,   100,
  9,      83550,   88367,  48.6,  51.4,   100,
  10,      80406,   90508,  47.0,  53.0,   100,
  11,      89873,  100326,  47.3,  52.7,   100,
  12,     101227,  114289,  47.0,  53.0,   100,
  13,     108430,  128363,  45.8,  54.2,   100,
  14,     103012,  124338,  45.3,  54.7,   100,
  15,      85498,   97084,  46.8,  53.2,   100
)

# ¿ Cual es el total de población de la comuna 4?
tabla_comuna_sexo_poblacion %>% filter(Comuna == 4) %>% 
  mutate(poblacion = n_Varón + n_Mujer) %>% select(poblacion) %>% pull(poblacion)

tabla_comuna_sexo_poblacion %>% 
  filter(Comuna == 4) %>% 
  summarise(Comuna, poblacion_total = n_Varón + n_Mujer) %>% pull(poblacion_total)


tabla_comuna_sexo_poblacion %>% 
  mutate(diferencia = abs(n_Mujer - n_Varón)) %>%
  arrange(diferencia)

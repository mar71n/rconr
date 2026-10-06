library(dplyr)
library(readr)
#install.packages("gt")
library(gt)

# para este cuadro
# Distribución porcentual de la población por sexo según comuna.
# uso los individuales
eah2025_ind <- read_csv2( "./datos/eah2025_bu_ampliada/eah2025_bu_ampliada_ind.txt")

# Transformar sexo a factor con etiquetas
eah2025_ind <- eah2025_ind %>%
  mutate(
    sexo = factor(sexo, 
                  levels = c(1, 2), 
                  labels = c("Varón", "Mujer"))
  )

tabla_totales_ciudad <- eah2025_ind %>% count( sexo, wt=fexp) %>% mutate(porc = 100 * n / sum(n)) %>%
  pivot_wider(names_from = sexo, values_from = c(n, porc)) %>%
  rename(
    Varón = porc_Varón,
    Mujer = porc_Mujer
  ) %>%
  mutate(
    Total = Varón + Mujer,
    Comuna = "Todas"
  ) %>% select(Comuna, Total, Varón, Mujer)

tabla_sexo_por_comuna <- eah2025_ind %>% group_by(comuna) %>%  
  count( sexo, wt=fexp) %>% 
  mutate(porc = 100 * n / sum(n)) %>%
  pivot_wider(names_from = sexo, values_from = c(n, porc)) %>%
  rename(
    Comuna = comuna,
    Varón = porc_Varón,
    Mujer = porc_Mujer
  ) %>%
  mutate(
    Total = Varón + Mujer,
    Comuna = as.character(Comuna)
  ) %>%
  select(Comuna, Total, Varón, Mujer) %>% tibble()

tabla_comuna_total <- rbind(tabla_sexo_por_comuna, tabla_totales_ciudad)

tabla_comuna_total %>% gt() %>%
  tab_header(
    title    = "Distribución por sexo según comuna",
    subtitle = "EAH 2025 – personas (fexp)"
  ) %>%
  cols_label(
    Comuna = "Comuna",
    Total  = "Total (%)",
    Varón  = "Varones (%)",
    Mujer  = "Mujeres (%)"
  ) %>%
  fmt_number(
    columns  = c(Total, Varón, Mujer),
    decimals = 1
  ) %>%
  cols_align(align = "center", columns = -Comuna) %>%
  tab_footnote(
    footnote  = "Porcentajes calculados con factor de expansión (fexp).",
    locations = cells_title()
  ) %>%
  tab_style(
    style = list(cell_fill(color = "#f0f0f0"), cell_text(weight = "bold")),
    locations = cells_body(rows = Comuna == "Todas")
  )

library(readr)
library(dplyr)
library(tidyr)
library(forcats)

# Cuadro 1 : P01.xlsx
titulo <- "Distribución porcentual de la población por sexo según comuna. Ciudad de Buenos Aires. Año 2021"

# #############################################################
# Cargar individuales

eah2021_ind <- read_csv2("./datos/eah2021_bu_ampliada/eah2021_bu_ampliada_ind.txt")

# sexo a factor
eah2021_ind$sexo <- factor(eah2021_ind$sexo, c(1,2), c('Varon','Mujer'))

# sexo por comuna
mp01r <- eah2021_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n)) %>%
  pivot_wider(names_from = sexo, values_from = c(n, porc)) %>% ungroup()

# fila de totales
totales <- mp01r %>% ungroup() %>% summarise(comuna = "Total", n_Varon = sum(n_Varon), n_Mujer = sum(n_Mujer),  
                                             porc_Varon = n_Varon/(n_Varon + n_Mujer), porc_Mujer = n_Mujer / (n_Varon + n_Mujer))

# Transformo comuna en factor para agregar "Totales"
# Y defino los niveles com : "Total", "1", "2", ..., "15" para que ordene "Total primero"
mp01r <- mp01r %>% mutate(comuna = as.factor(comuna)) %>% 
  add_row(totales) %>% 
  mutate(comuna = fct_relevel(comuna, "Total", as.character(1:15)))

# ordeno por comuna ("Total", "1", "2", ... , "15")
# redondeo los porcentajes a 1 decimal
# selecciono las columnas que muestro
mp01r <- mp01r %>% arrange(comuna) %>% 
  mutate(Total = porc_Varon + porc_Mujer) %>% 
  mutate(Comuna = comuna, Total = round(Total*100, 1), 
         Varon = round(porc_Varon * 100,1), Mujer = round(porc_Mujer * 100,1)) %>%
  select(Comuna, Total, Varon, Mujer)

# ###############################################################
# Cuadros

# con GT  ####################################
library(gt)

cuadro01 <- gt(mp01r) %>% 
  tab_spanner(
    label = "Sexo",
    columns = c(Varon, Mujer)
  ) %>%
  tab_style(
    style = list(
      cell_text(v_align = "middle", weight = "bold")
    ),
    locations = list(cells_column_labels(everything()), cells_column_spanners(everything()) )
  )

# install.packages("webshot2")
gtsave(cuadro01, "cuadro01_gt.html", path = "resultados")

# con kableExtra #############################
library(kableExtra)

cuadro01kbl <- kbl(mp01r) %>%
  kable_paper("striped", full_width = F) %>%
  add_header_above(c(" " = 2, "Sexo" = 2)) %>%
  row_spec(1, bold = T)


save_kable(cuadro01kbl, file = "resultados/cuadro01_kbl.html")


library(dplyr)
library(readr)
library(readxl)
library(tidyr)

# Cuadro 1 : P01.xlsx
titulo <- "Distribución porcentual de la población por sexo según comuna. Ciudad de Buenos Aires. Año 2021"

# #############################################################
# Cargar individuales y controlar totales
eah2021_ind <- read_csv2("datos/eah2021_bu_ampliada/eah2021_bu_ampliada_ind.txt")
totales <- read_csv2("datos/totales-control.csv")

typeof(eah2021_ind)
class(eah2021_ind)

# #############################################################
# Cargar cuadro actual
p01 <- read_excel("datos/eahcuadros/P01.xlsx", sheet = "2021")

names(p01)

head(p01)

# https://cienciadedatos.github.io/r4ds/20-vectors.html

p01[[1]][3:18]

as.numeric(p01[[3]][3:18])
as.numeric(p01[[4]][3:18])

mp01 <- matrix(c(0:15, as.numeric(p01[[3]][3:18]), as.numeric(p01[[4]][3:18])), ncol = 3,
               dimnames = list(NULL, c("Comuna","Varon","Mujer")))

head(mp01)

marginSums(mp01[,c("Varon", "Mujer")],1)
mp01 <- cbind(Comuna = mp01[,1], Total = marginSums(mp01[,c("Varon", "Mujer")],1), mp01[,2:3])

class(mp01)
typeof(mp01)

mp01 <- tbl_df(mp01)

mp01$Comuna[1] <- "Total"
mp01

# #############################################################
eah2021_ind %>% count(sexo, wt=fexp) %>% mutate(porc = n / sum(n))

eah2021_ind %>% count(comuna, sexo, wt=fexp)

eah2021_ind$sexo <- factor(eah2021_ind$sexo, c(1,2), c('Varon','Mujer'))

eah2021_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n))

rm(mp01r)
mp01r <- eah2021_ind %>% group_by(comuna) %>%  count( sexo, wt=fexp) %>% mutate(porc = n / sum(n)) %>%
  pivot_wider(names_from = sexo, values_from = c(n, porc)) %>% ungroup()

mp01r

totales <- mp01r %>% ungroup() %>% summarise(comuna = "Total", n_Varon = sum(n_Varon), n_Mujer = sum(n_Mujer),  
                                  porc_Varon = n_Varon/(n_Varon + n_Mujer), porc_Mujer = n_Mujer / (n_Varon + n_Mujer))

totales

library(forcats)
mp01r <- mp01r %>% mutate(comuna = as.factor(comuna)) %>% 
  add_row(totales) %>% 
  mutate(comuna = fct_relevel(comuna, "Total", as.character(1:15)))

mp01r

mp01r <- mp01r %>% arrange(comuna) %>% 
  mutate(Total = porc_Varon + porc_Mujer) %>% 
  mutate(Comuna = comuna, Total = round(Total*100, 1), 
         Varon = round(porc_Varon * 100,1), Mujer = round(porc_Mujer * 100,1)) %>%
  select(Comuna, Total, Varon, Mujer)

mp01r


library(gt)

gt(mp01r)

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

cuadro01

# install.packages("webshot2")
gtsave(cuadro01, "cuadro01.html", path = "resultados")

library(writexl)
write_excel_csv2(mp01r, "resultados/cuadro01.csv")
write_xlsx(mp01r, "resultados/cuadro01.xls")


library(kableExtra)
cuadro01kbl <- kbl(mp01r) %>%
  kable_paper("striped", full_width = F) %>%
  add_header_above(c(" " = 2, "Sexo" = 2)) %>%
  row_spec(1, bold = T)

cuadro01kbl
  
save_kable(cuadro01kbl, file = "resultados/cuaro01kbl.html")

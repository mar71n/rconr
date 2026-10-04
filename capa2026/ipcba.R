library(dplyr)
library(readxl)

download.file("https://www.estadisticaciudad.gob.ar/eyc/wp-content/uploads/2026/07/IPCBA_base_2021100-Evol_gral_estac_reg_resto.xlsx", 
              destfile = "./datos/ipcba-base-2021100.xlsx")

nombres <- c('Fecha', 'Nivel_General_I', 'Estacionales_I', 'Regulados_I',
             'Resto_IPCBA_I', 'Nivel_General_P', 'Estacionales_P', 'Regulados_P',
             'Resto_IPCBA_P')
ipcbadata <- read_xlsx("./datos/ipcba-base-2021100.xlsx", range = "A6:I59", col_names = nombres)
tail(ipcbadata, 12)

# Para comentar / descomentar lineas
# Windows / Linux: Ctrl + Shift + C
# macOS: Cmd + Shift + C
# new_record <- data.frame(
#     Fecha = as.Date("2026-06-01"),
#     Nivel_General_I = 2480.63,
#     Estacionales_I = 1607.92,
#     Regulados_I = 2999.94,
#     Resto_IPCBA_I = 2469.99,
#     Nivel_General_P = 1.8,
#     Estacionales_P = 0.1,
#     Regulados_P = 2.0,
#     Resto_IPCBA_P = 1.9,
#     Niv_Gen_P = NA,
#     Niv_Gen12 = NA
#   )
# 
# ipcbadata <- rbind(ipcbadata, new_record)
# 
# # Display the tail of the updated dataframe to confirm
# tail(ipcbadata)

# library(lubridate)
# 
# data_for_plot <- ipcbadata %>%
#   mutate(indice_interanual = lag(Nivel_General_I, 12)) %>%
#   mutate(indice_mensual = lag(Nivel_General_I, 1)) %>%
#   #filter(lubridate::year(Fecha) == 2025) %>%
#   tail( 12) %>% # ultimos 12 meses
#   arrange(Fecha) %>% # ordeno por fecha
#   mutate( ng0 = .$indice_mensual[1] ) %>%
#   mutate(
#     Mes_Nombre = format(Fecha, "%Y-%m") %>%
#       forcats::fct_reorder(Fecha),
#     Nivel_General_P_Acumulado_Compuesto = (Nivel_General_I - ng0) / ng0  #cumprod(1 + Nivel_General_P / 100) - 1
#   ) %>%
#   mutate(Acumulado = Nivel_General_P_Acumulado_Compuesto * 100)
# 
# #head(data_for_plot$Mes_Nombre)
# tail(data_for_plot, 12)



##############################################################
# Preparación previa de los datos (Últimos 12 meses)

library(ggplot2)
library(scales)

# 1. Preparación de datos y formato de fecha a texto/factor
datos_12m <- ipcbadata %>%
  arrange(Fecha) %>%
  tail(13) %>%
  mutate(
    Var_Mensual = (Nivel_General_I / lag(Nivel_General_I) - 1) * 100,
    Acumulado = (Nivel_General_I / first(Nivel_General_I) - 1) * 100
  ) %>%
  filter(!is.na(Var_Mensual)) %>%
  mutate(
    # Convertimos a factor ordenado por fecha real para congelar el orden en el eje X
    Mes_Etiqueta = factor(format(Fecha, "%b %Y"), levels = format(Fecha, "%b %Y"))
  )


# A) Gráfico de barras: Variación Porcentual Mensual
ggplot(datos_12m, aes(x = Mes_Etiqueta, y = Var_Mensual)) +
  geom_col(fill = "#2b5c8f", width = 0.55, alpha = 0.9) +
  geom_text(
    aes(label = sprintf("%.1f%%", Var_Mensual)), 
    vjust = -0.5, 
    size = 3.2
  ) +
  scale_y_continuous(
    labels = label_number(suffix = "%"),
    expand = expansion(mult = c(0, 0.15)) # Espacio superior para etiquetas
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(
    title = "Variación Porcentual Mensual (Últimos 12 meses)",
    x = NULL,
    y = "Variación %"
  )


# B) Gráfico de línea: Inflación Acumulada
ggplot(datos_12m, aes(x = Mes_Etiqueta, y = Acumulado, group = 1)) +
  geom_line(color = "#d95f02", linewidth = 1) +
  geom_point(color = "#d95f02", size = 2.5) +
  geom_text(
    aes(label = sprintf("%.1f%%", Acumulado)), 
    vjust = -0.8, 
    size = 3.2,
    color = "#d95f02"
  ) +
  scale_y_continuous(
    labels = label_number(suffix = "%"),
    expand = expansion(mult = c(0, 0.15))
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(
    title = "Inflación Acumulada (Últimos 12 meses)",
    x = NULL,
    y = "Acumulado %"
  )

# C)
ggplot(datos_12m, aes(x = Mes_Etiqueta, group = 1)) +
  # Barras: Variación mensual
  geom_col(aes(y = Var_Mensual, fill = "Mensual"), width = 0.5, alpha = 0.85) +
  geom_text(
    aes(y = Var_Mensual, label = sprintf("%.1f%%", Var_Mensual)), 
    vjust = -0.5, 
    size = 3, 
    color = "#1b3b5a"
  ) +
  # Línea y puntos: Inflación acumulada (group = 1 permite conectar los puntos de un eje discreto)
  geom_line(aes(y = Acumulado, color = "Acumulada"), linewidth = 1) +
  geom_point(aes(y = Acumulado, color = "Acumulada"), size = 2.5) +
  geom_text(
    aes(y = Acumulado, label = sprintf("%.1f%%", Acumulado)), 
    vjust = -1.8, 
    size = 3, 
    color = "#d95f02"
  ) +
  # Escalas e identificación
  scale_y_continuous(
    labels = label_number(suffix = "%"),
    expand = expansion(mult = c(0, 0.15))
  ) +
  scale_fill_manual(name = "", values = c("Mensual" = "#8cb2d9")) +
  scale_color_manual(name = "", values = c("Acumulada" = "#d95f02")) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "top"
  ) +
  labs(
    title = "IPCBA: Variación Mensual vs. Inflación Acumulada",
    subtitle = "Últimos 12 meses calculados desde el Nivel General",
    x = NULL,
    y = "Porcentaje (%)"
  )

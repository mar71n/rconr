library(lubridate)

dmy("28FEB2021")
dmy("28/02/2021")
dmy("29/02/2021")
dmy("29/02/2020")

dmy_hms("28FEB2021:15:15:00")


vacunas <- read_csv("datos/dataset_total_vacunas.csv")

data1 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GENERO) %>% summarise(t = sum(total, na.rm=TRUE))


data2 <- vacunas %>% mutate(total = (DOSIS_1 + DOSIS_2 + DOSIS_3)) %>% select(FECHA_ADMINISTRACION, GENERO, GRUPO_ETARIO, total) %>%
  group_by(GRUPO_ETARIO, GENERO) %>% summarise(t = sum(total, na.rm=TRUE))

data1

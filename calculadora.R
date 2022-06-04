library(dplyr)
library("readxl")
#install.packages("readxl")

matricula <- read_excel("E_M_AX28.xlsx", sheet = "2020")
View(matricula)
names(matricula)
head(matricula)

typeof(TRUE)

typeof(1.2)

typeof(1L)

typeof("abc")

typeof(2+1i)

typeof(sqrt(2))

typeof(sqrt(-1+0i))

typeof(1i * 1i)




#si 2 albañiles levantan 5 paredes, ¿ cuantas paredes levantan 3 albañiles?
#3 simple directa
#2 5
#3
3 * 5 / 2

a = 2;  p = 5
ax = 3 
px = ax*p/a
c(3,4,5)*5/2


# Si 2 camiones precisan hacer 5 viajes, ¿cuantos viajes precisan hacer 3 camiones?
# 3 simple inversa
# 2 5
# 3
2*5/3
2*5/c(3,4,5)

c = 2; v = 5
cx = 3
vx =  c*v/cx


r3s_d <- function(a ,p , ax){
  px = ax*p/a
}

px = r3s_d(a, p, ax)


sum(1:2)
rm(x)
sum(x <- 1:4)
x

rm(x)
sum(x = 1:4)
x


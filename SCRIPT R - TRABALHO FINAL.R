setwd("C:\\Users\\artur.gueiros\\Desktop\\MESTRADO\\DISCIPLINAS 2020.1\\ANÁLISE DE DADOS 2020.1\\TRABALHO FINAL")

library(readxl)

banco <- read_excel("BASE DE DADOS - TRABALHO FINAL.xlsx", sheet = 2) # Carregamento da primeira base

head(banco)

banco$IVS <- as.numeric(banco$IVS)

head(banco)
tail(banco)
str(banco)
summary(banco)

library(tidyverse)
glimpse(banco)

banco2 <- read_excel("Municípios.xlsx")  # Carregamento da segunda base

head(banco2)

banco2 <- banco2 %>%
  mutate(PORTE_POP = case_when(POPULAÇÃO < 20000 ~ "Pequeno",
                               POPULAÇÃO >= 20000 ~ "Médio-Grande"))  # Criação de variável categórica dicotômica

head(banco2)
str(banco2)
summary(banco2)
glimpse(banco2)

banco3 <- left_join(banco, banco2, 
                    by = c("Município" = "MUNICÍPIO"))  # Junção das duas bases de dados

head(banco3)
str(banco3)
summary(banco3)
glimpse(banco3)

banco3 %>%
  count(MESORREGIÃO)

banco3 %>%
  count(PORTE_POP)

ggplot(banco3, aes(Renda))+
  geom_histogram(bins = 15)+
  theme_classic()+
  labs(title = "Figura 1",
       subtitle = "Histograma",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(x = "", y = Renda)) + 
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))+
  theme_classic()+
  labs(title = "Figura 1-A",
       subtitle = "Gráfico de violino",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(Gini)) +
  geom_density()+
  theme_classic()+
  labs(title = "Figura 2",
       subtitle = "Gráfico de densidade",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(y = Gini)) + 
  geom_boxplot()+
  theme_classic()+
  labs(title = "Figura 2-A",
       subtitle = "Boxplot",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(DensidDem))+
  geom_histogram(bins = 15)+
  theme_classic()+
  labs(title = "Figura 3",
       subtitle = "Histograma",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(y = DensidDem)) + 
  geom_boxplot()+
  theme_classic()+
  labs(title = "Figura 3-A",
       subtitle = "Boxplot",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(Urb)) + 
  geom_histogram(aes(y=..density..),      
                 binwidth=5) +
  geom_density() +
  geom_vline(aes(xintercept = mean(Urb, na.rm = T)))+
  theme_classic()+
  labs(title = "Figura 4",
       subtitle = "Histograma e Gráfico de densidade",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(y = Urb)) + 
  geom_boxplot()+
  theme_classic()+
  labs(title = "Figura 4-A",
       subtitle = "Boxplot",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(IVS)) + 
  geom_histogram(aes(y=..density..),      
                 binwidth=3) +
  geom_density() +
  geom_vline(aes(xintercept = mean(IVS, na.rm = T)))+
  theme_classic()+
  labs(title = "Figura 5",
       subtitle = "Histograma e Gráfico de densidade",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(y = IVS)) + 
  geom_boxplot()+
  theme_classic()+
  labs(title = "Figura 5-A",
       subtitle = "Boxplot",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(y = IDHM)) + 
  geom_boxplot()+
  theme_classic()+
  labs(title = "Figura 6",
       subtitle = "Boxplot",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(y = CVLI)) + 
  geom_boxplot()+
  theme_classic()+
  labs(title = "Figura 7",
       subtitle = "Boxplot",
       caption = "Base de Dados do Estado/PE e IBGE")

library(ggbeeswarm)

ggplot(banco3, aes("",CVLI)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  geom_beeswarm()+
  theme_classic()+
  labs(title = "Figura  8",
       subtitle = "Gráfico de violino e Beeswarm",
       caption = "Base de Dados do Estado/PE e IBGE")

banco_graf <- banco3 %>%
  filter(!is.na(POPULAÇÃO),
         !is.na(IVS))

ggplot(banco_graf, aes(MESORREGIÃO)) +
  geom_bar()+
  theme_classic()+
  labs(title = "Figura 9",
       subtitle = "Gráfico de barra",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco_graf, aes(PORTE_POP)) +
  geom_bar()+
  theme_classic()+
  labs(title = "Figura 10",
       subtitle = "Gráfico de barra",
       caption = "Base de Dados do Estado/PE e IBGE")

library(scales)

ggplot(banco_graf, aes(PORTE_POP, ..count../sum(..count..) )) +
  geom_bar(na.rm = T) +
  scale_y_continuous(labels = percent)+
  theme_classic()+
  labs(title = "Figura 11",
       subtitle = "Gráfico de barra",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(Gini, CVLI)) +
  geom_jitter()+
  theme_classic()+
  labs(title = "Figura 12",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(Renda, CVLI)) +
  geom_jitter()+
  theme_classic()+
  labs(title = "Figura 13",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(IDHM, CVLI)) +
  geom_jitter()+
  theme_classic()+
  labs(title = "Figura 14",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(Urb, CVLI)) +
  geom_jitter()+
  theme_classic()+
  labs(title = "Figura 15",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(IVS, CVLI)) +
  geom_jitter()+
  theme_classic()+
  labs(title = "Figura 16",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(DensidDem, CVLI)) +
  geom_jitter()+
  theme_classic()+
  labs(title = "Figura 17",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco_graf, aes(CVLI, fill = MESORREGIÃO)) +
  geom_density(alpha = 0.3)+
  theme_classic()+
  labs(title = "Figura 18",
       subtitle = "Gráfico de densidade",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco_graf, aes(CVLI, fill = PORTE_POP)) +
  geom_density(alpha = 0.3)+
  theme_classic()+
  labs(title = "Figura 19",
       subtitle = "Gráfico de densidade",
       caption = "Base de Dados do Estado/PE e IBGE")

cor.test(banco$Gini, banco$CVLI)
cor.test(banco$Renda, banco$CVLI)
cor.test(banco$IDHM, banco$CVLI)
cor.test(banco$Urb, banco$CVLI)
cor.test(banco$IVS, banco$CVLI)
cor.test(banco$DensidDem, banco$CVLI)
t.test(CVLI ~ PORTE_POP, data = banco3)

ggplot(banco3, aes(Gini, CVLI, color = PORTE_POP)) +
  geom_jitter(size = 3)+
  theme_classic()+
  labs(title = "Figura 20",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(Gini, CVLI)) +
  geom_jitter(size = 3) +
  facet_wrap(vars(MESORREGIÃO))+
  theme_classic()+
  labs(title = "Figura 21",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

ggplot(banco3, aes(Gini, CVLI)) +
  geom_jitter()+
  facet_grid(PORTE_POP ~ MESORREGIÃO)+
  theme_classic()+
  labs(title = "Figura 22",
       subtitle = "Gráfico de pontos",
       caption = "Base de Dados do Estado/PE e IBGE")

regressao <- lm(CVLI ~ Gini + Renda + DensidDem + Urb + IVS + IDHM + MESORREGIÃO + PORTE_POP, data = banco3)

summary(regressao)
confint(regressao)

library(dotwhisker)

dwplot(regressao,
       vline = geom_vline(xintercept = 0, colour = "grey60", linetype = 2), conf.level = .90)

plot(regressao, 1)

plot(regressao, 3)
plot(regressao, 1)

library(lmtest)

bptest(regressao)

library(car)

ncvTest(regressao)

acf(regressao$residuals)

durbinWatsonTest(regressao)

plot(regressao, 2)

library(MASS)

sresid <- studres(regressao) 
shapiro.test(sresid)

vif(regressao)

plot(regressao, 4)
plot(regressao, 5)
outlierTest(regressao)

banco4 <-banco3 %>%   # criação de banco de dados sem duas observações destoantes/influentes
  slice(-c(61,86))

banco5 <-banco3 %>%   # criação de banco de dados sem uma observação destoante/influente
  slice(-c(61))

regressao1 <- lm(CVLI ~ Gini + Renda + DensidDem + Urb + IVS + IDHM + MESORREGIÃO + PORTE_POP, data = banco4)

summary(regressao1) # Regressão com variável Renda per Capta e sem os outliers 61 e 86.
confint(regressao1)

regressao2 <- lm(CVLI ~ Gini + Renda + DensidDem + Urb + IVS + IDHM + MESORREGIÃO + PORTE_POP, data = banco5)

summary(regressao2) # Regressão com variável Renda per Capta e sem o outlier 61.
confint(regressao2)

regressao3 <- lm(CVLI ~ Gini + DensidDem + Urb + IVS + IDHM + MESORREGIÃO + PORTE_POP, data = banco4)

summary(regressao3)  # Regressão Sem a variável Renda per Capta e sem os outliers 61 e 86.
confint(regressao3)

dwplot(list(regressao1,
            regressao2,
            regressao3),
       vline = geom_vline(xintercept = 0, colour = "grey60", linetype = 2), conf.level = .90)

regressao4 <- lm(CVLI ~ Gini + Renda + DensidDem + Urb + IVS + IDHM + MESORREGIÃO +  
                   PORTE_POP + MESORREGIÃO * PORTE_POP, data = banco4)      # Regressão utilizando o modelo 1, com Renda per capta e sem os outliers 61 e 86.

summary(regressao4)
confint(regressao4)

library(sjPlot)

plot_model(regressao4, type = "pred", 
           terms = c("MESORREGIÃO", "PORTE_POP"), 
           ci.lvl = 0.9)

## Fa�a todos os gr�ficos utilizando um tema que voc� ache mais adequado
## e nomeie os eixos x e y da maneira adequada

## Carregue o banco world do pacote poliscidata

library(poliscidata)

banco <- world

## Observe o banco de dados com as fun��es adequadas

head(banco)
tail(banco)
str(banco)
summary(banco)

library(tidyverse)

glimpse(banco)

## A vari�vel democ_regime08 indica se um pa�s � democr�tico.
## Usando as ferramentas de manipulacao de bancos de dados, verifique
## quantos paises sao democraticos ou nao, e apresente esta vari�vel 
## graficamente

banco_exerc4 <- banco %>% select (democ_regime08, country, muslim, gdppcap08, dem_score14)

glimpse(banco_exerc4)

bd_democ_regime08 <- banco_exerc4$democ_regime08 

summary(bd_democ_regime08)

#RESPOSTA: 95 pa�ses s�o democr�ticos, 69 n�o s�o democr�ticos e 3 n�o foram classificados.

glimpse(bd_democ_regime08)

ggplot(banco_exerc4, aes(democ_regime08))+
  geom_bar()+
  theme_classic()+
  labs(title = "Figura 1",
       subtitle = "Gr�fico de barra",
       x = "Classifica��o democr�tica",
       y = "N�mero de pa�ses",
       caption = "Elabora��o pr�pria a partir do banco WORLD")


## Teste a rela��o entre a vari�vel democ_regime08 e a vari�vel
## muslim (que indica se um pa�s � mu�ulmano ou n�o). E represente
## visualmente as vari�veis para visualizar se esta religi�o
## aumenta ou diminui a chance de um pa�s ser democr�tico.

banco_exerc4_sem_NA <- banco_exerc4 %>%
filter(!is.na(democ_regime08),
       !is.na(country),
       !is.na(muslim),
       !is.na(gdppcap08),
       !is.na(dem_score14))

glimpse(banco_exerc4_sem_NA)

ggplot(banco_exerc4_sem_NA, aes(muslim, fill = democ_regime08)) +
  geom_bar(position = "fill") + 
  theme_classic()+
  labs(title = "Figura 2",
       subtitle = "Gr�fico de barra",
       x = "Religi�o mu�ulmana",
       y = "Pa�s democr�tico",
       caption = "Elabora��o pr�pria a partir do banco WORLD")

ggplot(banco_exerc4_sem_NA, aes(x = muslim, y = democ_regime08)) + 
  geom_count(aes(group = muslim, size = after_stat(prop))) +
  scale_size_area(max_size = 10)+
  theme_minimal()+
  labs(title = "Figura 3",
       subtitle = "Gr�fico geom_count",
       x = "Religi�o mu�ulmana",
       y = "Pa�s democr�tico",
       caption = "Elabora��o pr�pria a partir do banco WORLD")


#RESPOSTA - PELO GR�FICO DE BARRA SE IDENTIFICA QUE A MAIOR
#ASSOCIA��O DE N�O-MU�ULMAMOS COM DEMOCRACIAS E DE MU�ULMANOS COM REGIMES N�O-DEMOCR�TICOS. O TESTE DO QUI-QUADRADO
#A SEGUIR ESCLARECE MAIS A QUEST�O.

tabela_1 <- table(banco_exerc4_sem_NA$muslim, banco_exerc4_sem_NA$democ_regime08)

prop.table(tabela_1, 2)

chisq.test(tabela_1)

library(graphics)

mosaicplot(tabela_1, shade = TRUE)


library(vcd)
assoc(tabela_1, shade = TRUE)


## Qual seria sua conclus�o com rela��o a associa��o destas duas
## vari�veis?

#RESPOSTA - AL�M DO P-VALOR BASTANTE BAIXO OBTIDO NO TESTE, A REPRESENTA��O GR�FICA PELO MOSAICPLOT E O ASSOC TORNA MAIS CLARA A 
#PERCEP��O DE QUE H� SIGNIFIC�NCIA ESTAT�STICA NEGATIVA, NOS CASOS DE N�O SER MU�ULMANO E O PA�S N�O SER DEMOCR�TICO, 
#E SER MU�ULMANO E O PA�S SER DEMOCR�TICO. DA MESMA FORMA OBSERVA-SE SIGNIFIC�NCIA ESTAT�STICA POSITIVA NO CASO DE N�O 
#SER MU�ULMANO E O PA�S SER DEMOCR�TICO. A HIP�TESE DE SE SER MU�ULMANO E O PA�S SER DEMOCR�TICO N�O APRESENTOU 
#SIGNIFIC�NCIA ESTAT�STICA.


## A vari�vel gdppcap08 possui informa��o sobre o PIB per capta
## dos pa�ses. Fa�a uma representa��o gr�fica desta vari�vel

ggplot(banco_exerc4_sem_NA, aes(x = "", y = gdppcap08)) + 
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  theme_dark()+
  labs(title = "Figura 4",
       subtitle = "Gr�fico de violino",
       x = "Distribui��o",
       y = "PIB per capita pa�ses",
       caption = "Elabora��o pr�pria a partir do banco WORLD")
  

## Fa�a um sumario com a m�dia, mediana e desvio padr�o do pib per capta
## para cada tipo de regime politico, represente a associa��o destas
## vari�veis graficamente, e fa�a o teste estat�stico adequado para
## chegar a uma conclus�o. Existe associa��o entre as vari�veis?

#SUM�RIO
sumario_pibpercapta_por_regime <- banco_exerc4_sem_NA %>%
  group_by(democ_regime08) %>%
  summarise(media = mean(gdppcap08, na.rm = TRUE), 
            mediana = median(gdppcap08, na.rm = TRUE), 
            desvio = sd(gdppcap08, na.rm = TRUE),
            n=n()) 

glimpse(sumario_pibpercapta_por_regime)

#GR�FICO

ggplot(banco_exerc4_sem_NA, aes(gdppcap08, fill = democ_regime08)) +
  geom_density(alpha = 0.3)+
theme_minimal()+
  labs(title = "Figura 5",
       subtitle = "Gr�fico de densidade",
       x = "PIB per capita pa�ses",
       y = "Densidade",
       caption = "Elabora��o pr�pria a partir do banco WORLD")


ggplot(banco_exerc4_sem_NA, aes(democ_regime08, gdppcap08)) +
  geom_boxplot()+
  theme_classic()+
  labs(title = "Figura 6",
       subtitle = "Gr�fico boxplot",
       x = "Regime democr�tico",
       y = "PIB per capita pa�ses",
       caption = "Elabora��o pr�pria a partir do banco WORLD")
  

ggplot(banco_exerc4_sem_NA, aes(democ_regime08, gdppcap08)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  theme_minimal()+
  labs(title = "Figura 7",
       subtitle = "Gr�fico de violino",
       x = "Regime democr�tico",
       y = "PIB per capita pa�ses",
       caption = "Elabora��o pr�pria a partir do banco WORLD")

#TESTE ESTAT�STICO T

t.test(gdppcap08 ~ democ_regime08, data = banco_exerc4_sem_NA)

#RESPOSTA - O RESULTADO DO SUM�RIO, DOS GR�FICOS E DO TESTE ESTAT�STICO COM VALOR-P AINDA ABAIXO DE 0,05 SUGEREM A 
#EXIST�NCIA DE ASSOCIA��O ENTRE AS DUAS VARI�VEIS, APESAR DEsTA N�O SER ROBUSTA. TANTO A MEDIANA QUANTO OS QUARTIS 
#DOS PA�SES DEMOCR�TICOS S�O SUPERIORES AOS DOS PA�SES NAO DEMOCR�TICOS, COMO A DENSIDADE � MAIS BEM DISTRIBU�DA 
#ENTRE PIBS PER CAPITA MAIORES DO QUE NOS PA�SES N�O DEMOCR�TICOS. O P-VALOR EST� DENTRO DO LIMITE DE VIABILIDADE 
#ESTAT�STICA E O GRAU DE LIBERDADE � POSITIVO. 



## Por fim, ao inv�s de utilizar uma vari�vel bin�ria de democracia,
## utilize a vari�vel dem_score14 para avaliar se existe uma associa��o
## entre regime pol�tico e desenvolvimento econ�mico. Represente
## a associa��o graficamente, fa�a o teste estat�stico e explica sua
## conclus�o

ggplot(banco_exerc4_sem_NA, aes(dem_score14, gdppcap08)) +
  geom_jitter()+
  theme_classic()+
  labs(title = "Figura 8",
       subtitle = "Gr�fico de pontos",
       x = "Score democr�tico",
       y = "PIB per capita pa�ses",
       caption = "Elabora��o pr�pria a partir do banco WORLD")

cor.test(banco_exerc4_sem_NA$dem_score14, banco_exerc4_sem_NA$gdppcap08)

#RESPOSTA - APLICANDO O TESTE DE CORRELA��O R DE PEARSON PODE-SE OBSERVAR QUE O �NDICE DE CORRELA��O FICA ACIMA DE 50%, 
#COM INTERVALO DE CONFIAN�A DE 95% ENTRE 0,37 E 0,61, SEM PASSAR PELO ZERO. O P-VALOR � MUITO CONFORT�VEL E FORTALECE 
#A SIGNIFIC�NCIA ESTAT�STICA DA CORRELA��O ENTRE ESSAS DUAS VARI�VEIS. ASSIM, PODEMOS DIZER QUE SE OBSERVA ASSOCIA��O 
#ENTRE A VARI�VEL INDEPENDENTE REGIME POL�TICO E A VARI�VEL DEPENDENTE DESENVOLVIMENTO ECON�MICO.



## Teste a associa��o entre renda perca capta e religiao (com a vari�vel
## muslim) e represente graficamente. Qual � sua conclus�o? 

sumario_pibpercapta_por_religiao <- banco_exerc4_sem_NA %>%
  group_by(muslim) %>%
  summarise(media = mean(gdppcap08, na.rm = TRUE), 
            mediana = median(gdppcap08, na.rm = TRUE), 
            desvio = sd(gdppcap08, na.rm = TRUE),
            n=n()) 

glimpse(sumario_pibpercapta_por_religiao)

t.test(gdppcap08 ~ muslim, data = banco_exerc4_sem_NA)

ggplot(banco_exerc4_sem_NA, aes(gdppcap08, fill = muslim)) +
  geom_density(alpha = 0.3)+
  theme_minimal()+
  labs(title = "Figura 9",
       subtitle = "Gr�fico de densidade",
       x = "PIB per capita pa�ses",
       y = "Densidade",
       caption = "Elabora��o pr�pria a partir do banco WORLD")

ggplot(banco_exerc4_sem_NA, aes(muslim, gdppcap08)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  theme_minimal()+
  labs(title = "Figura 10",
       subtitle = "Gr�fico de violino",
       x = "Religi�o mu�ulmana",
       y = "PIB per capita pa�ses",
       caption = "Elabora��o pr�pria a partir do banco WORLD")

#RESPOSTA - A ASSOCIA��O ENTRE AS VARI�VEIS RELIGI�O MU�ULMANA E DESENVOLVIMENTO ECON�MICO N�O APRESENTA SIGNIFIC�NCIA 
#ESTAT�STICA SUFICIENTE, COM VALOR-P ACIMA DE 0,05.

## Comparando suas conclus�es anteriores, � poss�vel afirmar qual
## das duas vari�veis possui maior impacto no desenvolvimento economico? 
## Por que? 

#RESPOSTA - A VARI�VEL REGIME POL�TICO POSSUI MAIOR IMPACTO NA VARI�VEL DESENVOLVIMENTO ECON�MICO, POIS, AP�S TESTES,
#DEMONSTROU POSSUIR SIGNIFIC�NCIA ESTAT�STICA EM SUA CORRELA��O, DIFERENTEMENTE DA VARI�VEL RELIGI�O. INTERESSANTE NOTAR
#QUE APESAR DE NUM PRIMEIRO MOMENTO AS DISTRIBUI��ES GUARDAREM ALGUMA SEMELHAN�A SUPERFICIAL NOS GR�FICOS, A PERCEP��O 
#N�O RESISTE AO TESTE ESTAT�STICO.




##########################################################################

## Exerc�cio te�rico
## Levando em considera��o as vari�veis de seu trabalho final,
## qual dos 3 testes estat�sticos utilizados seria adequado utilizar?

#RESPOSTA - COMO TODAS AS VARI�VEIS DO TRABALHO FINAL S�O CONT�NUAS, NUM�RICAS, COMO O CVLI, O IDH, O GINI E O IVS, 
#O TESTE DE CORRELA��O, OU "R DE PEARSON", SERIA O MAIS ADEQUADO.

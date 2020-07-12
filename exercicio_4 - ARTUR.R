
## Faça todos os gráficos utilizando um tema que você ache mais adequado
## e nomeie os eixos x e y da maneira adequada

## Carregue o banco world do pacote poliscidata

library(poliscidata)

banco <- world

## Observe o banco de dados com as funções adequadas

head(banco)
tail(banco)
str(banco)
summary(banco)

library(tidyverse)

glimpse(banco)

## A variável democ_regime08 indica se um país é democrático.
## Usando as ferramentas de manipulacao de bancos de dados, verifique
## quantos paises sao democraticos ou nao, e apresente esta variável 
## graficamente

banco_exerc4 <- banco %>% select (democ_regime08, country, muslim, gdppcap08, dem_score14)

glimpse(banco_exerc4)

bd_democ_regime08 <- banco_exerc4$democ_regime08 

summary(bd_democ_regime08)

#RESPOSTA: 95 países são democráticos, 69 não são democráticos e 3 não foram classificados.

glimpse(bd_democ_regime08)

ggplot(banco_exerc4, aes(democ_regime08))+
  geom_bar()+
  theme_classic()+
  labs(title = "Figura 1",
       subtitle = "Gráfico de barra",
       x = "Classificação democrática",
       y = "Número de países",
       caption = "Elaboração própria a partir do banco WORLD")


## Teste a relação entre a variável democ_regime08 e a variável
## muslim (que indica se um país é muçulmano ou não). E represente
## visualmente as variáveis para visualizar se esta religião
## aumenta ou diminui a chance de um país ser democrático.

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
       subtitle = "Gráfico de barra",
       x = "Religião muçulmana",
       y = "País democrático",
       caption = "Elaboração própria a partir do banco WORLD")

ggplot(banco_exerc4_sem_NA, aes(x = muslim, y = democ_regime08)) + 
  geom_count(aes(group = muslim, size = after_stat(prop))) +
  scale_size_area(max_size = 10)+
  theme_minimal()+
  labs(title = "Figura 3",
       subtitle = "Gráfico geom_count",
       x = "Religião muçulmana",
       y = "País democrático",
       caption = "Elaboração própria a partir do banco WORLD")


#RESPOSTA - PELO GRÁFICO DE BARRA SE IDENTIFICA QUE A MAIOR
#ASSOCIAÇÃO DE NÃO-MUÇULMAMOS COM DEMOCRACIAS E DE MUÇULMANOS COM REGIMES NÃO-DEMOCRÁTICOS. O TESTE DO QUI-QUADRADO
#A SEGUIR ESCLARECE MAIS A QUESTÃO.

tabela_1 <- table(banco_exerc4_sem_NA$muslim, banco_exerc4_sem_NA$democ_regime08)

prop.table(tabela_1, 2)

chisq.test(tabela_1)

library(graphics)

mosaicplot(tabela_1, shade = TRUE)


library(vcd)
assoc(tabela_1, shade = TRUE)


## Qual seria sua conclusão com relação a associação destas duas
## variáveis?

#RESPOSTA - ALÉM DO P-VALOR BASTANTE BAIXO OBTIDO NO TESTE, A REPRESENTAÇÃO GRÁFICA PELO MOSAICPLOT E O ASSOC TORNA MAIS CLARA A 
#PERCEPÇÃO DE QUE HÁ SIGNIFICÂNCIA ESTATÍSTICA NEGATIVA, NOS CASOS DE NÃO SER MUÇULMANO E O PAÍS NÃO SER DEMOCRÁTICO, 
#E SER MUÇULMANO E O PAÍS SER DEMOCRÁTICO. DA MESMA FORMA OBSERVA-SE SIGNIFICÂNCIA ESTATÍSTICA POSITIVA NO CASO DE NÃO 
#SER MUÇULMANO E O PAÍS SER DEMOCRÁTICO. A HIPÓTESE DE SE SER MUÇULMANO E O PAÍS SER DEMOCRÁTICO NÃO APRESENTOU 
#SIGNIFICÂNCIA ESTATÍSTICA.


## A variável gdppcap08 possui informação sobre o PIB per capta
## dos países. Faça uma representação gráfica desta variável

ggplot(banco_exerc4_sem_NA, aes(x = "", y = gdppcap08)) + 
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  theme_dark()+
  labs(title = "Figura 4",
       subtitle = "Gráfico de violino",
       x = "Distribuição",
       y = "PIB per capita países",
       caption = "Elaboração própria a partir do banco WORLD")
  

## Faça um sumario com a média, mediana e desvio padrão do pib per capta
## para cada tipo de regime politico, represente a associação destas
## variáveis graficamente, e faça o teste estatístico adequado para
## chegar a uma conclusão. Existe associaçào entre as variáveis?

#SUMÁRIO
sumario_pibpercapta_por_regime <- banco_exerc4_sem_NA %>%
  group_by(democ_regime08) %>%
  summarise(media = mean(gdppcap08, na.rm = TRUE), 
            mediana = median(gdppcap08, na.rm = TRUE), 
            desvio = sd(gdppcap08, na.rm = TRUE),
            n=n()) 

glimpse(sumario_pibpercapta_por_regime)

#GRÁFICO

ggplot(banco_exerc4_sem_NA, aes(gdppcap08, fill = democ_regime08)) +
  geom_density(alpha = 0.3)+
theme_minimal()+
  labs(title = "Figura 5",
       subtitle = "Gráfico de densidade",
       x = "PIB per capita países",
       y = "Densidade",
       caption = "Elaboração própria a partir do banco WORLD")


ggplot(banco_exerc4_sem_NA, aes(democ_regime08, gdppcap08)) +
  geom_boxplot()+
  theme_classic()+
  labs(title = "Figura 6",
       subtitle = "Gráfico boxplot",
       x = "Regime democrático",
       y = "PIB per capita países",
       caption = "Elaboração própria a partir do banco WORLD")
  

ggplot(banco_exerc4_sem_NA, aes(democ_regime08, gdppcap08)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  theme_minimal()+
  labs(title = "Figura 7",
       subtitle = "Gráfico de violino",
       x = "Regime democrático",
       y = "PIB per capita países",
       caption = "Elaboração própria a partir do banco WORLD")

#TESTE ESTATÍSTICO T

t.test(gdppcap08 ~ democ_regime08, data = banco_exerc4_sem_NA)

#RESPOSTA - O RESULTADO DO SUMÁRIO, DOS GRÁFICOS E DO TESTE ESTATÍSTICO COM VALOR-P AINDA ABAIXO DE 0,05 SUGEREM A 
#EXISTÊNCIA DE ASSOCIAÇÃO ENTRE AS DUAS VARIÁVEIS, APESAR DEsTA NÃO SER ROBUSTA. TANTO A MEDIANA QUANTO OS QUARTIS 
#DOS PAÍSES DEMOCRÁTICOS SÃO SUPERIORES AOS DOS PAÍSES NAO DEMOCRÁTICOS, COMO A DENSIDADE É MAIS BEM DISTRIBUÍDA 
#ENTRE PIBS PER CAPITA MAIORES DO QUE NOS PAÍSES NÃO DEMOCRÁTICOS. O P-VALOR ESTÁ DENTRO DO LIMITE DE VIABILIDADE 
#ESTATÍSTICA E O GRAU DE LIBERDADE É POSITIVO. 



## Por fim, ao invés de utilizar uma variável binária de democracia,
## utilize a variável dem_score14 para avaliar se existe uma associação
## entre regime político e desenvolvimento econômico. Represente
## a associação graficamente, faça o teste estatístico e explica sua
## conclusão

ggplot(banco_exerc4_sem_NA, aes(dem_score14, gdppcap08)) +
  geom_jitter()+
  theme_classic()+
  labs(title = "Figura 8",
       subtitle = "Gráfico de pontos",
       x = "Score democrático",
       y = "PIB per capita países",
       caption = "Elaboração própria a partir do banco WORLD")

cor.test(banco_exerc4_sem_NA$dem_score14, banco_exerc4_sem_NA$gdppcap08)

#RESPOSTA - APLICANDO O TESTE DE CORRELAÇÃO R DE PEARSON PODE-SE OBSERVAR QUE O ÍNDICE DE CORRELAÇÃO FICA ACIMA DE 50%, 
#COM INTERVALO DE CONFIANÇA DE 95% ENTRE 0,37 E 0,61, SEM PASSAR PELO ZERO. O P-VALOR É MUITO CONFORTÁVEL E FORTALECE 
#A SIGNIFICÂNCIA ESTATÍSTICA DA CORRELAÇÃO ENTRE ESSAS DUAS VARIÁVEIS. ASSIM, PODEMOS DIZER QUE SE OBSERVA ASSOCIAÇÃO 
#ENTRE A VARIÁVEL INDEPENDENTE REGIME POLÍTICO E A VARIÁVEL DEPENDENTE DESENVOLVIMENTO ECONÔMICO.



## Teste a associação entre renda perca capta e religiao (com a variável
## muslim) e represente graficamente. Qual é sua conclusão? 

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
       subtitle = "Gráfico de densidade",
       x = "PIB per capita países",
       y = "Densidade",
       caption = "Elaboração própria a partir do banco WORLD")

ggplot(banco_exerc4_sem_NA, aes(muslim, gdppcap08)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  theme_minimal()+
  labs(title = "Figura 10",
       subtitle = "Gráfico de violino",
       x = "Religião muçulmana",
       y = "PIB per capita países",
       caption = "Elaboração própria a partir do banco WORLD")

#RESPOSTA - A ASSOCIAÇÃO ENTRE AS VARIÁVEIS RELIGIÃO MUÇULMANA E DESENVOLVIMENTO ECONÔMICO NÃO APRESENTA SIGNIFICÂNCIA 
#ESTATÍSTICA SUFICIENTE, COM VALOR-P ACIMA DE 0,05.

## Comparando suas conclusões anteriores, é possível afirmar qual
## das duas variáveis possui maior impacto no desenvolvimento economico? 
## Por que? 

#RESPOSTA - A VARIÁVEL REGIME POLÍTICO POSSUI MAIOR IMPACTO NA VARIÁVEL DESENVOLVIMENTO ECONÔMICO, POIS, APÓS TESTES,
#DEMONSTROU POSSUIR SIGNIFICÂNCIA ESTATÍSTICA EM SUA CORRELAÇÃO, DIFERENTEMENTE DA VARIÁVEL RELIGIÃO. INTERESSANTE NOTAR
#QUE APESAR DE NUM PRIMEIRO MOMENTO AS DISTRIBUIÇÕES GUARDAREM ALGUMA SEMELHANÇA SUPERFICIAL NOS GRÁFICOS, A PERCEPÇÃO 
#NÃO RESISTE AO TESTE ESTATÍSTICO.




##########################################################################

## Exercício teórico
## Levando em consideração as variáveis de seu trabalho final,
## qual dos 3 testes estatísticos utilizados seria adequado utilizar?

#RESPOSTA - COMO TODAS AS VARIÁVEIS DO TRABALHO FINAL SÃO CONTÍNUAS, NUMÉRICAS, COMO O CVLI, O IDH, O GINI E O IVS, 
#O TESTE DE CORRELAÇÃO, OU "R DE PEARSON", SERIA O MAIS ADEQUADO.

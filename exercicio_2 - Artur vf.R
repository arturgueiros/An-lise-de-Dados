#
# Suponha que tenhamos o dataframe df abaixo
#
# x     y
# A     5
# A     3
# B     8
# B    12
#
# Complete o código que obtém o seguinte resultado:
#
#        z
#        7
#
df <- data.frame (x = c("A", "A", "B", "B"), 
                  y = c(5,3,8,12))
df

df %>% summarise (z = mean(y))

#######################################################################

# Suponha que tenhamos o dataframe df abaixo
#
# y1    y2    y3    y4
# 8.04  9.14  7.46  6.58
# 6.95  8.14  6.77  5.76
# 7.58  8.74  12.74 7.71
#
# Complete o código que obtém o seguinte resultado:
#
# y1    
# 8.04  
# 6.95  
# 7.58  


df %>% select (y1)

  
#######################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#    x  y
#   1  10
#   6  8
#   2  3
#   4  5
#
# Complete o código que obtém o seguinte resultado, fazendo uma operação
# entre x e y
#
#    x  y   z
#   1  10  -9
#   6  8   -2
#   2  3   -1
#   4  5   -1
#

df %>% mutate (z=x-y)

  
########################################################################

#
# Suponha que tenhamos o dataframe df abaixo
#
#    city sales
# Boston   220
# Boston   125
#    NYC   150
#    NYC   250
#
# Complete o código que obtém o seguinte resultado:
#
# city   avg_sales
# Boston      172
# NYC         200 


df %>% group_by(city) %>%
  summarise(avg_sales = mean(sales))


  
########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#week   min   max
#  3    55    60
#  2    52    56
#  1    60    63
#  4    65    67
#
# Complete o código que obtém o seguinte resultado:
#
#week   min   max
#  1    60    63
#  2    52    56
#  3    55    60
#  4    65    67


df %>% arrange(week)


########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
# x_b_1  x_b_2  y_c_1  y_c_2
#  A      2      W1     25
#  A      4      W2     21
#  B      6      W1     26
#  B      8      W2     30
#
# Complete o código que obtém o seguinte resultado:
#
# y_c_1  y_c_2
#  W1     25
#  W2     21
#  W1     26
#  W2     30


df %>% select (starts_with("y"))


#########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
# Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
# 78           6.7         3.0          5.0         1.7 versicolor
# 121          6.9         3.2          5.7         2.3  virginica
# 11           5.4         3.7          1.5         0.2     setosa
# 92           6.1         3.0          4.6         1.4 versicolor
# 146          6.7         3.0          5.2         2.3  virginica
# 62           5.9         3.0          4.2         1.5 versicolor
# 50           5.0         3.3          1.4         0.2     setosa
# 17           5.4         3.9          1.3         0.4     setosa
# 69           6.2         2.2          4.5         1.5 versicolor
# 143          5.8         2.7          5.1         1.9  virginica
#
# Complete o código que obtém o seguinte resultado:
#
#Species      Sepal.Area
#versicolor      20.10
#virginica       22.08
#setosa          19.98
#versicolor      18.30
#virginica       20.10
#versicolor      17.70
#setosa          16.50
#setosa          21.06
#versicolor      13.64
#virginica      15.66

df %>% transmute (species, Sepal.Area = Sepal.Length * Sepal.width)


########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#name         start       end         party     
#Eisenhower   1953-01-20  1961-01-20  Republican
#Kennedy      1961-01-20  1963-11-22  Democratic
#Johnson      1963-11-22  1969-01-20  Democratic
#Nixon        1969-01-20  1974-08-09  Republican
#Ford         1974-08-09  1977-01-20  Republican
#Carter       1977-01-20  1981-01-20  Democratic
#Reagan       1981-01-20  1989-01-20  Republican
#Bush         1989-01-20  1993-01-20  Republican
#Clinton      1993-01-20  2001-01-20  Democratic
#Bush         2001-01-20  2009-01-20  Republican
#Obama        2009-01-20  2017-01-20  Democratic
#
#Crie um código abaixo para que se altere a variável party
#deixando apenas a primeira letra dos partidos


df %>% mutate (party=recode(party,Republican="R",Democratic="D"))
  

###############################################################################

# No pacote poliscidata existe um banco de dados chamado nes, com informações 
# do American National Election Survey. Para os exerícicios a seguir, instale 
# o pacote poliscidata e tidyverse, carregue-os e crie um objeto chamado
# df com os dados do nes. 

install.packages("tidyverse")
library(tidyverse)

install.packages("poliscidata")
library(poliscidata)

df_nes<-nes



# Faça uma primeira exploração do banco de dados com todos os comandos
# passados até aqui que possuem esse objetivo

head(df_nes)
tail(df_nes)
str(df_nes)
summary(df_nes)
glimpse (df_nes)

# Quantos respondentes possui na pesquisa?

# 5916 respondentes

# Caso queiram ter mais informações sobre as variáveis do nes, basta rodar
# o código `?nes`, que no canto inferior direito aparecerá uma descrição.
# Como temos muitas variáveis, deixe apenas as colunas
# ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote
# income5, gender.

df_nes_8var<-df_nes%>% select(ftgr_cons, dem_raceeth, 
                              voted2012, science_use, 
                              preknow3, obama_vote,income5, gender)
str(df_nes_8var)

# Se quisermos ter informações apenas de pessoas que votaram na
# eleição de 2012, podemos usar a variável voted2012. Tire do banco
# os respondentes que não votaram

df_nes_votantes<-df_nes_8var %>% filter(voted2012=="Voted")

glimpse(df_nes_votantes)




# Quantos respondentes sobraram?

# Sobraram 4404 respondentes.


# Crie uma variável chamada white que indica se o respondente é branco
# ou não a partir da variável dem_raceeth, crie a variável ideology a
# partir da variável ftgr_cons (0-33 como liberal, 34 a 66 como centro,
# e 67 a 100 como conservador), ao mesmo tempo em que muda
# a variável obama_vote para trocar o 1 por "Sim" e 2 por "não"


df_nes_votantes_newvar <- df_nes_votantes %>% mutate(
  ideology = case_when(ftgr_cons < 34 ~ "liberal",
                       ftgr_cons >= 34 & ftgr_cons < 67 ~ "centro",
                       ftgr_cons >= 67 & ftgr_cons < 101 ~ "conservador"),
  obama_vote = recode(obama_vote, "1" = "sim", "0" = "não"),
  white = recode(dem_raceeth, 
                 "1. White non-Hispanic" = "Yes",
                 "2. Black non-Hispanic" = "No",
                 "3. Hispanic" = "No",
                 "4. Other non-Hispanic" = "No"))

df_nes_votantes_newvar

summary(df_nes_votantes_newvar)                         
glimpse(df_nes_votantes_newvar)                                  

# Demonstre como observar a quantidade de pessoas em cada uma das
# categorias de science_use

df_nes_votantes_newvar %>% count(science_use)

# Demonstre como observar a média de conservadorismo (variável 
# ftgr_cons) para cada categoria de science_use

df_nes_votantes_newvar %>% summarise(media = mean (ftgr_cons, na.rm=TRUE))

  
###############################################################################

# Responder as questões teóricas da aula abaixo

Artigo: Determinantes da criminalidade na região sudeste do Brasil: uma aplicação de painel espacial

http://www.scielo.org.mx/scielo.php?script=sci_arttext&pid=S1405-84212018000200525&lang=pt

Qual a questão da pesquisa?

    Quais os principais fatores responsáveis pela criminalidade na região Sudeste do Brasil?
  
  Qual a teoria causal? 
  
  O fenômeno da criminalidade está associado a fatores socioeconômicos e demográficos presentes na sociedade, os quais, por seu comportamento e variação, afetam o nível de criminalidade existente na realidade de uma cidade, estado, região ou nação.

Qual é o desenho de pesquisa?

    Trata-se de um estudo observacional de série temporal.

Aderência aos quatro pilares da causalidade: 

1-	A Teoria causal está presente e é crível, fartamente trabalhada na academia;
2-	O papel causal entre as variáveis dependente e independente está consistente. A criminalidade se origina de uma realidade socioeconômica presente e precedente, e não o contrário;
3-	A covariação existe, embora oscile, dependendo das variáveis independentes escolhidas dentro dos indicadores socioeconômicos;
4-	As variáveis independentes são de origem socioeconômica direta, original e própria, com ligação causal direta com a variável dependente. Mesmo que outras variáveis existam afetando o nível de criminalidade, a chance de que elas tornem a relação causal proposta espúria é pequena.

O que ele conclui? 	

  De modo geral foi possível constatar que os aspectos que afetam a criminalidade no Sudeste encontram-se relacionadas com variáveis socioeconômicas do espaço em análise. Dentro desse escopo se identificou que a densidade populacional, o PIB per capita, a taxa de desemprego e a proporção de jovens impactam positivamente as taxas de homicídios das microrregiões do sudeste. Ao contrário do esperado, não foi encontrado efeito significativo no tocante as demais variáveis independentes utilizadas.

Como a sua pesquisa dá um passo a mais para o desenvolvimento teórico presente neste artigo?
  
  Além de levar a preocupação geral sobre os efeitos da realidade socioeconômica na violência para um outro espectro geográfico, o Nordeste brasileiro, a pesquisa utiliza uma cesta de variáveis independentes distinta, foca especificamente nos Crimes Violentos Letais Intencionais enquanto variável dependente e busca respostas para a realidade dos municípios. 

Qual a pergunta da sua pesquisa?
  
  A desigualdade econômica, a qualidade de vida e a vulnerabilidade social nos municípios de Pernambuco estão associadas às suas taxas de homicídios?
  
  Qual a teoria da sua pesquisa?
  
  A realidade social da violência por ter sua origem nas relações humanas se expressa de várias formas, deriva de diversos fatores e pode ser mais bem compreendida conjuntamente por abordagens nas perspectivas históricas, culturais, econômicas, políticas e sociais. Neste sentido, a teoria causal proposta é a de que existe uma relação entre os indicadores socioeconômicos dos municípios e os seus índices de homicídios intencionais, de modo que quanto melhores fossem esses indicadores, mais baixos seriam os índices de assassinatos naquele município.


Aderência aos quatro pilares da causalidade: 
1-	Teoria causal presente e crível, com presença constante nas pesquisas acadêmicas;
2-	 A orientação de causalidade entre as variáveis dependente e independentes é perceptível. É a realidade socioeconômica que favorece os índices de homicídio em geral, e não o contrário;
3-	É de se esperar a existência de covariação, ainda que mais ou menos clara, dependendo das variáveis independentes utilizadas;
4-	Pelas variáveis independentes escolhidas, todas ancoradas diretamente nos indicadores da realidade socioeconômica, as chances de uma outra variável vir a afetar a relação causal entre as variáveis tornando-a espúria é bastante pequena.



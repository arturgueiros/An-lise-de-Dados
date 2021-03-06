#
# Suponha que tenhamos o dataframe df abaixo
#
# x     y
# A     5
# A     3
# B     8
# B    12
#
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado, fazendo uma opera��o
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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado:
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
#Crie um c�digo abaixo para que se altere a vari�vel party
#deixando apenas a primeira letra dos partidos


df %>% mutate (party=recode(party,Republican="R",Democratic="D"))
  

###############################################################################

# No pacote poliscidata existe um banco de dados chamado nes, com informa��es 
# do American National Election Survey. Para os exer�cicios a seguir, instale 
# o pacote poliscidata e tidyverse, carregue-os e crie um objeto chamado
# df com os dados do nes. 

install.packages("tidyverse")
library(tidyverse)

install.packages("poliscidata")
library(poliscidata)

df_nes<-nes



# Fa�a uma primeira explora��o do banco de dados com todos os comandos
# passados at� aqui que possuem esse objetivo

head(df_nes)
tail(df_nes)
str(df_nes)
summary(df_nes)
glimpse (df_nes)

# Quantos respondentes possui na pesquisa?

# 5916 respondentes

# Caso queiram ter mais informa��es sobre as vari�veis do nes, basta rodar
# o c�digo `?nes`, que no canto inferior direito aparecer� uma descri��o.
# Como temos muitas vari�veis, deixe apenas as colunas
# ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote
# income5, gender.

df_nes_8var<-df_nes%>% select(ftgr_cons, dem_raceeth, 
                              voted2012, science_use, 
                              preknow3, obama_vote,income5, gender)
str(df_nes_8var)

# Se quisermos ter informa��es apenas de pessoas que votaram na
# elei��o de 2012, podemos usar a vari�vel voted2012. Tire do banco
# os respondentes que n�o votaram

df_nes_votantes<-df_nes_8var %>% filter(voted2012=="Voted")

glimpse(df_nes_votantes)




# Quantos respondentes sobraram?

# Sobraram 4404 respondentes.


# Crie uma vari�vel chamada white que indica se o respondente � branco
# ou n�o a partir da vari�vel dem_raceeth, crie a vari�vel ideology a
# partir da vari�vel ftgr_cons (0-33 como liberal, 34 a 66 como centro,
# e 67 a 100 como conservador), ao mesmo tempo em que muda
# a vari�vel obama_vote para trocar o 1 por "Sim" e 2 por "n�o"


df_nes_votantes_newvar <- df_nes_votantes %>% mutate(
  ideology = case_when(ftgr_cons < 34 ~ "liberal",
                       ftgr_cons >= 34 & ftgr_cons < 67 ~ "centro",
                       ftgr_cons >= 67 & ftgr_cons < 101 ~ "conservador"),
  obama_vote = recode(obama_vote, "1" = "sim", "0" = "n�o"),
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

# Demonstre como observar a m�dia de conservadorismo (vari�vel 
# ftgr_cons) para cada categoria de science_use

df_nes_votantes_newvar %>% summarise(media = mean (ftgr_cons, na.rm=TRUE))

  
###############################################################################

# Responder as quest�es te�ricas da aula abaixo

Artigo: Determinantes da criminalidade na regi�o sudeste do Brasil: uma aplica��o de painel espacial

http://www.scielo.org.mx/scielo.php?script=sci_arttext&pid=S1405-84212018000200525&lang=pt

Qual a quest�o da pesquisa?

    Quais os principais fatores respons�veis pela criminalidade na regi�o Sudeste do Brasil?
  
  Qual a teoria causal? 
  
  O fen�meno da criminalidade est� associado a fatores socioecon�micos e demogr�ficos presentes na sociedade, os quais, por seu comportamento e varia��o, afetam o n�vel de criminalidade existente na realidade de uma cidade, estado, regi�o ou na��o.

Qual � o desenho de pesquisa?

    Trata-se de um estudo observacional de s�rie temporal.

Ader�ncia aos quatro pilares da causalidade: 

1-	A Teoria causal est� presente e � cr�vel, fartamente trabalhada na academia;
2-	O papel causal entre as vari�veis dependente e independente est� consistente. A criminalidade se origina de uma realidade socioecon�mica presente e precedente, e n�o o contr�rio;
3-	A covaria��o existe, embora oscile, dependendo das vari�veis independentes escolhidas dentro dos indicadores socioecon�micos;
4-	As vari�veis independentes s�o de origem socioecon�mica direta, original e pr�pria, com liga��o causal direta com a vari�vel dependente. Mesmo que outras vari�veis existam afetando o n�vel de criminalidade, a chance de que elas tornem a rela��o causal proposta esp�ria � pequena.

O que ele conclui? 	

  De modo geral foi poss�vel constatar que os aspectos que afetam a criminalidade no Sudeste encontram-se relacionadas com vari�veis socioecon�micas do espa�o em an�lise. Dentro desse escopo se identificou que a densidade populacional, o PIB per capita, a taxa de desemprego e a propor��o de jovens impactam positivamente as taxas de homic�dios das microrregi�es do sudeste. Ao contr�rio do esperado, n�o foi encontrado efeito significativo no tocante as demais vari�veis independentes utilizadas.

Como a sua pesquisa d� um passo a mais para o desenvolvimento te�rico presente neste artigo?
  
  Al�m de levar a preocupa��o geral sobre os efeitos da realidade socioecon�mica na viol�ncia para um outro espectro geogr�fico, o Nordeste brasileiro, a pesquisa utiliza uma cesta de vari�veis independentes distinta, foca especificamente nos Crimes Violentos Letais Intencionais enquanto vari�vel dependente e busca respostas para a realidade dos munic�pios. 

Qual a pergunta da sua pesquisa?
  
  A desigualdade econ�mica, a qualidade de vida e a vulnerabilidade social nos munic�pios de Pernambuco est�o associadas �s suas taxas de homic�dios?
  
  Qual a teoria da sua pesquisa?
  
  A realidade social da viol�ncia por ter sua origem nas rela��es humanas se expressa de v�rias formas, deriva de diversos fatores e pode ser mais bem compreendida conjuntamente por abordagens nas perspectivas hist�ricas, culturais, econ�micas, pol�ticas e sociais. Neste sentido, a teoria causal proposta � a de que existe uma rela��o entre os indicadores socioecon�micos dos munic�pios e os seus �ndices de homic�dios intencionais, de modo que quanto melhores fossem esses indicadores, mais baixos seriam os �ndices de assassinatos naquele munic�pio.


Ader�ncia aos quatro pilares da causalidade: 
1-	Teoria causal presente e cr�vel, com presen�a constante nas pesquisas acad�micas;
2-	 A orienta��o de causalidade entre as vari�veis dependente e independentes � percept�vel. � a realidade socioecon�mica que favorece os �ndices de homic�dio em geral, e n�o o contr�rio;
3-	� de se esperar a exist�ncia de covaria��o, ainda que mais ou menos clara, dependendo das vari�veis independentes utilizadas;
4-	Pelas vari�veis independentes escolhidas, todas ancoradas diretamente nos indicadores da realidade socioecon�mica, as chances de uma outra vari�vel vir a afetar a rela��o causal entre as vari�veis tornando-a esp�ria � bastante pequena.



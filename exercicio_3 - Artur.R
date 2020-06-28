# Utilizando o banco world do pacote poliscidata, faça um  
# histograma que também indique a média  e um boxplot 
# da variável gini10
# Descreva o que você pode observar a partir deles.

banco <- world

?world

ggplot(banco, aes(gini10)) + 
  geom_histogram() +
  geom_vline(aes(xintercept = mean(gini10, na.rm = T)))


ggplot(banco, aes(gini10)) + 
  geom_boxplot() 


  #RESPOSTA

#No caso do histograma percebe-se que o maior número de ocorrências se dá nos coeficientes de renda gini inferiores a 45, 
#um pouco acima do valor médio, 40. Após o coeficiente 45 a frequencia de ocorrências cai fortemente.Temos uma média pouco 
#superior a 40.

#Com o boxplot observamos detalhes e informações distintas do histograma, como o fato de o 1o quartil estar mais próximo da mediana
#que o 3o quartil.Também percebemos mais facilmente os extremos e os pontos que se destacam da amostra.


# Utilizando as funções de manipulação de dados da aula passada,
# faça uma tabela que sumarize a media (função mean), 
# mediana (funcao median) e o desvio padrão (fundao sd) da 
# renda per capta (variável gdppcap08), agrupada por tipo de regime 
# (variável democ).

banco_rendapercapta_democ <- banco %>% 
  group_by(democ) %>%
    summarise(media = mean(gdppcap08, na.rm = TRUE), 
            mediana = median(gdppcap08, na.rm = TRUE), 
            desviopadrao = sd(gdppcap08, na.rm = TRUE),
            
  ) 

banco_rendapercapta_democ


# Explique a diferença entre valores das médias e medianas.
#RESPOSTA
#As médias se apresentam maiores que as medianas, o que aponta para a existencia de rendimentos muito altos mais 
#de pouca frenquencia. No tocante à mediana, o 1o quartil está mais próximo do que o 3o quartil, o que também reforça
#a maior frenquencia dos rendimentos de menor valor vis-à-vis os de maior valor.
 
# Ilustre com a explicação com gráfico de boxplot.
#RESPOSTA

ggplot(banco, aes(x=gdppcap08))+
  geom_boxplot()

# Os dados corroboram a hipótese da relação entre democracia
# e desempenho economico?

#RESPOSTA
#Sim, tanto as médias como as medianas suportam a hipótese, uma vez que nos países não democráticos observam-se 
#valores mais baixos que nos classificados como democráticos. Mesmo a valor dos desvios-padrao não chegam a 
#afetar a conclusão.  



# Carregue o banco states que está no pacote poliscidata 
# Mantenha apenas as variáveis obama2012, conpct_m, hs_or_more,
# prcapinc, blkpct10, south, religiosity3, state

banco_states <- states %>%
  select(obama2012, conpct_m, hs_or_more,
         prcapinc, blkpct10, south, religiosity3, 
         state)

summary(banco_states)
glimpse(banco_states)
?states


# Carregue o banco nes que está no pacote poliscidata
# Mantenha apenas as variáveis obama_vote, ftgr_cons, dem_educ3,
# income5, black, south, relig_imp, sample_state

banco_nes <- nes %>%
  select(obama_vote, ftgr_cons, dem_educ3,
         income5, black, south, relig_imp, sample_state)

glimpse(banco_nes)

# As variáveis medem os mesmos conceitos, voto no obama em 2012, 
# conservadorismo, educação, renda, cor, norte-sul, 
# religiosidade e estado. A diferença é que o nes é um banco de
# dados com surveys individuais e o states é um banco de dados
# com informações por estado
#
# Faça um gráfico para cada banco representando o nível de
# conservadorismo. Comente as conclusões que podemos ter
# a partir deles sobre o perfil do eleitorado estadunidense.
# Para ajudar, vocês podem ter mais informações sobre os bancos
# de dados digitando ?states e ?nes, para ter uma descrição das
# variáveis


ggplot(banco_states, aes(conpct_m)) + 
  geom_histogram(bins=10)
 

ggplot(banco_nes, aes(ftgr_cons)) + 
  geom_histogram(bins=10) +
  geom_vline(aes(xintercept = mean(ftgr_cons, na.rm = T)))

ggplot(banco_nes, aes(ftgr_cons)) + 
  geom_boxplot()


?states
?nes


#RESPOSTA
#No caso da variável conpct_m, do banco states, podemos observar que a grande maioria dos estados se encontra 
#com níveis de conservadorismo na faixa de 30 a 40%, com cerca de 10% dos estados nos extremos menores que 25% 
#e maiores que 45%. 
#Já para a variável ftgr_cons, do banco nes, relativo aos indivíduos, percebe-se no resultado geral uma certa 
#inclinação conservadora, com uma média superior aos 50% e o intervalo entre os quartis situado majoritariamente 
#para além dos 50%.
#Ou seja, quando tomamos o resultado de grau de conservadorismo dos indivíduos vemos a presença de uma certa tendência 
#conservadora, que se revela mais difusa, menos perceotível quando tomamos os estados, o que provavelmente pode ser 
#explicado pela distribuição irregular dos indivíduos nos estados.

# Qual é o tipo de gráfico apropriado para descrever a variável
# de voto em obama nos dois bancos de dados?
# Justifique e elabore os gráficos

#RESPOSTA
#No caso da variável Obama2012, do banco states, por se tratar de uma variável numérica, o ideal é utilizar os histogramas, as curvas de densidade, boxplots 
#e violins, pois eles revelam informações de posição da variável, diferente do gráfico de barra, que é mais adequado 
#às variáveis categóricas.
#Já para a variável Obama_vote, do banco nes, é mais adequado o uso do gráfico de barra por tratar-se de variável 
#enquadrável na classificação de categórica, neste caso duas categorias, o sim e o não.

ggplot(banco_states, aes(obama2012)) + 
  geom_histogram(aes(y=..density..),      
                 binwidth=5) +
  geom_density() +
  geom_vline(aes(xintercept = mean(obama2012, na.rm = T)))


ggplot(banco_nes, aes(obama_vote, ..count../sum(..count..) )) +
  geom_bar(na.rm = T) +
  scale_y_continuous(labels = percent)



# Crie dois bancos de dados a partir do banco nes, um apenas com
# respondentes negros e outro com não-negros. A partir disso, faça
# dois gráficos com a proporção de votos no obama.
# O que você pode afirmar a partir dos gráficos?
# Você diria que existe uma relação entre voto em Obama e cor?



banco_nes_negros <- banco_nes %>% filter (black=="Yes")

ggplot(banco_nes_negros, aes(obama_vote, ..count../sum(..count..) )) +
  geom_bar(na.rm = T) +
  scale_y_continuous(labels = percent)



banco_nes_nao_negros <- banco_nes %>% filter (black=="No")

ggplot(banco_nes_nao_negros, aes(obama_vote, ..count../sum(..count..) )) +
  geom_bar(na.rm = T) +
  scale_y_continuous(labels = percent)

#RESPOSTAS
#com base nos dois gráficos, observamos que entre os eleitores
#negros a votação em Obama foi maciça e entre os não negros ficou divida, próxima dos 50/50. 
# Tal resultado aponta para uma relação entre o voto em Obama e a cor do eleitor.



# A partir do banco de dados states, faça uma comparação semelhante.
# Faça um gráfico com as porcentagens de votos em Obama para estados
# que estão acima da mediana da porcentagem de população negra nos estados,
# e outro gráfico com as porcentagens de votos em Obama para os estados
# que estão abaixo da mediana de população negra.

summary(banco_states) #Para observar a mediana da variável desejada

negros_acima_da_mediana <- banco_states %>% filter (blkpct10 > 8.25)

ggplot(negros_acima_da_mediana, aes(obama2012)) + 
  geom_histogram(aes(y=..density..),      
                 binwidth=4) +
  geom_density() +
  geom_vline(aes(xintercept = mean(obama2012, na.rm = T)))

ggplot(negros_acima_da_mediana, aes(x=obama2012, y=""))+
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))



negros_abaixo_da_mediana <- banco_states %>% filter(blkpct10 < 8.25)

ggplot(negros_abaixo_da_mediana, aes(obama2012)) + 
  geom_histogram(aes(y=..density..),      
                 binwidth=4) +
  geom_density() +
  geom_vline(aes(xintercept = mean(obama2012, na.rm = T)))

ggplot(negros_abaixo_da_mediana, aes(x=obama2012, y=""))+
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))


# O que você pode afirmar a partir dos gráficos?
# Podemos chegar a mesma conclusão anterior?

#RESPOSTA

#Os gráficos tipo violino demonstram comportamentos distintos entre si, no gráfico do banco negros_acima_da_mediana 
#pode-se observar uma distribuição mais regular dos estados no percentual de votos atribuídos a Obama,
#com limites mais próximos da mediana e equilíbrio entre a mediana e os quartis, além de extremos acima 
#de 30 e abaixo de 65%. O primeiro quartil acima dos 40% e o 3o quartil mais distante da mediana que o 1o, 
#reforça a percepção de robustez de voto na maioria dos estados. Destaca-se também uma discreta concentração 
#de estados atribuindo % na faixa de 40 a 50% a Obama. 

#Já no gráfico que representa a variável obama2012 no banco negros_abaixo_da_mediana 
#observa-se uma distribuição menos homogênea dos estados, com extremos de % de votos mais dilatados, 
#indo de menos de 25% a mais de 70%. O comportamento dos quartis, com o 1o abaixo dos 40% e mais distante 
#da mediana do que o 3o quartil. Percebe-se uma leve concentração de estados na faixa entre os 50 e 60%. 

#Ao comparar os dois gráficos, concluimos que o relação entre a maior ou menor participação dos negros no 
#eleitorado de um estado (utilizando a mediana como ponto de corte) não se relaciona com o voto em Obama 
#de forma tão direta quanto a relação cor do indivíduo x voto, demonstrada nas questões anteriores. Contudo, 
#ao se comparar os dois gráficos, consegue-se identificar um diferença de comportamento entre certa estabilidade 
#na distribuição dos votos, com extremos curtos, no caso dos estados onde a participação negra está acima da mediana, 
#e uma distribuição mais dispersa, mais irregular e com maiores extremos, nos estados com participação negra abaixo
#da mediana. Tal observação pode sugerir que a maior presença negra no eleitorado tende a diminuir os extremos de
#percentual de voto.


# A partir da varíavel X do banco df abaixo

df <- data.frame(x = cos(seq(-50,50,0.5)))


# Faça os tipos de gráficos que representem esse tipo de variável
# comentando as diferenças entre elas e qual seria a mais adequada

ggplot(df, aes(x)) + 
  geom_histogram()
#O histograma tem a qualidade de apresentar a o número de ocorrencias de forma clara, contudo falha em explicitar
#mais informações.

ggplot(df, aes(x)) + 
  geom_density(adjust=0.1)
#Neste caso a curva de densidade apresenta a situação de forma semelhante ao histograma, contudo com a desvantagem
#de não informar a contagem.

ggplot(df, aes(x)) + 
  geom_boxplot()
#O boxplot já nos mostra com precisão a simetria entre os quartis e a mediana, bem como a posição central da mediana 
#em relação a toda a amplitude da variável. O boxplot supera neste caso o histograma e a curva de densidade.

ggplot(df, aes(x,"")) + 
  geom_beeswarm()
#Acrescenta um apoio visual extra ao caso, mas perde em informação para o boxplot.

ggplot(df, aes(x,y="")) + 
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))
#Sem dúvida a opção de gráfico mais adequada para este caso, pois reune as principais informações de todos os 
#gráficos anteriores (histograma, densidade, boxplot e beeswarm), expondo-as com clareza e simplicidade. A única
#perda que ocorre é a explicitação das quantidades, opção só encontrada no histograma.


# responda as questões teóricas abaixo

# QUESTÃO 1 - Observar a figura 1.2 do livro Fundamentals of Political Research e
#fazer o mesmo esquema para o trabalho final de vocês.
                          
#TEORIA CAUSAL: A DESIGUALDADE SOCIAL NOS MUNICÍPIOS (vARIÁVEL INDEPENDENTE - CONCEITO) ESTÁ ASSOCIADA POSITIVAMENTE 
#AO AUMENTO NAS SUAS TAXAS DE VIOLÊNCIA (VARIÁVEL DEPENDENTE - CONCEITO).

#OPERACIONALIZAÇÃO --> HIPÓTESE: O COMPORTAMENTO DOS ÍNDICES GINI, IDH E IVS DOS MUNICÍPIOS (VARIÁVEIS INDEPENDENTES 
#- MENSURADAS) INFLUENCIA SUAS TAXAS DE CVLI (VARIÁVEL DEPENDENTE - MENSURADA). 

# IVS - ÍNDICE DE VULNERABILIDADE SOCIAL
# CVLI - CRIMES VIOLENTOS LETAIS INTENCIONAIS

#Qual é a disponibilidade de dados para sua pesquisa? 
#RESPOSTA - HÁ TABELAS DE FONTES OFICIAIS DISPONÍVEIS NA INTERNET. NESTE CASO A SECRETARIA DE PLANEJAMENTO 
#DO ESTADO DE PERNAMBUCO.
#Já existem bancos de dados prontos? 
#RESPOSTA - NÃO. 
#Você tem acesso a eles? 
#RESPOSTA - NÃO.
#Caso a última pergunta seja positiva, responda o exerício 4 do capítulo 5.
#AS TABELAS POSSUEM DADOS DO ÚLTIMO CENSO, EM 2010, COM AS INFORMAÇÕES SOBRE TODOS OS MUNICÍPIOS DE PERNAMBUCO.
     
#A partir dos exercícios anteriores, escreva sobre a confiabilidade e validade de suas variáveis.
#RESPOSTA - NO QUESITO CONFIABILIDADE TODAS AS VARIÁVEIS SÃO REPRODUZÍVEIS E TESTÁVEIS COM OS DADOS REAIS, DE MODO 
#QUE DIFERENTES PESQUISADORES OBTERIAM MEDIDAS IGUAIS SE AS UTILIZASSEM. 
#NO TOCANTE A VALIDADE DAS VARIÁVEIS, TODAS SÃO UTILIZADAS PELA ACADEMIA E POR ÓRGÃOS OFICIAIS, SUAS CONSTRUÇÕES 
#LÓGICAS SÃO DEFENSÁVEIS E SE ADEQUAM À REPRESENTAÇÃO HONESTA DOS CONCEITOS TEÓRICOS ORA PROPOSTOS. 

#Qual seria a forma ideal e mais adequada de operacionalizar suas variáveis para testar sua hipótese? 
#RESPOSTA - COMO NESTE CASO TANTO AS VARIÁVEIS INDEPENDENTES QUANTO A DEPENDENTE SÃO NUMÉRICAS E CONTÍNUAS, CABERIA 
#NO CASO DE ANÁLISE DE APENAS DUAS DELAS (UMA INDEPENDENTE E UMA DEPENDENTE), O COEFICIENTE DE CORRELAÇÃO OU A 
#REGRESSÃO BIVARIADA. CONTUDO, PARA A OPERACIONALIZAÇÃO DAS MÚLTIPLAS VARIÁVEIS NUMÉRICAS DESTE TRABALHO, O 
#TRATAMENTO MAIS ADEQUADO SUGERE O MODELO DE REGRESSÃO MULTIVARIADO.

PROFESSOR, SE POSSÍVEL, GOSTARIA DE MARCAR UMA VIDEO-REUNIÃO COM O SENHOR NA PRÓXIMA SEXTA, DIA 03/07,
PARA TIRAR DÚVIDAS SOBRE O TRABALHO FINAL DA DISCIPLINA. ATS, ARTUR GUEIROS.
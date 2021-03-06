# Utilizando o banco world do pacote poliscidata, fa�a um  
# histograma que tamb�m indique a m�dia  e um boxplot 
# da vari�vel gini10
# Descreva o que voc� pode observar a partir deles.

banco <- world

?world

ggplot(banco, aes(gini10)) + 
  geom_histogram() +
  geom_vline(aes(xintercept = mean(gini10, na.rm = T)))


ggplot(banco, aes(gini10)) + 
  geom_boxplot() 


  #RESPOSTA

#No caso do histograma percebe-se que o maior n�mero de ocorr�ncias se d� nos coeficientes de renda gini inferiores a 45, 
#um pouco acima do valor m�dio, 40. Ap�s o coeficiente 45 a frequencia de ocorr�ncias cai fortemente.Temos uma m�dia pouco 
#superior a 40.

#Com o boxplot observamos detalhes e informa��es distintas do histograma, como o fato de o 1o quartil estar mais pr�ximo da mediana
#que o 3o quartil.Tamb�m percebemos mais facilmente os extremos e os pontos que se destacam da amostra.


# Utilizando as fun��es de manipula��o de dados da aula passada,
# fa�a uma tabela que sumarize a media (fun��o mean), 
# mediana (funcao median) e o desvio padr�o (fundao sd) da 
# renda per capta (vari�vel gdppcap08), agrupada por tipo de regime 
# (vari�vel democ).

banco_rendapercapta_democ <- banco %>% 
  group_by(democ) %>%
    summarise(media = mean(gdppcap08, na.rm = TRUE), 
            mediana = median(gdppcap08, na.rm = TRUE), 
            desviopadrao = sd(gdppcap08, na.rm = TRUE),
            
  ) 

banco_rendapercapta_democ


# Explique a diferen�a entre valores das m�dias e medianas.
#RESPOSTA
#As m�dias se apresentam maiores que as medianas, o que aponta para a existencia de rendimentos muito altos mais 
#de pouca frenquencia. No tocante � mediana, o 1o quartil est� mais pr�ximo do que o 3o quartil, o que tamb�m refor�a
#a maior frenquencia dos rendimentos de menor valor vis-�-vis os de maior valor.
 
# Ilustre com a explica��o com gr�fico de boxplot.
#RESPOSTA

ggplot(banco, aes(x=gdppcap08))+
  geom_boxplot()

# Os dados corroboram a hip�tese da rela��o entre democracia
# e desempenho economico?

#RESPOSTA
#Sim, tanto as m�dias como as medianas suportam a hip�tese, uma vez que nos pa�ses n�o democr�ticos observam-se 
#valores mais baixos que nos classificados como democr�ticos. Mesmo a valor dos desvios-padrao n�o chegam a 
#afetar a conclus�o.  



# Carregue o banco states que est� no pacote poliscidata 
# Mantenha apenas as vari�veis obama2012, conpct_m, hs_or_more,
# prcapinc, blkpct10, south, religiosity3, state

banco_states <- states %>%
  select(obama2012, conpct_m, hs_or_more,
         prcapinc, blkpct10, south, religiosity3, 
         state)

summary(banco_states)
glimpse(banco_states)
?states


# Carregue o banco nes que est� no pacote poliscidata
# Mantenha apenas as vari�veis obama_vote, ftgr_cons, dem_educ3,
# income5, black, south, relig_imp, sample_state

banco_nes <- nes %>%
  select(obama_vote, ftgr_cons, dem_educ3,
         income5, black, south, relig_imp, sample_state)

glimpse(banco_nes)

# As vari�veis medem os mesmos conceitos, voto no obama em 2012, 
# conservadorismo, educa��o, renda, cor, norte-sul, 
# religiosidade e estado. A diferen�a � que o nes � um banco de
# dados com surveys individuais e o states � um banco de dados
# com informa��es por estado
#
# Fa�a um gr�fico para cada banco representando o n�vel de
# conservadorismo. Comente as conclus�es que podemos ter
# a partir deles sobre o perfil do eleitorado estadunidense.
# Para ajudar, voc�s podem ter mais informa��es sobre os bancos
# de dados digitando ?states e ?nes, para ter uma descri��o das
# vari�veis


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
#No caso da vari�vel conpct_m, do banco states, podemos observar que a grande maioria dos estados se encontra 
#com n�veis de conservadorismo na faixa de 30 a 40%, com cerca de 10% dos estados nos extremos menores que 25% 
#e maiores que 45%. 
#J� para a vari�vel ftgr_cons, do banco nes, relativo aos indiv�duos, percebe-se no resultado geral uma certa 
#inclina��o conservadora, com uma m�dia superior aos 50% e o intervalo entre os quartis situado majoritariamente 
#para al�m dos 50%.
#Ou seja, quando tomamos o resultado de grau de conservadorismo dos indiv�duos vemos a presen�a de uma certa tend�ncia 
#conservadora, que se revela mais difusa, menos perceot�vel quando tomamos os estados, o que provavelmente pode ser 
#explicado pela distribui��o irregular dos indiv�duos nos estados.

# Qual � o tipo de gr�fico apropriado para descrever a vari�vel
# de voto em obama nos dois bancos de dados?
# Justifique e elabore os gr�ficos

#RESPOSTA
#No caso da vari�vel Obama2012, do banco states, por se tratar de uma vari�vel num�rica, o ideal � utilizar os histogramas, as curvas de densidade, boxplots 
#e violins, pois eles revelam informa��es de posi��o da vari�vel, diferente do gr�fico de barra, que � mais adequado 
#�s vari�veis categ�ricas.
#J� para a vari�vel Obama_vote, do banco nes, � mais adequado o uso do gr�fico de barra por tratar-se de vari�vel 
#enquadr�vel na classifica��o de categ�rica, neste caso duas categorias, o sim e o n�o.

ggplot(banco_states, aes(obama2012)) + 
  geom_histogram(aes(y=..density..),      
                 binwidth=5) +
  geom_density() +
  geom_vline(aes(xintercept = mean(obama2012, na.rm = T)))


ggplot(banco_nes, aes(obama_vote, ..count../sum(..count..) )) +
  geom_bar(na.rm = T) +
  scale_y_continuous(labels = percent)



# Crie dois bancos de dados a partir do banco nes, um apenas com
# respondentes negros e outro com n�o-negros. A partir disso, fa�a
# dois gr�ficos com a propor��o de votos no obama.
# O que voc� pode afirmar a partir dos gr�ficos?
# Voc� diria que existe uma rela��o entre voto em Obama e cor?



banco_nes_negros <- banco_nes %>% filter (black=="Yes")

ggplot(banco_nes_negros, aes(obama_vote, ..count../sum(..count..) )) +
  geom_bar(na.rm = T) +
  scale_y_continuous(labels = percent)



banco_nes_nao_negros <- banco_nes %>% filter (black=="No")

ggplot(banco_nes_nao_negros, aes(obama_vote, ..count../sum(..count..) )) +
  geom_bar(na.rm = T) +
  scale_y_continuous(labels = percent)

#RESPOSTAS
#com base nos dois gr�ficos, observamos que entre os eleitores
#negros a vota��o em Obama foi maci�a e entre os n�o negros ficou divida, pr�xima dos 50/50. 
# Tal resultado aponta para uma rela��o entre o voto em Obama e a cor do eleitor.



# A partir do banco de dados states, fa�a uma compara��o semelhante.
# Fa�a um gr�fico com as porcentagens de votos em Obama para estados
# que est�o acima da mediana da porcentagem de popula��o negra nos estados,
# e outro gr�fico com as porcentagens de votos em Obama para os estados
# que est�o abaixo da mediana de popula��o negra.

summary(banco_states) #Para observar a mediana da vari�vel desejada

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


# O que voc� pode afirmar a partir dos gr�ficos?
# Podemos chegar a mesma conclus�o anterior?

#RESPOSTA

#Os gr�ficos tipo violino demonstram comportamentos distintos entre si, no gr�fico do banco negros_acima_da_mediana 
#pode-se observar uma distribui��o mais regular dos estados no percentual de votos atribu�dos a Obama,
#com limites mais pr�ximos da mediana e equil�brio entre a mediana e os quartis, al�m de extremos acima 
#de 30 e abaixo de 65%. O primeiro quartil acima dos 40% e o 3o quartil mais distante da mediana que o 1o, 
#refor�a a percep��o de robustez de voto na maioria dos estados. Destaca-se tamb�m uma discreta concentra��o 
#de estados atribuindo % na faixa de 40 a 50% a Obama. 

#J� no gr�fico que representa a vari�vel obama2012 no banco negros_abaixo_da_mediana 
#observa-se uma distribui��o menos homog�nea dos estados, com extremos de % de votos mais dilatados, 
#indo de menos de 25% a mais de 70%. O comportamento dos quartis, com o 1o abaixo dos 40% e mais distante 
#da mediana do que o 3o quartil. Percebe-se uma leve concentra��o de estados na faixa entre os 50 e 60%. 

#Ao comparar os dois gr�ficos, concluimos que o rela��o entre a maior ou menor participa��o dos negros no 
#eleitorado de um estado (utilizando a mediana como ponto de corte) n�o se relaciona com o voto em Obama 
#de forma t�o direta quanto a rela��o cor do indiv�duo x voto, demonstrada nas quest�es anteriores. Contudo, 
#ao se comparar os dois gr�ficos, consegue-se identificar um diferen�a de comportamento entre certa estabilidade 
#na distribui��o dos votos, com extremos curtos, no caso dos estados onde a participa��o negra est� acima da mediana, 
#e uma distribui��o mais dispersa, mais irregular e com maiores extremos, nos estados com participa��o negra abaixo
#da mediana. Tal observa��o pode sugerir que a maior presen�a negra no eleitorado tende a diminuir os extremos de
#percentual de voto.


# A partir da var�avel X do banco df abaixo

df <- data.frame(x = cos(seq(-50,50,0.5)))


# Fa�a os tipos de gr�ficos que representem esse tipo de vari�vel
# comentando as diferen�as entre elas e qual seria a mais adequada

ggplot(df, aes(x)) + 
  geom_histogram()
#O histograma tem a qualidade de apresentar a o n�mero de ocorrencias de forma clara, contudo falha em explicitar
#mais informa��es.

ggplot(df, aes(x)) + 
  geom_density(adjust=0.1)
#Neste caso a curva de densidade apresenta a situa��o de forma semelhante ao histograma, contudo com a desvantagem
#de n�o informar a contagem.

ggplot(df, aes(x)) + 
  geom_boxplot()
#O boxplot j� nos mostra com precis�o a simetria entre os quartis e a mediana, bem como a posi��o central da mediana 
#em rela��o a toda a amplitude da vari�vel. O boxplot supera neste caso o histograma e a curva de densidade.

ggplot(df, aes(x,"")) + 
  geom_beeswarm()
#Acrescenta um apoio visual extra ao caso, mas perde em informa��o para o boxplot.

ggplot(df, aes(x,y="")) + 
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))
#Sem d�vida a op��o de gr�fico mais adequada para este caso, pois reune as principais informa��es de todos os 
#gr�ficos anteriores (histograma, densidade, boxplot e beeswarm), expondo-as com clareza e simplicidade. A �nica
#perda que ocorre � a explicita��o das quantidades, op��o s� encontrada no histograma.


# responda as quest�es te�ricas abaixo

# QUEST�O 1 - Observar a figura 1.2 do livro Fundamentals of Political Research e
#fazer o mesmo esquema para o trabalho final de voc�s.
                          
#TEORIA CAUSAL: A DESIGUALDADE SOCIAL NOS MUNIC�PIOS (vARI�VEL INDEPENDENTE - CONCEITO) EST� ASSOCIADA POSITIVAMENTE 
#AO AUMENTO NAS SUAS TAXAS DE VIOL�NCIA (VARI�VEL DEPENDENTE - CONCEITO).

#OPERACIONALIZA��O --> HIP�TESE: O COMPORTAMENTO DOS �NDICES GINI, IDH E IVS DOS MUNIC�PIOS (VARI�VEIS INDEPENDENTES 
#- MENSURADAS) INFLUENCIA SUAS TAXAS DE CVLI (VARI�VEL DEPENDENTE - MENSURADA). 

# IVS - �NDICE DE VULNERABILIDADE SOCIAL
# CVLI - CRIMES VIOLENTOS LETAIS INTENCIONAIS

#Qual � a disponibilidade de dados para sua pesquisa? 
#RESPOSTA - H� TABELAS DE FONTES OFICIAIS DISPON�VEIS NA INTERNET. NESTE CASO A SECRETARIA DE PLANEJAMENTO 
#DO ESTADO DE PERNAMBUCO.
#J� existem bancos de dados prontos? 
#RESPOSTA - N�O. 
#Voc� tem acesso a eles? 
#RESPOSTA - N�O.
#Caso a �ltima pergunta seja positiva, responda o exer�cio 4 do cap�tulo 5.
#AS TABELAS POSSUEM DADOS DO �LTIMO CENSO, EM 2010, COM AS INFORMA��ES SOBRE TODOS OS MUNIC�PIOS DE PERNAMBUCO.
     
#A partir dos exerc�cios anteriores, escreva sobre a confiabilidade e validade de suas vari�veis.
#RESPOSTA - NO QUESITO CONFIABILIDADE TODAS AS VARI�VEIS S�O REPRODUZ�VEIS E TEST�VEIS COM OS DADOS REAIS, DE MODO 
#QUE DIFERENTES PESQUISADORES OBTERIAM MEDIDAS IGUAIS SE AS UTILIZASSEM. 
#NO TOCANTE A VALIDADE DAS VARI�VEIS, TODAS S�O UTILIZADAS PELA ACADEMIA E POR �RG�OS OFICIAIS, SUAS CONSTRU��ES 
#L�GICAS S�O DEFENS�VEIS E SE ADEQUAM � REPRESENTA��O HONESTA DOS CONCEITOS TE�RICOS ORA PROPOSTOS. 

#Qual seria a forma ideal e mais adequada de operacionalizar suas vari�veis para testar sua hip�tese? 
#RESPOSTA - COMO NESTE CASO TANTO AS VARI�VEIS INDEPENDENTES QUANTO A DEPENDENTE S�O NUM�RICAS E CONT�NUAS, CABERIA 
#NO CASO DE AN�LISE DE APENAS DUAS DELAS (UMA INDEPENDENTE E UMA DEPENDENTE), O COEFICIENTE DE CORRELA��O OU A 
#REGRESS�O BIVARIADA. CONTUDO, PARA A OPERACIONALIZA��O DAS M�LTIPLAS VARI�VEIS NUM�RICAS DESTE TRABALHO, O 
#TRATAMENTO MAIS ADEQUADO SUGERE O MODELO DE REGRESS�O MULTIVARIADO.

PROFESSOR, SE POSS�VEL, GOSTARIA DE MARCAR UMA VIDEO-REUNI�O COM O SENHOR NA PR�XIMA SEXTA, DIA 03/07,
PARA TIRAR D�VIDAS SOBRE O TRABALHO FINAL DA DISCIPLINA. ATS, ARTUR GUEIROS.
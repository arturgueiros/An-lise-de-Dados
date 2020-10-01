Exercício 10
================
Artur Gueiros

### Continuaremos com a utilização dos dados do ESEB2018. Carregue o banco da mesma forma que nos exercicios anteriores

``` r
library(tidyverse)
library(haven)

link <- "https://github.com/MartinsRodrigo/Analise-de-dados/blob/master/04622.sav?raw=true"

download.file(link, "04622.sav", mode = "wb")

banco <- read_spss("04622.sav") 

banco <- banco %>%
  mutate(D10 = as_factor(D10)) %>%
  filter(Q18 < 11,
         D9 < 9999998,
         Q1501 < 11,
         Q12P2_B < 3) %>%
  mutate(Q12P2_B = case_when(Q12P2_B == 1 ~ 0,  # Quem votou em Haddad = 0
                             Q12P2_B == 2 ~ 1)) # Quem votou em Bolsonaro = 1
```

### Crie a mesma variável de religião utilizada no exercício anterior

``` r
Outras <- levels(banco$D10)[-c(3,5,13)]

banco <- banco %>%
  mutate(religiao = case_when(D10 %in% Outras ~ "Outras",
                              D10 == "Católica" ~ "Católica",
                              D10 == "Evangélica" ~ "Evangélica",
                              D10 == "Não tem religião" ~ "Não tem religião"))
```

### Faça uma regressão linear utilizando as mesmas variáveis do exercício 9 - idade(D1A\_ID), educação (D3\_ESCOLA), renda (D9), nota atribuída ao PT (Q1501), auto-atribuição ideológica (Q18), sexo (D2\_SEXO) e religião (variável criada no passo anterior) - explicam o voto em Bolsonaro (Q12P2\_B).

``` r
regressao <- lm( Q12P2_B ~ D1A_ID + D3_ESCOLA +  D9 + Q1501 + Q18 + D2_SEXO + religiao, data = banco)

summary(regressao)
```

    ## 
    ## Call:
    ## lm(formula = Q12P2_B ~ D1A_ID + D3_ESCOLA + D9 + Q1501 + Q18 + 
    ##     D2_SEXO + religiao, data = banco)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.05532 -0.19854  0.01565  0.16182  0.96682 
    ## 
    ## Coefficients:
    ##                            Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)               7.067e-01  6.469e-02  10.924  < 2e-16 ***
    ## D1A_ID                    1.140e-03  7.539e-04   1.512  0.13074    
    ## D3_ESCOLA                 5.547e-03  5.226e-03   1.061  0.28873    
    ## D9                       -9.837e-07  3.196e-06  -0.308  0.75832    
    ## Q1501                    -7.728e-02  2.799e-03 -27.610  < 2e-16 ***
    ## Q18                       2.651e-02  3.093e-03   8.570  < 2e-16 ***
    ## D2_SEXO                  -5.286e-02  2.089e-02  -2.530  0.01154 *  
    ## religiaoEvangélica        7.684e-02  2.363e-02   3.251  0.00118 ** 
    ## religiaoNão tem religião -2.746e-03  4.238e-02  -0.065  0.94835    
    ## religiaoOutras           -7.263e-02  3.678e-02  -1.975  0.04855 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.3489 on 1138 degrees of freedom
    ## Multiple R-squared:  0.5028, Adjusted R-squared:  0.4989 
    ## F-statistic: 127.9 on 9 and 1138 DF,  p-value: < 2.2e-16

``` r
confint(regressao)
```

    ##                                  2.5 %        97.5 %
    ## (Intercept)               5.797291e-01  8.335766e-01
    ## D1A_ID                   -3.390684e-04  2.619271e-03
    ## D3_ESCOLA                -4.706619e-03  1.579994e-02
    ## D9                       -7.254959e-06  5.287609e-06
    ## Q1501                    -8.277435e-02 -7.179045e-02
    ## Q18                       2.044034e-02  3.257857e-02
    ## D2_SEXO                  -9.385894e-02 -1.186744e-02
    ## religiaoEvangélica        3.046538e-02  1.232064e-01
    ## religiaoNão tem religião -8.589165e-02  8.039968e-02
    ## religiaoOutras           -1.447902e-01 -4.633807e-04

### Interprete o resultado dos coeficientes

`Intercepto` - É positivo e possui significância estatística com p-valor
menor que 0,05. Varia entre 0,5797 e 0,83357, com intervalo de confiança
de 95%.

`D1A_ID` - O coeficiente referente à variável idade (D1A\_ID) é positivo
e não apresenta significância estatística para o modelo, com p-valor
alto, acima de 0,05.

`D3_ESCOLA` - Já o coeficiente da variável escolaridade (D3\_ESCOLA) é
positivo, sem apresentar significância estatística, conforme seu
p-valor, de 0,28.

`D9` - O coeficiente de regressão de renda (D9) é negativo e não
apresenta significância estatística, com p-valor bem acima de 0,05.

`Q1501` - O coeficiente beta ligado à nota dada ao PT (Q1501) é negativo
e apresenta forte significância estatística. Cada unidade a mais na nota
dada ao PT, diminui em 0,07728 a inclinação de voto em Bolsonaro. O
coeficiente de rergressão varia entre -0,08277 e -0,07179, com 95% de
intervalo de confiança.

`Q18` - No caso do coeficiente da auto-atribuição ideológica (Q18),
temos uma associação positiva , onde uma unidade da variável explicativa
altera o comportamento da variável dependente em 0,02651. O coeficiente
de rergressão varia entre 0,02044 e 0,03257, com 95% de intervalo de
confiança.

`D2_SEXO` - O coeficiente beta da variável sexo (D2\_SEXO) possui
significância estatística, com p-valor abaixo de 0,05. Ele é negativo, e
mostra que para cada variação de unidade sua, quando comparado à
categoria de referência “Homem”, a inclinação de voto em Bolsonaro
diminui em 0,05286, com intervalo de confiança de 95% variando entre
0,0938 e 0,0118. Com isso pode-se inferir que o eleitorado feminino teve
menos inclinação a votar em Bolsonaro que o eleitorado masculino.

`religiaoEvangelica` - O coeficiente de regressão da variável
religiaoEvangelica é positivo e possui significância estatística, com
p-valor abaixo de 0,05. O beta mostra que para cada variação de unidade
sua, quando comparado à categoria de referência “religiaoCatolica”, a
inclinação de voto em Bolsonaro aumenta em 0,07684, com intervalo de
confiança de 95% variando entre 0,03046 e 0,1232. Com isso pode-se
inferir que o eleitorado evangélico teve inclinação a votar em Bolsonaro
quando comparado ao eleitorado católico.

`religiaoNão tem religião` - O coeficiente de regressão da variável
religiaoNão tem religião não possui significância estatística, com
p-valor bem cima de 0,05. O beta mostra que para cada variação de
unidade sua, quando comparado à categoria de referência
“religiaoCatolica”, a inclinação de voto em Bolsonaro diminui em
0,00274. Como o beta não tem significância estatística não podemos
inferir com segurança que o eleitorado sem religião teve menos
inclinação a votar em Bolsonaro que o eleitorado católico.

`religiaoOutras` - O coeficiente de regressão da variável religiaoOutras
é negativo e possui significância estatística, com p-valor abaixo de
0,05. O beta mostra que para cada variação de unidade sua, quando
comparado à categoria de referência “religiaoCatolica”, a inclinação de
voto em Bolsonaro diminui em 0,07263, com intervalo de confiança de 95%
variando entre -0,1447 e -0,0004. Com isso pode-se inferir que o
eleitorado com religiaoOutras teve menos inclinação a votar em Bolsonaro
quando comparado ao eleitorado católico.

### O resultado difere dos encontrados anteriormente, quando a variavel dependente era a aprovação de Bolsonaro?

De modo geral, sim. As variáveis independentes idade e escolaridade, no
modelo que utiliza a variável voto em Bolsonaro (Q12P2\_B) como
dependente, não possuem significância estatística, enquanto que no
modelo com a variável aprovação a Bolsonaro (Q1607), tanto a idade como
a escolaridade têm significância, ainda que fraca, no caso da variável
idade. Já os coeficientes das variáveis renda e religiaoNãotemreligiao
não apresentam significância estatística em nenhum dos dois modelos.
Dentre as variáveis que apresentam significância estatística nos dois
modelos (PT, ideologia, sexo e religiaoEvangelica), temos que no modelo
que utiliza a aprovação de Bolsonaro como variável dependente os valores
dos coeficientes de regressão são sempre mais significativos, maiores,
que no modelo que tem no voto por Bolsonaro sua variável dependente,
apesar de terem sempre a mesma direção (positiva ou negativa) nos dois
modelos. Quanto ao R-quadrado, o modelo com voto como variável
dependente apresenta valor de 0,50, enquanto que o modelo focado na
aprovação registra 0,30 de r-quadrado. O erro residual padrão do modelo
com a variável de aprovação (3,297) é bem maior que o modelo concorrente
(0,3489).

### Faça uma regressão logistica com as mesmas variaveis

``` r
regressao_logistica <- glm(Q12P2_B ~ D1A_ID + D3_ESCOLA +  D9 + Q1501 + Q18 + D2_SEXO + religiao, 
                            data = banco, family = "binomial")

summary(regressao_logistica)
```

    ## 
    ## Call:
    ## glm(formula = Q12P2_B ~ D1A_ID + D3_ESCOLA + D9 + Q1501 + Q18 + 
    ##     D2_SEXO + religiao, family = "binomial", data = banco)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.7529  -0.5625   0.2518   0.4744   2.5830  
    ## 
    ## Coefficients:
    ##                            Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)               8.209e-01  5.298e-01   1.550  0.12124    
    ## D1A_ID                    1.001e-02  6.337e-03   1.580  0.11405    
    ## D3_ESCOLA                 5.634e-02  4.358e-02   1.293  0.19602    
    ## D9                       -4.635e-06  2.396e-05  -0.193  0.84660    
    ## Q1501                    -4.678e-01  2.666e-02 -17.545  < 2e-16 ***
    ## Q18                       2.242e-01  2.748e-02   8.159 3.37e-16 ***
    ## D2_SEXO                  -4.497e-01  1.739e-01  -2.586  0.00971 ** 
    ## religiaoEvangélica        6.217e-01  1.985e-01   3.132  0.00173 ** 
    ## religiaoNão tem religião -2.106e-02  3.478e-01  -0.061  0.95172    
    ## religiaoOutras           -6.736e-01  3.122e-01  -2.158  0.03096 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 1557.84  on 1147  degrees of freedom
    ## Residual deviance:  862.45  on 1138  degrees of freedom
    ## AIC: 882.45
    ## 
    ## Number of Fisher Scoring iterations: 5

``` r
confint(regressao_logistica)
```

    ##                                  2.5 %        97.5 %
    ## (Intercept)              -2.142372e-01  1.8651175312
    ## D1A_ID                   -2.356414e-03  0.0225104510
    ## D3_ESCOLA                -2.904377e-02  0.1419781422
    ## D9                       -5.246385e-05  0.0000439274
    ## Q1501                    -5.216537e-01 -0.4170089828
    ## Q18                       1.712127e-01  0.2790743125
    ## D2_SEXO                  -7.919817e-01 -0.1094958073
    ## religiaoEvangélica        2.343309e-01  1.0132294124
    ## religiaoNão tem religião -7.028094e-01  0.6619336806
    ## religiaoOutras           -1.287535e+00 -0.0625502790

``` r
library(pscl)

pR2(regressao_logistica)
```

    ## fitting null model for pseudo-r2

    ##          llh      llhNull           G2     McFadden         r2ML         r2CU 
    ## -431.2245843 -778.9190068  695.3888450    0.4463807    0.4543292    0.6118347

### Transforme os coeficientes estimados em probabilidade

``` r
library(margins)

margins(regressao_logistica)
```

    ##    D1A_ID D3_ESCOLA         D9    Q1501     Q18 D2_SEXO religiaoEvangélica
    ##  0.001171  0.006589 -5.421e-07 -0.05471 0.02622 -0.0526            0.07346
    ##  religiaoNão tem religião religiaoOutras
    ##                 -0.002521       -0.08172

``` r
summary(margins(regressao_logistica))
```

    ##                    factor     AME     SE        z      p   lower   upper
    ##                    D1A_ID  0.0012 0.0007   1.5849 0.1130 -0.0003  0.0026
    ##                   D2_SEXO -0.0526 0.0202  -2.6078 0.0091 -0.0921 -0.0131
    ##                 D3_ESCOLA  0.0066 0.0051   1.2949 0.1953 -0.0034  0.0166
    ##                        D9 -0.0000 0.0000  -0.1935 0.8466 -0.0000  0.0000
    ##                     Q1501 -0.0547 0.0009 -57.9079 0.0000 -0.0566 -0.0529
    ##                       Q18  0.0262 0.0030   8.8434 0.0000  0.0204  0.0320
    ##        religiaoEvangélica  0.0735 0.0235   3.1280 0.0018  0.0274  0.1195
    ##  religiaoNão tem religião -0.0025 0.0417  -0.0605 0.9517 -0.0842  0.0791
    ##            religiaoOutras -0.0817 0.0379  -2.1574 0.0310 -0.1560 -0.0075

### Quais foram as diferenças no resultado entre usar a regressão linear e a logistica?

Os resultados gerais foram muito similares, com as variáveis idade,
escolaridade, renda e indivíduos sem religião não apresentando
significância estatística em ambos os modelos, e com as variáveis nota
PT, auto-atribuição ideológica, sexo, religiaoEvangelica e
religiaoOutras chegando a valores tanto dos coeficientes (pela
probabilidade média, no caso da regressão logística) quanto das margens
de erro bastante próximos entre si, de forma especial nos casos de
ideologia, sexo, com valores quase idênticos (0,0265 x 0,0262, no caso
da nota PT, e -0,0528 x -0,0526, no caso da variável sexo). O r-quadrado
da regressão linear e o pseudo r-quadrado (índice McFadden) da regressão
logística foram de 0,50 e 0,44, respectivamente, também próximos.

### Verifique a quantidade de classificações corretas da regressao logistica e avalie o resultado

``` r
predicted_prob <- predict(regressao_logistica, type = "response")

library(InformationValue)

1 - misClassError(banco$Q12P2_B, 
                  predicted_prob, 
                  threshold = 0.5)
```

    ## [1] 0.8301

``` r
opt_cutoff <- optimalCutoff(banco$Q12P2_B, 
                            predicted_prob)

confusionMatrix(banco$Q12P2_B, 
              predicted_prob, 
              threshold = opt_cutoff)
```

    ##     0   1
    ## 0 393 105
    ## 1  83 567

``` r
prop.table(confusionMatrix(banco$Q12P2_B, 
                predicted_prob, 
                threshold = opt_cutoff))
```

    ##            0          1
    ## 0 0.34233449 0.09146341
    ## 1 0.07229965 0.49390244

A regressão logística obteve 960 classificações corretas de um total de
1148, ou seja, acertou 83,6% das estimativas, um resultado geral
positivo, que permite uma utilização satisfatória do modelo para
previsão em casos assemelhados.

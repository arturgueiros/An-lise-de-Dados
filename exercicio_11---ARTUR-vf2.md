Exercício 11
================
Artur Gueiros

``` r
library(tidyverse)
library(haven)

link <- "https://github.com/MartinsRodrigo/Analise-de-dados/blob/master/04622.sav?raw=true"

download.file(link, "04622.sav", mode = "wb")

banco <- read_spss("04622.sav") 

banco <- banco %>%
  mutate(D10 = as_factor(D10)) %>%
  filter(Q1607 < 11, 
         Q18 < 11,
         D9 < 9999998,
         Q1501 < 11)


Outras <- levels(banco$D10)[-c(3,5,13)]

banco <- banco %>%
  mutate(religiao = case_when(D10 %in% Outras ~ "Outras",
                              D10 == "Católica" ~ "Católica",
                              D10 == "Evangélica" ~ "Evangélica",
                              D10 == "Não tem religião" ~ "Não tem religião"))
```

### Faça uma regressão linear avaliando em que medida as variáveis independentes utilizadas nos exercícios 7 e 8, idade(D1A\_ID), educação (D3\_ESCOLA), renda (D9), nota atribuída ao PT (Q1501), auto-atribuição ideológica (Q18), sexo (D2\_SEXO) e religião (variável criada no passo anterior) explicam a avaliação de Bolsonaro (Q1607)

``` r
regressao <- lm(Q1607 ~ D1A_ID + D3_ESCOLA +  D9 + Q1501 + Q18 + D2_SEXO + religiao, data = banco)

summary(regressao)
```

    ## 
    ## Call:
    ## lm(formula = Q1607 ~ D1A_ID + D3_ESCOLA + D9 + Q1501 + Q18 + 
    ##     D2_SEXO + religiao, data = banco)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -9.0608 -2.5654  0.4179  2.3268  8.9954 
    ## 
    ## Coefficients:
    ##                            Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)               6.216e+00  5.365e-01  11.586  < 2e-16 ***
    ## D1A_ID                    1.040e-02  6.234e-03   1.669 0.095376 .  
    ## D3_ESCOLA                -1.116e-01  4.486e-02  -2.487 0.012982 *  
    ## D9                       -3.620e-05  2.764e-05  -1.309 0.190576    
    ## Q1501                    -3.946e-01  2.367e-02 -16.670  < 2e-16 ***
    ## Q18                       3.161e-01  2.603e-02  12.142  < 2e-16 ***
    ## D2_SEXO                  -6.874e-01  1.746e-01  -3.937 8.63e-05 ***
    ## religiaoEvangélica        6.685e-01  1.984e-01   3.370 0.000772 ***
    ## religiaoNão tem religião -7.565e-02  3.485e-01  -0.217 0.828177    
    ## religiaoOutras           -8.326e-01  3.081e-01  -2.702 0.006963 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 3.296 on 1452 degrees of freedom
    ## Multiple R-squared:  0.3018, Adjusted R-squared:  0.2975 
    ## F-statistic: 69.75 on 9 and 1452 DF,  p-value: < 2.2e-16

``` r
confint(regressao)
```

    ##                                  2.5 %        97.5 %
    ## (Intercept)               5.163593e+00  7.268474e+00
    ## D1A_ID                   -1.825450e-03  2.263208e-02
    ## D3_ESCOLA                -1.995985e-01 -2.358624e-02
    ## D9                       -9.042202e-05  1.802617e-05
    ## Q1501                    -4.410748e-01 -3.481971e-01
    ## Q18                       2.650155e-01  3.671471e-01
    ## D2_SEXO                  -1.029800e+00 -3.449144e-01
    ## religiaoEvangélica        2.793625e-01  1.057711e+00
    ## religiaoNão tem religião -7.592162e-01  6.079222e-01
    ## religiaoOutras           -1.436872e+00 -2.282460e-01

### Faça o teste de homoscedasticidade do modelo e corrija as estimações dos coeficientes caso seja necessário.

``` r
plot(regressao, 3)
```

![](exercicio_11---ARTUR-vf2_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
plot(regressao, 1)
```

![](exercicio_11---ARTUR-vf2_files/figure-gfm/unnamed-chunk-3-2.png)<!-- -->

``` r
library(lmtest)

bptest(regressao)
```

    ## 
    ##  studentized Breusch-Pagan test
    ## 
    ## data:  regressao
    ## BP = 65.763, df = 9, p-value = 1.025e-10

``` r
library(car)

ncvTest(regressao)
```

    ## Non-constant Variance Score Test 
    ## Variance formula: ~ fitted.values 
    ## Chisquare = 22.48512, Df = 1, p = 2.1178e-06

``` r
library(sandwich)

coeftest(regressao, 
         vcov = vcovHC(regressao, type = "HC3"))
```

    ## 
    ## t test of coefficients:
    ## 
    ##                             Estimate  Std. Error  t value  Pr(>|t|)    
    ## (Intercept)               6.2160e+00  5.4715e-01  11.3607 < 2.2e-16 ***
    ## D1A_ID                    1.0403e-02  6.2657e-03   1.6603 0.0970600 .  
    ## D3_ESCOLA                -1.1159e-01  4.7247e-02  -2.3619 0.0183123 *  
    ## D9                       -3.6198e-05  3.6481e-05  -0.9922 0.3212463    
    ## Q1501                    -3.9464e-01  2.6381e-02 -14.9593 < 2.2e-16 ***
    ## Q18                       3.1608e-01  2.8534e-02  11.0772 < 2.2e-16 ***
    ## D2_SEXO                  -6.8736e-01  1.7967e-01  -3.8256 0.0001360 ***
    ## religiaoEvangélica        6.6854e-01  1.9676e-01   3.3978 0.0006978 ***
    ## religiaoNão tem religião -7.5647e-02  3.7488e-01  -0.2018 0.8401094    
    ## religiaoOutras           -8.3256e-01  3.0592e-01  -2.7215 0.0065759 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Após gerar e analisar os gráficos plot 3 (Scale-location) e plot 1
(Residuals vs. Fitted), bem como os testes bptest e ncvTest, conclui-se
que o modelo é heterocedástico. No primeiro gráfico a distribuição dos
pontos não é uniforme nem ao longo do eixo x nem do eixo y. Já no
segundo gráfico, os pontos não estão igualmente distribuídos ao longo da
linha horizontal.Quanto aos dois testes, bp e ncv, temos que os
p-valores encontrados são ambos abaixo de 0,05 e excluem a hipótese
nula, neste caso, excluem a possibilidade de homocedasticidade no
modelo. Com base na identificação da existência de heterocedasticidade,
buscamos lidar com esse problema procedendo ao ajuste ou correção das
estimações dos coeficientes da regressão, de modo a obtermos intervalos
de confiança melhores e mais confiáveis, usando o teste coeftest.
Aplicamos todas as variações do argumento type (HC0,HC1,…,HC5), sem que
nenhuma delas tenha se provado significativamente superior ao tipo de
correção padrão HC3.

### Avalie a multicolinearidade entre as variáveis

``` r
library(car)

vif(regressao)
```

    ##               GVIF Df GVIF^(1/(2*Df))
    ## D1A_ID    1.219401  1        1.104265
    ## D3_ESCOLA 1.337368  1        1.156446
    ## D9        1.094849  1        1.046350
    ## Q1501     1.119818  1        1.058215
    ## Q18       1.049195  1        1.024302
    ## D2_SEXO   1.023001  1        1.011435
    ## religiao  1.093846  3        1.015062

Observando-se o VIF das variáveis independentes, identificamos que em
todos os casos os valores do vif são baixos, muito próximos de 1,0 (um),
o que nos garante que a multicolinearidade não é significativa entre as
variáveis do modelo, e não será um obstáculo nas estimativas. Apenas se
os valores vif de pelo menos uma das variáveis fosse alto, distante de
1,0, é que teríamos razão de preocupação com a multicolinearidade.

### Verifique a presença de outilier ou observações influentes no modelo

``` r
plot(regressao, 4)
```

![](exercicio_11---ARTUR-vf2_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
plot(regressao, 5)
```

![](exercicio_11---ARTUR-vf2_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

``` r
library(car)

outlierTest(regressao)
```

    ## No Studentized residuals with Bonferroni p < 0.05
    ## Largest |rstudent|:
    ##     rstudent unadjusted p-value Bonferroni p
    ## 271 -2.76344          0.0057918           NA

Após aplicação e análise dos gráficos plot 4 (Cook´s distance) e plot 5
(Residuals vs. Leverage), podemos identificar a existência de um outlier
principal, mais influente, localizado na observação 1442.
Adicionalmente, a utilização do teste outlierTest, onde o p-valor
corrigido pelo ajuste de Bonferroni é baixo, de 0,005791 reforça a
certeza da existência de observação caracterizada como destoante ou
influente no modelo.

### Faça a regressao linear sem a observação mais influente e avalie a alteração do resultado

``` r
banco <-banco %>%
  slice(-c(1442))

regressao <- lm(Q1607 ~ D1A_ID + D3_ESCOLA +  D9 + Q1501 + Q18 + D2_SEXO + religiao, data = banco)

summary(regressao)
```

    ## 
    ## Call:
    ## lm(formula = Q1607 ~ D1A_ID + D3_ESCOLA + D9 + Q1501 + Q18 + 
    ##     D2_SEXO + religiao, data = banco)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -9.1171 -2.4749  0.3718  2.3110  8.9899 
    ## 
    ## Coefficients:
    ##                            Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)               6.240e+00  5.360e-01  11.640  < 2e-16 ***
    ## D1A_ID                    1.133e-02  6.243e-03   1.814 0.069827 .  
    ## D3_ESCOLA                -1.022e-01  4.504e-02  -2.268 0.023446 *  
    ## D9                       -6.396e-05  3.071e-05  -2.083 0.037444 *  
    ## Q1501                    -3.975e-01  2.369e-02 -16.781  < 2e-16 ***
    ## Q18                       3.157e-01  2.600e-02  12.139  < 2e-16 ***
    ## D2_SEXO                  -7.080e-01  1.747e-01  -4.053 5.31e-05 ***
    ## religiaoEvangélica        6.807e-01  1.983e-01   3.433 0.000613 ***
    ## religiaoNão tem religião -6.671e-02  3.481e-01  -0.192 0.848065    
    ## religiaoOutras           -8.193e-01  3.078e-01  -2.662 0.007855 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 3.292 on 1451 degrees of freedom
    ## Multiple R-squared:  0.3037, Adjusted R-squared:  0.2994 
    ## F-statistic: 70.32 on 9 and 1451 DF,  p-value: < 2.2e-16

``` r
confint(regressao)
```

    ##                                  2.5 %        97.5 %
    ## (Intercept)               5.1881599346  7.291154e+00
    ## D1A_ID                   -0.0009191759  2.357380e-02
    ## D3_ESCOLA                -0.1905433536 -1.382343e-02
    ## D9                       -0.0001241896 -3.721752e-06
    ## Q1501                    -0.4439634654 -3.510312e-01
    ## Q18                       0.2646570828  3.666770e-01
    ## D2_SEXO                  -1.0506119099 -3.653745e-01
    ## religiaoEvangélica        0.2917926586  1.069610e+00
    ## religiaoNão tem religião -0.7495599507  6.161484e-01
    ## religiaoOutras           -1.4230914394 -2.155616e-01

Com a exclusão da observação mais destoante observa-se como alteração
mais relevante no resultado da regressão a reabilitação da variável
renda (D9), a qual passa agora a ter significância estatística, com
p-valor baixo, de 0,0374, tornando-se assim relevante como parâmetro de
estimação no modelo. O coeficiente beta da variável renda é negativo no
valor de -6.396e-05, variando entre -0.0001241896 e -3.721752e-06, num
intervalo de confiança de 95%. As demais medidas do modelo não se
alteram de forma relevante com a retirada do outlier.

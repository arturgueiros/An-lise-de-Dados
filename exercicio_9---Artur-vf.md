Exercício 9
================
Artur Gueiros

### Continuaremos com a utilização dos dados do ESEB2018. Carregue o banco da mesma forma que nos exercicios anteriores

``` r
library(tidyverse)
library(haven)
library(scales)


link <- "https://github.com/MartinsRodrigo/Analise-de-dados/blob/master/04622.sav?raw=true"

download.file(link, "04622.sav", mode = "wb")

banco <- read_spss("04622.sav") 

banco <- banco %>%
  mutate(D10 = as_factor(D10)) %>%
  filter(Q1607 < 11, 
         Q18 < 11,
         D9 < 9999998,
         Q1501 < 11)
```

### Crie a mesma variável de religião utilizada no exercício anterior

``` r
Outras <- levels(banco$D10)[-c(3,5,13)]

banco <- banco %>%
  mutate(religiao = case_when(D10 %in% Outras ~ "Outras",
                              D10 == "Católica" ~ "Católica",
                              D10 == "Evangélica" ~ "Evangélica",
                              D10 == "Não tem religião" ~ "Não tem religião"))


ggplot(banco, aes(religiao, ..count../sum(..count..) )) +
  geom_bar() +
  scale_y_continuous(labels = percent)
```

![](exercicio_9---Artur-vf_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

### Faça uma regressão linear avaliando em que medida as variáveis independentes utilizadas nos exercícios 7 e 8, idade(D1A\_ID), educação (D3\_ESCOLA), renda (D9), nota atribuída ao PT (Q1501), auto-atribuição ideológica (Q18), sexo (D2\_SEXO) e religião (variável criada no passo anterior) explicam a avaliação de Bolsonaro (Q1607), mas com uma interação entre as variáveis religião e sexo. Exiba o resultado da regressão e interprete os valores dos coeficientes \(\beta\)s estimados.

``` r
regressao <- lm(Q1607 ~ D1A_ID + D3_ESCOLA + D9 + Q1501 + Q18 + D2_SEXO + religiao + D2_SEXO * religiao, data = banco)
summary (regressao)
```

    ## 
    ## Call:
    ## lm(formula = Q1607 ~ D1A_ID + D3_ESCOLA + D9 + Q1501 + Q18 + 
    ##     D2_SEXO + religiao + D2_SEXO * religiao, data = banco)
    ## 
    ## Residuals:
    ##    Min     1Q Median     3Q    Max 
    ## -8.942 -2.561  0.361  2.303  9.052 
    ## 
    ## Coefficients:
    ##                                    Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)                       6.114e+00  5.915e-01  10.338   <2e-16 ***
    ## D1A_ID                            1.065e-02  6.255e-03   1.703   0.0888 .  
    ## D3_ESCOLA                        -1.134e-01  4.491e-02  -2.524   0.0117 *  
    ## D9                               -3.632e-05  2.768e-05  -1.312   0.1897    
    ## Q1501                            -3.956e-01  2.370e-02 -16.696   <2e-16 ***
    ## Q18                               3.150e-01  2.607e-02  12.083   <2e-16 ***
    ## D2_SEXO                          -6.115e-01  2.438e-01  -2.508   0.0122 *  
    ## religiaoEvangélica                1.181e+00  6.146e-01   1.921   0.0549 .  
    ## religiaoNão tem religião          1.986e-01  1.059e+00   0.188   0.8512    
    ## religiaoOutras                   -1.583e+00  9.503e-01  -1.666   0.0960 .  
    ## D2_SEXO:religiaoEvangélica       -3.412e-01  3.895e-01  -0.876   0.3812    
    ## D2_SEXO:religiaoNão tem religião -1.889e-01  6.979e-01  -0.271   0.7867    
    ## D2_SEXO:religiaoOutras            5.041e-01  6.067e-01   0.831   0.4062    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 3.297 on 1449 degrees of freedom
    ## Multiple R-squared:  0.3028, Adjusted R-squared:  0.297 
    ## F-statistic: 52.44 on 12 and 1449 DF,  p-value: < 2.2e-16

``` r
confint(regressao, level = 0.95)
```

    ##                                          2.5 %        97.5 %
    ## (Intercept)                       4.954254e+00  7.274692e+00
    ## D1A_ID                           -1.616843e-03  2.292432e-02
    ## D3_ESCOLA                        -2.014868e-01 -2.527982e-02
    ## D9                               -9.061286e-05  1.797812e-05
    ## Q1501                            -4.421265e-01 -3.491597e-01
    ## Q18                               2.638804e-01  3.661651e-01
    ## D2_SEXO                          -1.089711e+00 -1.332397e-01
    ## religiaoEvangélica               -2.490748e-02  2.386365e+00
    ## religiaoNão tem religião         -1.877835e+00  2.275016e+00
    ## religiaoOutras                   -3.447227e+00  2.810461e-01
    ## D2_SEXO:religiaoEvangélica       -1.105272e+00  4.228513e-01
    ## D2_SEXO:religiaoNão tem religião -1.557861e+00  1.180062e+00
    ## D2_SEXO:religiaoOutras           -6.860878e-01  1.694284e+00

`D1A_ID` - O coeficiente referente à variável idade (D1A\_ID) é
positivo, de modo que para cada unidade a mais dele a avaliação de
Bolsonaro variaria positivamente 0,01065, com erro-padrão de 0,0062.

`D9` - O coeficiente de regressão de renda (D9) é negativo, de valor
-3.632e-05.

`D3_ESCOLA` - Já o coeficiente da variável escolaridade (D3\_ESCOLA) é
também negativo, O beta varia entre -0,201 e -0,025, com 95% de
intervalo de confiança. Ou seja, para cada unidade de escolaridade a
mais, a nota de bolsonaro varia -0,1134.

`Q1501` - O coeficiente beta ligado à nota dada ao PT (Q1501) é
negativo. Para cada unidade a mais na nota dada ao PT, varia
negativamente em 0,395 a nota dada a Bolsonaro.

`Q18` - No caso do coeficiente da auto-atribuição ideológica (Q18),
temos uma associação positiva , onde uma unidade da variável explicativa
altera o comportamento da variável dependente em 0,315.

`D2_SEXO` - Quanto ao coeficiente da variável sexo (D2\_SEXO) inferimos
que comparado ao resultado do sexo masculino na variável dependente, o
sexo feminino tem um coeficiente de -0,6115, ou seja o efeito do sexo
feminino na avaliação de Bolsonaro é sempre negativo numa magnitude de
0,61 quando comparado ao efeito do sexo masculino.

`religiaoEvangélica` - comparado ao resultado da religião católica
(categoria de referência do modelo) na variável dependente, a religião
evangélica tem um coeficiente de 1,181, ou seja o efeito da religião
evangélica na avaliação de Bolsonaro é sempre positivo numa magnitude de
1,181 quando comparado ao efeito da religião católica.

`religiaoNão tem religião` - comparado ao resultado da religião católica
(categoria de referência do modelo) na variável dependente, a categoria
“não tem religião” tem um coeficiente de 0,198, ou seja o efeito dos
sem religião na avaliação de Bolsonaro é sempre positivo numa magnitude
de 0,198 quando comparado ao efeito da religião católica.

`religiaoOutras` - comparado ao resultado da religião católica
(categoria de referência do modelo) na variável dependente, a categoria
“outras” tem um coeficiente de -1,583, ou seja o efeito das outras
religiões na avaliação de Bolsonaro é sempre negativo numa magnitude de
1,583 quando comparado ao efeito da religião católica.

`D2_SEXO:religiaoEvangélica` - O efeito da categoria combinada “mulher
evangélica” na avaliação de Bolsonaro é de -0,34 quando comparado ao
efeito do comportamento do homem católico.

`D2_SEXO:religiaoNão tem religião` - O efeito da categoria combinada
“mulher sem religião” na avaliação de Bolsonaro é de -0,188 em relação
ao efeito da variável homem católico na nota de Bolsonaro.

`D2_SEXO:religiaoOutras` - O efeito das “mulheres de outras religiões”
na avaliação de Bolsonaro é de 0,504 quando comparado ao efeito da
variável homem católico na nota de Bolsonaro.

### Interprete a significancia estatística dos coeficientes estimados

`D1A_ID` - O coeficiente estimado não apresenta significância
estatística, considerado seu p-valor.

`D9` - Sem significancia estatística, com p-valor alto de 0,189.

`D3_ESCOLA` - O beta possui significância estatística, com p-valor de
0,0117.

`Q1501` - Possui forte significância estatística.

`Q18` - Significante estatisticamente, com p-valor muito baixo.

`D2_SEXO` - significante estatisticamente, com p-valor de 0,0122.

`religiaoEvangélica` - com baixa ou nenhuma significância estatística, a
depender do intervalo de confiança utilizado ser de 90% ou de 95%, o
p-valor foi de acima de 0,055.

`religiaoNão tem religião` - não possui significância estatística
alguma, com p-valor de 0,851.

`religiaoOutras` - com baixa ou nenhuma significância estatística, a
depender do intervalo de confiança utilizado ser de 90% ou de 95%, o
p-valor foi de acima de 0,096.

`D2_SEXO:religiaoEvangélica` / `D2_SEXO:religiaoNão tem religião` /
`D2_SEXO:religiaoOutras`- Não cabe falar em significância estatística,
que stricto sensu, pelo p-valor alto, seria nula para todas as variáveis
criadas por meio de interação. A efetividade e substantividade da
variável de interação no modelo não está atrelada ao p-valor, mas ao
fato de seus efeitos, incluindo suas margens de erro, serem suficientes,
reais e estatisticamente identificados, neste caso, por meio de
gráficos.

### Faça um gráfico que mostre a interação entre as duas variáveis. Interprete o resultado apresentado

``` r
library(sjPlot)

plot_model(regressao, type = "pred", 
           terms = c("religiao", "D2_SEXO"), 
           ci.lvl = 0.9)
```

![](exercicio_9---Artur-vf_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Com o auxílio do gráfico, e utilizando um intervalo de confiança de 90%,
podemos inferir que a interação das variáveis D2\_sexo e religião dentro
do modelo gera duas combinações válidas, as que utilizam a categoria
“evangélicos” e a categoria “católicos”. As demais categorias,
“outras” e “não tem religião”, não podem ser consideradas, uma vez
que suas margens de erro dos componentes masculino e feminino se
sobrepõem, negando a existência de significância estatística. No caso
de se utilzar um intervalo de confiança de 95%, apenas a categoria
religião “evangélica” mantém a significância.

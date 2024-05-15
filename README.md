# SVPI-TP1
Detection and processing of images with Barcodes and QR codes

## Objetivo
Desenvolvimento de um programa em Matlab para fazer análise de imagens que contêm códigos de barras
lineares, códigos matriciais (QR codes) e outros objetos sem significado. O programa deve ser capaz de
interpretar imagens fornecidas e de gerar os resultados pedidos conforme descrito adiante. Serão dadas
imagens exemplo para permitir o desenvolvimento, mas as imagens usadas para obter os resultados de
avaliação serão novas.


![svpi2024_TP1_img_330_01](https://github.com/Nunoc99/SVPI-TP1/assets/114221939/3b3bc746-0495-42d6-804e-593d72aaa9e8)

 
## Parâmetros a detetar em cada imagem
Em cada imagem, os principais parâmetros e características a detetar pelo programa do aluno são:
+ Número total de objetos sem significado.
+ Número total de códigos de barras.
+ Número total de códigos matriciais.
+ Número de códigos de barras em cada uma das 4 orientações possíveis.
+ Número de códigos de barras válidos com reflexão axial.
+ Número de códigos de barras inválidos de acordo com o enunciado.
+ Número total acumulado de dígitos representados nos códigos de barras válidos.
+ Número de códigos de barras válidos em cada uma das 3 codificações possíveis (’L’, ’R’, ’G’).
+ String com os dígitos centrais dos códigos de barras válidos ordenados de forma crescente.



![Capturar](https://github.com/Nunoc99/SVPI-TP1/assets/114221939/306f631a-995d-4163-9e90-d72609854b31)


## Os códigos de barras
Neste trabalho, os códigos de barras traduzem grupos de dígitos decimais. Cada dígito é representado
por um conjunto de 7 barras pretas ou brancas. Existem várias formas de codificação dos dígitos, sendo
uma delas a codificação ’L’. Se uma barra branca for representada por um ’1’ e uma barra preta por um
’0’, então o código para representar por exemplo o dígito ’5’, na codificação ’L’, será o seguinte: 1 0 0
1 1 1 0. Cada grupo de dígitos é delimitado por um código de início (start) e um código de fim (end);
estes códigos são diferentes entre si.
+ O código delimitador de início é dado por: 0 0 1 0 1 1 0 1 1 1 0 (onze barras)
+ O código delimitador de fim é dado por: 0 1 1 1 0 0 0 1 0 1 0 0 (doze barras)


![image](https://github.com/Nunoc99/SVPI-TP1/assets/114221939/75055310-b6d7-4ad0-b4a8-d14aefc11b64)


# SVPI-TP1
Detection and processing of images with Barcodes and QR codes

## Goal
Development of a Matlab program to analyse images containing linear barcodes, QR codes and some meaningless objects. 
The program must be able to read supplied images and generate the requested results as described below.

> _**PT**_
>
> _Desenvolvimento de um programa em Matlab para fazer análise de imagens que contêm códigos de barras
lineares, códigos matriciais (QR codes) e outros objetos sem significado. O programa deve ser capaz de
interpretar imagens fornecidas e de gerar os resultados pedidos conforme descrito adiante. Serão dadas
imagens exemplo para permitir o desenvolvimento, mas as imagens usadas para obter os resultados de
avaliação serão novas._


![svpi2024_TP1_img_330_01](https://github.com/Nunoc99/SVPI-TP1/assets/114221939/3b3bc746-0495-42d6-804e-593d72aaa9e8)

*Figure 1*
 
## Parameters to detect in each image
In each image, the main parameters and caracteristics that the program has to detect are:
+ Total number of meaningless objects.
+ Total number of barcodes.
+ Total number of QR codes.
+ Number of barcodes in each of the 4 possible orientations.
+ Number of valid barcodes with axial reflection.
+ Number of invalid barcodes according to the statment.
+ Total cumulative number of digits represented in valid barcodes.
+ Number of valid barcodes in each of the 3 possible encodings (’L’, ’R’, ’G’).
+ String with the central digits of the valid barcodes sorted in ascending order.

> _**PT**_
>
> _Em cada imagem, os principais parâmetros e características a detetar pelo programa do aluno são:_
> + _Número total de objetos sem significado._
> + _Número total de códigos de barras._
> + _Número total de códigos matriciais._
> + _Número de códigos de barras em cada uma das 4 orientações possíveis._
> + _Número de códigos de barras válidos com reflexão axial._
> + _Número de códigos de barras inválidos de acordo com o enunciado._
> + _Número total acumulado de dígitos representados nos códigos de barras válidos._
> + _Número de códigos de barras válidos em cada uma das 3 codificações possíveis (’L’, ’R’, ’G’)._
> + _String com os dígitos centrais dos códigos de barras válidos ordenados de forma crescente._


![Capturar](https://github.com/Nunoc99/SVPI-TP1/assets/114221939/306f631a-995d-4163-9e90-d72609854b31)

*Figure 2*

## The Barcodes
In this project, the barcodes translate groups of decimal digits. Each digit is represented by a set of 7
black of white bars. There are various digit encoding ways, one of them is the ’L’ enconding. If a white bar 
is represented by ’1’ and a black one by ’0’. then the code to represent, for example, the digit ’5’, in the 
’L’ encoding, would be: 1 0 0 1 1 1 0. Each group of digits is delimited by a start code and an end code; 
these codes are different from each other.

+ The start delimiter code is given by: 0 0 1 0 1 1 0 1 1 1 0 (eleven bars)
+ The end delimiter code is given by: 0 1 1 1 0 0 0 0 1 0 1 0 0 (twelve bars)

> _**PT**_
>
> _Neste trabalho, os códigos de barras traduzem grupos de dígitos decimais. Cada dígito é representado
por um conjunto de 7 barras pretas ou brancas. Existem várias formas de codificação dos dígitos, sendo
uma delas a codificação ’L’. Se uma barra branca for representada por um ’1’ e uma barra preta por um
’0’, então o código para representar por exemplo o dígito ’5’, na codificação ’L’, será o seguinte: 1 0 0
1 1 1 0. Cada grupo de dígitos é delimitado por um código de início (start) e um código de fim (end);
estes códigos são diferentes entre si._
> 
> + _O código delimitador de início é dado por: 0 0 1 0 1 1 0 1 1 1 0 (onze barras)_
> + _O código delimitador de fim é dado por: 0 1 1 1 0 0 0 1 0 1 0 0 (doze barras)_

![image](https://github.com/Nunoc99/SVPI-TP1/assets/114221939/75055310-b6d7-4ad0-b4a8-d14aefc11b64)

*Figure 3*

## Variables to get from each object
+ **NumMec** - Number of the student.
+ **NumSeq** - Image sequence number (Gf. image's filename)
+ **NumImg** - Image number in the sequence (Gf. image's filename).
+ **TotNM** - Number of meaningless objects.
+ **TotCB** - Total number of objects with barcodes.
+ **TotQR** - Total number of objects with QR codes.
+ **R0** - Number of barcodes in 0° orientation.
+ **R90** - Number of barcodes in 90° orientation.
+ **R180** - Number of barcodes in 180° orientation.
+ **R270** - Number of barcodes in 270° orientation.
+ **ReflCB** - Number of valid barcodes with axial reflection.
+ **BadCB** - Number of invalid barcodes.
+ **TotDigCB** - Total cumulative number of digits represented in valid barcodes.
+ **CBL** - Number of valid barcodes in ‘L’ coding.
+ **CBR** - Number of valid barcodes in ‘R’ coding.
+ **CBG** - Number of valid barcodes in ‘G’ coding.
+ **StringCB** - String with the central digits of the valid barcodes sorted in ascending order.

> _**PT**_
> + _**NumMec** - Número mecanográfico do aluno._
> + _**NumSeq** - Número da sequência da imagem (Cf. nome do ficheiro de imagem)._
> + _**NumImg** - Número da imagem na sequência (Cf. nome do ficheiro de imagem)._
> + _**TotNM** - Número de objetos sem significado._
> + _**TotCB** - Número total de objetos com códigos de barras._
> + _**TotQR** - Número total de objetos com QR codes._
> + _**R0** - Número de códigos de barra na orientação de 0°._
> + _**R90** - Número de códigos de barra na orientação de 90°._
> + _**R180** - Número de códigos de barra na orientação de 180°._
> + _**R270** - Número de códigos de barra na orientação de 270°._
> + _**ReflCB** - Número de códigos de barras válidos com reflexão axial._
> + _**BadCB** - Número de códigos de barras inválidos._
> + _**TotDigCB** - Número total acumulado de dígitos representados nos códigos de barras válidos._
> + _**CBL** - Número de códigos de barras válidos na codificação ’L’._
> + _**CBR** - Número de códigos de barras válidos na codificação ’R’._
> + _**CBG** - Número de códigos de barras válidos na codificação ’G’._
> + _**StringCB** - String com os dígitos centrais dos códigos de barras válidos ordenados crescentes._


## RESULTS
Visual demonstration of the program working.

On the left there's a figure with 6 subplots where it can be seen the original image, then the whole image treatment process to isolate the image's objects from the background, through binarization and edge detection process it was able to delete the noise in the background.

On the right side of the picture, there's a figure with, in this case, 32 subplots because in this image there are 32 objects in the image, know that, the image subplot size addpats to the number of objects in the image. From this image, each object will be analyzed 1 by 1 to get all the parameters in question, this means, each identified barcode will go through a process of 4 types of scaling, 4 types of rotation and 3 types of axial reflection and it will stop when the barcode is in the correct scale, orientation and if there is a axial reflection or not. Now, for the QR codes, each one will also go through a process of 4 types of scaling and 4 types of orientation till it founds it's correct scale and orientation, then, get it's properties.

At the bottom of the picture, there is a txt file which is created when the program ends. It has in sequence, separated by commas, the values of each parameter.

![setup](https://github.com/Nunoc99/SVPI-TP1/assets/114221939/68917b7a-296c-45d2-bec9-b803da5c5c24)
*Figure 4*

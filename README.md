# SVPI-TP1
Detection and processing of images with Barcodes and QR codes

Desenvolvimento de um programa em Matlab para fazer análise de imagens que contêm códigos de barras
lineares, códigos matriciais (QR codes) e outros objetos sem significado. O programa deve ser capaz de
interpretar imagens fornecidas e de gerar os resultados pedidos conforme descrito adiante. Serão dadas
imagens exemplo para permitir o desenvolvimento, mas as imagens usadas para obter os resultados de
avaliação serão novas.
 
Parâmetros a detetar em cada imagem
Em cada imagem, os principais parâmetros e características a detetar pelo programa do aluno são:
• Número total de objetos sem significado.
• Número total de códigos de barras.
• Número total de códigos matriciais.
• Número de códigos de barras em cada uma das 4 orientações possíveis.
• Número de códigos de barras válidos com reflexão axial.
• Número de códigos de barras inválidos de acordo com o enunciado.
• Número total acumulado de dígitos representados nos códigos de barras válidos.
• Número de códigos de barras válidos em cada uma das 3 codificações possíveis (’L’, ’R’, ’G’).
• String com os dígitos centrais dos códigos de barras válidos ordenados de forma crescente.

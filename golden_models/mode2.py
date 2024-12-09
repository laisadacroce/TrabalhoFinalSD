#uma entrada por vez em forma de vetor
#somar so tudo (32 nums) entrada em binario (256 bits)

#sum 16 valores de H e armazena, depoi srecebe V(e soma seus valores)
#dividir por 32
#resultadp bin (8 bits)

#Modo 2 - Golden Model
import random

for f in range(3):
    teste = []
    input = ""
    for i in range(32):
        x = random.randint(0,255)
        teste.append(x)
        input += str((bin(x)[2:]).zfill(8))

    resultado = (bin(int(sum(teste)/32))[2:]).zfill(8)

    print(input)
    print(resultado)

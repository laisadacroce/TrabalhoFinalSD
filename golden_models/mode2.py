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

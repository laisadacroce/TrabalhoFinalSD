#Calculo das constantes H e V - Golden Model
import random

#Funcao de conversao para C2:
C2 = lambda num, bits: bin((num + (1 << bits)) % (1 << bits))[2:].zfill(bits)

#Gera 3 casos de teste aleatorios

for _ in range(3):
    print(f"\nTeste {_+1}")
    sample = []
    input = ""

    #Selecionando os nums e preparando o vetor de input p/ o testbench
    for n in range(17): #16 de H/V + canto
        x = random.randint(0, 255)
        sample.append(x)
        input += str((bin(x)[2:]).zfill(8))

    #Realizando o calculo
    HV_sum = 0
    for i in range(8):
        HV_sum += (i + 1)*(sample[i+8] - sample[6 - 1])

    HV_bin = C2(HV_sum, 15)

    print(input)
    print(HV_bin)

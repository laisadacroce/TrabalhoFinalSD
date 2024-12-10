#ABC Constants - Golden Model
import random
from itertools import islice

'''
Resumo:

Recebe os valores de H e V, realiza o calculo de a, b e c

Entrada: vetores de 15 bits H e V + ultimos bytes de cada amostra
Saida: tres nums sinalizados, a (14 bits), b (11 bits) e c (11 bits)

* a so depende dos ultimos bytes da amostra
* b e c fazem o mesmo calculo, mas mudando a entrada
'''

C2 = lambda num, bits: bin((num + (1 << bits)) % (1 << bits))[2:].zfill(bits)

'''
A funcao randHV gera valores para serem usados nos inputs como H e V
Esses valores sao calculados assim para garantir que estarao dentro do
escopo de representacao real do codigo, para o resultado do calculo de HV
'''
def randHV():
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

    return sample[16], HV_sum

#Informacoes sobre a saida
print("Para cada teste serao exibidos, respectivamente, os valores de:"
      "\nH_value"
      "\nV_value"
      "\nH_byte15"
      "\nV_byte15"
      "\na"
      "\nb"
      "\nc")

#Gera 3 casos de teste aleatorios
for _ in range(3):
    print(f"\nTeste {_+1}")
    H_byte15, H = randHV()
    V_byte15, V = randHV()

    #Calculo de B e C
    b = ''.join(islice(str(C2((5 * H + 32), 17)), 11))
    c = ''.join(islice(str(C2((5 * V + 32), 17)), 11))

    #Calculo de A
    a = C2((16 * (H_byte15 + V_byte15)), 14) #Esse valor sempre sera positivo

    #Exibindo os valores das variaveis
    print(C2(H, 15))
    print(C2(V, 15))
    print(C2(H_byte15, 8))
    print(C2(V_byte15, 8))
    print(a)
    print(b)
    print(c)

import random
from math import floor
from itertools import islice

C2 = lambda num, bits: bin((num + (1 << bits)) % (1 << bits))[2:].zfill(bits)


def rand_abc():
    H_byte15, H = rand_HV()
    V_byte15, V = rand_HV()
    a = 16*(H_byte15 + V_byte15)
    b = floor((5*H + 32)/(2**6))
    c = floor((5*V + 32)/(2**6))
    return a, b, c

def rand_HV():
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

def clip(number) -> int:
    if number > 255:
        return 255
    elif number < 0:
        return 0
    else:
        return number

num_tests = 3

print("Para cada teste serao exibidos, respectivamente, os valores de:")
print("a\nb\nc\nx\ny\nplane")

for _ in range(num_tests):
    a, b, c = rand_abc()
    x = random.randint(0, 15)
    y = random.randint(0, 15)
    prediction = clip(floor((a + b * (x - 7) + c*(y - 7) + 16)/(2**5)))
    print()
    print(f"Teste {_ + 1}")
    print()
    print(C2(a, 14))
    print(C2(b, 11))
    print(C2(c, 11))
    print(C2(x, 4))
    print(C2(y, 4))
    print(C2(prediction, 8))
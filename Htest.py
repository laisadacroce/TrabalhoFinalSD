maior_valor = 0
for i in range(8):
    maior_valor += (i+1)*255

b = 5*maior_valor + 32

print(b)
b2 = b//(2^6)
print(b2)


menor_valor = 0
for i in range(8):
    menor_valor += (i + 1)*(-255)

b = 5*menor_valor + 32
print(b)

b2 = b//(2^6)
print(b2)
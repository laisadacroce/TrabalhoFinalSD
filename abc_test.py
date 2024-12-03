import numpy as np
from math import floor

def c2(value, bit_length):
    """Converte um inteiro para complemento de 2 em binário usando NumPy."""
    return np.binary_repr(value, width=bit_length)

H_value=V_value=9180


a = 16*(255 + 255)
b = floor((5 * H_value + 32)/(2**6))
c = floor((5 * V_value + 32)/(2**6))

H_value=V_value=c2(9180, 15)

a = c2(a, 14)
b = c2(b, 11)
c = c2(c, 11)

print(H_value)
print(V_value)

H_byte15 = c2(255, 8)
V_byte15 = c2(255, 8)
print(H_byte15)
print(V_byte15)

print(a)
print(b)
print(c)
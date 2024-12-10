import numpy as np
from math import floor

def c2(value, bit_length) -> str:
    """Converte um inteiro para complemento de 2 em binário usando NumPy."""
    return np.binary_repr(value, width=bit_length)

def clip(number) -> int:
    if number > 255:
        return 255
    elif number < 0:
        return 0
    else:
        return number;

HV_sample = [0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0] #17 samples
HV_sum = 0

for i in range(8):
    HV_sum += (i + 1)*(HV_sample[i + 8] - HV_sample[6 - i])

HV_value = HV_sum
H_value=V_value=HV_value


a = 16*(HV_sample[15] + HV_sample[15])
b = floor((5 * H_value + 32)/(2**6))
c = floor((5 * V_value + 32)/(2**6))

H_value=V_value=c2(9180, 15)



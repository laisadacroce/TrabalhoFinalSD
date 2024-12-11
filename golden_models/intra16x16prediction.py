from random import randint
from math import floor


def rand_samples() -> tuple:
    H_sample = []
    V_sample = []
    corner_sample = randint(0, 255)
    for i in range(16):
        H_sample.append(randint(0, 255))
        V_sample.append(randint(0, 255))

    return V_sample, H_sample, corner_sample

def rand_mode() -> int:
    return randint(0, 3)


def HV(V_sample, H_sample, corner_sample) -> tuple:
    V = 0
    H = 0
    V_sample_copy = V_sample.copy()
    H_sample_copy = H_sample.copy()
    V_sample_copy.insert(0, corner_sample)
    H_sample_copy.insert(0, corner_sample)
    for i in range(7):
        V += (i + 1)*(V_sample_copy[8 + (i + 1)] - V_sample_copy[6 - (i + 1)])
        H += (i + 1)*(H_sample_copy[8 + (i + 1)] - H_sample_copy[6 - (i + 1)])
    
    return V, H

def abc(V_sample, V_value, H_sample, H_value) -> tuple:
    a = 16*[V_sample[15] + H_sample[15]]
    b = floor((5*H_value + 32)/(2**6))
    c = floor((5*V_value + 32)/(2**6))
    return a, b, c

def mode0(V_sample):
    pass

def mode1(H_sample):
    pass

def mode2(V_sample, H_sample):
    pass

def mode3(a, b, c, y):
    pass

V_sample, H_sample, corner_sample = rand_samples()
V, H = HV(V_sample, H_sample, corner_sample)
print(V_sample, H_sample)
print(len(V_sample), len(H_sample))


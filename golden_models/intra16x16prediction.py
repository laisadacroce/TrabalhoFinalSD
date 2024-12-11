from random import randint
from math import floor

def clip(number) -> int:
    if number > 255:
        return 255
    elif number < 0:
        return 0
    else:
        return number

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
    a = 16*(V_sample[15] + H_sample[15])
    b = floor((5*H_value + 32)/(2**6))
    c = floor((5*V_value + 32)/(2**6))
    return a, b, c

def mode0(H_sample) -> list:
    return H_sample

def mode1(V_sample) -> list:
    return V_sample

def mode2(V_sample, H_sample) -> int:
    sum_V_sample = 0
    sum_H_sample = 0
    total = 0
    for i in range(16):
        sum_V_sample += V_sample[i]
        sum_H_sample += H_sample[i]
    
    total = sum_V_sample + sum_H_sample
    dc = floor((total + 16)/(2**5))
    return dc

def mode3(a, b, c, x, y) -> int:
    return clip(floor((a + b * (x - 7) + c * (y - 7) + 16)/(2**5)))

def generate_matrix(V_sample, H_sample, corner_sample, mode) -> list:
    matrix = list()
    if mode == 0:
        for i in range(16):
            line = mode0(H_sample)
            matrix.append(line)
    elif mode == 1:
        for i in range(16):
            line = mode1(V_sample)
            matrix.append(line)
    elif mode == 2:
        byte = mode2(V_sample, H_sample)
        
        for i in range(16):
            line = list()
            for j in range(16):
                line.append(byte)
            matrix.append(line)
    elif mode == 3:
        V, H = HV(V_sample, H_sample, corner_sample)
        a, b, c = abc(V_sample, V, H_sample, H)

        for i in range(16):
            line = list()
            for j in range(16):
                byte = mode3(a, b, c, i, j)
                line.append(byte)
            matrix.append(line)
    return matrix

def print_matrix(matrix):
    for i in range(len(matrix)):
        for j in range(len(matrix)):
            print(matrix[i][j], end=" ")
        print()

def int_to_8bit_binary(number) -> str:
    if not (0 <= number <= 255):
        raise ValueError("Number must be an unsigned 8-bit integer (0-255).")

    return f"{number:08b}"

def generate_binary_matrix(matrix) -> str:
    binary_string = ""
    for i in range(16):
        for j in range(16):
            binary_element = int_to_8bit_binary(matrix[i][j])
            binary_string += binary_element
    
    return binary_string

def print_binary_string_by_lines(binary_string, line_length=128):
    """
    Prints a binary string line by line.

    Parameters:
        binary_string (str): The binary string to print.
        line_length (int): The length of each line (default is 128, for a 16x16 matrix).
    """
    for i in range(0, len(binary_string), line_length):
        print(binary_string[i:i+line_length])

def string_to_int_list(binary_string):
    """
    Converts a 128-bit binary string into a list of 16 integers.

    Parameters:
        binary_string (str): A binary string of length 128.

    Returns:
        list[int]: A list of 16 integers, each representing 8 bits of the string.

    Raises:
        ValueError: If the string is not 128 bits long.
    """
    if len(binary_string) != 128:
        raise ValueError("Binary string must be exactly 128 bits long.")

    return [int(binary_string[i:i+8], 2) for i in range(0, 128, 8)]

def int_list_to_string(int_list):
    """
    Converts a list of 16 integers into a 128-bit binary string.

    Parameters:
        int_list (list[int]): A list of 16 integers (0-255).

    Returns:
        str: A binary string of length 128.

    Raises:
        ValueError: If the list does not contain exactly 16 integers or if any integer is out of range.
    """
    if len(int_list) != 16:
        raise ValueError("List must contain exactly 16 integers.")

    return ''.join(int_to_8bit_binary(number) for number in int_list)



V_sample, H_sample, corner_sample = rand_samples()
mode = rand_mode()
matrix = generate_matrix(V_sample, H_sample, corner_sample, mode)
print()
print(f"Teste mostrado respectivamente em V_sample, H_sample, corner_sample, mode, line(y=0 até y=15) ")
print()
print(int_list_to_string(V_sample))
print(int_list_to_string(H_sample))
print(int_to_8bit_binary(corner_sample))
print(mode)
#print_matrix(matrix)
print_binary_string_by_lines(generate_binary_matrix(matrix))
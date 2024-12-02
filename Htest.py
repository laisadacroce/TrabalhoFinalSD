H_sample = [0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0] #17 samples
H_sum = 0

for i in range(8):
    H_sum += (i + 1)*(H_sample[i + 8] - H_sample[6 - i])

H_value = H_sum
print(H_value)
HV_sample = [0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0] #17 samples
HV_sum = 0

for i in range(8):
    HV_sum += (i + 1)*(HV_sample[i + 8] - HV_sample[6 - i])

HV_value = HV_sum
print(HV_value)
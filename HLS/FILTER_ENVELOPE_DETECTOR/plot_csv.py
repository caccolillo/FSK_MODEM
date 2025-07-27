import csv
import matplotlib.pyplot as plt

# Path to your CSV file
csv_file = 'step_response.csv'

samples = []
output_float = []

# Read the CSV file
with open(csv_file, 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        samples.append(int(row['Sample']))
        output_float.append(float(row['Output']))

# Plotting
plt.figure(figsize=(10, 6))
plt.plot(samples, output_float, marker='o', linestyle='-')
plt.title('Step Response')
plt.xlabel('Sample')
plt.ylabel('Output')
plt.grid(True)
plt.tight_layout()
plt.show()


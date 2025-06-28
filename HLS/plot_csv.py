import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV file
df = pd.read_csv("step_response.csv")

# Extract columns
samples = df["Sample"]
output_float = df["Output_Float"]

# Plot
plt.figure(figsize=(10, 5))
plt.plot(samples, output_float, marker='o', linestyle='-', color='b', label="Step Response")

plt.title("IIR Filter Step Response")
plt.xlabel("Sample")
plt.ylabel("Amplitude")
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.show()


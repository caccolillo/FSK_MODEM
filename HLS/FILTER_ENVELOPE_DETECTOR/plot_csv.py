import pandas as pd
import matplotlib.pyplot as plt
import os

# Load CSV safely
csv_path = "step_response.csv"
if not os.path.exists(csv_path):
    raise FileNotFoundError(f"CSV file not found: {csv_path}")

# Read data
df = pd.read_csv(csv_path)

# Extract columns
samples = df["Sample"]
output_q31 = df["Output_Q31"]

# Plot Q31 output
plt.figure(figsize=(10, 5))
plt.plot(samples, output_q31, marker='o', linestyle='-', color='g', label="Step Response (Q31)")

# Formatting
plt.title("IIR Filter Step Response (Q31)")
plt.xlabel("Sample")
plt.ylabel("Amplitude (Q31 Units)")
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.show()


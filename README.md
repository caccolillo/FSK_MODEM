# FSK_MODEM

A Frequency Shift Keying (FSK) modem project built using **Simulink**, **Vivado**, and **Vivado HLS**.  
It includes models, testbenches, synthesizable IP, and documentation for implementing a full FSK modulation/demodulation chain on FPGA.

---

## 📁 Repository Structure

| Path                         | Description                                      |
|-----------------------------|--------------------------------------------------|
| `SIMULINK/`                 | Simulink models of FSK modulator and demodulator |
| `HLS/`                      | Vivado HLS projects and C/C++ code for IP cores  |
| `VIVADO/`                   | Vivado project(s) with RTL, constraints, and block designs |
| `FFT_BASED_FSK_DEMODULATOR.pdf` | Report on an FFT-based demodulation method      |
| `FSK_MODEM.pdf`              | General documentation on the FSK modem design    |
| `main.pdf`                   | Overview of the entire project                   |
| `Makefile`                   | Make targets for automating build/sim/synthesis  |
| `prj.sh`                     | Script to initialize Vivado projects             |
| `.gitignore`                 | Standard ignore rules                           |

---

## ⚙️ Features

- Binary FSK modulation and demodulation
- FFT-based demodulator approach
- Simulink-based simulation and verification
- HLS-based IP generation
- Vivado integration for FPGA synthesis and implementation
- Accompanying technical documentation

---

## 🚀 Getting Started

### Prerequisites

- MATLAB/Simulink
- Xilinx Vivado
- Vivado HLS
- Bash + GNU Make

### Setup

```bash
git clone https://github.com/caccolillo/FSK_MODEM.git
cd FSK_MODEM
make run


# Autonomous FPGA Robot Project

This repository contains the Vivado hardware design and Vitis software for an autonomous robot using the PYNQ-Z2 (Zynq-7000) platform.

## 🛠 Project Structure
* `/TFG_IP`: Custom IP repository (HCRS04, L293D, etc.).
* `/software`: C/C++ source code for the Zynq ARM processor.
* `design_1.bd`: The Vivado Block Design.
* `design_1_wrapper.vhd`: Top-level HDL wrapper.
* `constrains.xdc`: FPGA pin assignments (Constraints).
* `design_1_wrapper.xsa`: Hardware handoff file for Vitis.
* `rebuild_project.tcl`: Script to recreate the entire Vivado project.

## 🚀 How to Rebuild the Project

### 1. Vivado Hardware Setup
1. Open **Vivado 2022.1** (or compatible version).
2. In the TCL Console, navigate to the folder were u downladed the project and use the comand line TCL:
   ```tcl
   source rebuild_project.tcl
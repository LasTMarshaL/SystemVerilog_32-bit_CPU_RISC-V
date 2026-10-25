# SystemVerilog_32-bit_CPU_RISC-V
Previous CPU version modernization to the RISC-V standard and C-development

## 📌About
This branch contains a CPU (developed previously) to implement some elementary commands and explore CPU architecture, modernized to RISC-V standard. (**!Development stage!**)

## 🗂️ Repository Structure
* **`SystemVerilog_8-bit_CPU/`** - Hardware description (architecture) and TB files for simulations amd tests.
* **`SystemVerilog_32-bit_CPU_RISC-V_Modernization`** - Documentation and theoretical description.
  
## ⚙️ Short Hardware Overview
* **Selected FPGA:** Artix-7.
  
## 💻 Short Software Overview
* **Architecture:** Hardware description is constructed by SystemVerilog Hardware Description Language in Vivado development environment.
* **Digital Simulation:** Digital simulation is implemented by Vivado Simulator.
* **Compiler and architecture standard:** GCC & RISC-V used.
* **Hardware Simulation:** Hardware simulation will be executed by QEMU.

## ⚠️ Safety Notice
* ⚠️!The author bears no responsibility for the reader's actions!⚠️

## 🚀 Roadmap
* **CPU Moduludus Modernization**
- [X] ALU (Mathematical & Logical commands/calculations).
- [X] Regsiter File (Registers read/write control).
- [X] Data Memory (Read/write constants & variables).
- [X] Instruction Memory (Read/write instructions).
- [50/50] Program Counter (Instruction address tracking & flow control).
- [ ] Control Unit (Instructions decoding & distribution).
- [ ] CPU TOP (Unite all parts & data transfer).
* These are current tasks (goals), the next stage will be connecting RISC-V standard compilator to translate C commands into machine code and launch sterling PL <-> CPU interaction.
  
## 🧪 Used Technologies & Software
* Vivado (Development environment)
* SystemVerilog (Hardware description)
* Vivado Simulator (Digital simulation)
* Toolchain (RISC-V)
* VS Code (C-development, Assembler-development)
* QEMU (Hardware simulation)

## !At the development stage plans and used tools can be changed!




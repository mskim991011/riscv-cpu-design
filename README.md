# 32-bit Single-Cycle RISC-V CPU (RV32I) Architecture Design

## Project Overview
This project presents the comprehensive **Register-Transfer Level (RTL) design and implementation of a 32-bit Single-Cycle RISC-V Processor** using **SystemVerilog**. Based on the standard RV32I Base Integer Instruction Set, the CPU is meticulously architected to execute a full spectrum of instructions within a single clock cycle. 

The objective of this project is to demonstrate an advanced understanding of computer architecture, moving from theoretical Von Neumann and Harvard concepts to designing a functional, full-scale datapath and control unit capable of running compiled C programs.

---

## Project Motivation & Background
The primary motivation for this project is to build a profound understanding of computer architecture at the hardware level, which is an essential foundation for advanced digital circuit and SoC (System-on-Chip) design. 

With the rapid rise of custom silicon and AI semiconductors, open-source ISAs (Instruction Set Architectures) like RISC-V have become the industry standard for modern hardware accelerators. By designing a RISC-V CPU entirely from scratch, this project aims to:
* **Bridge the Software-Hardware Gap:** Understand exactly how high-level C code is compiled into assembly, fetched from memory, decoded, and executed by physical logic gates.
* **Master Datapath & Control Logic:** Gain hands-on experience in routing complex data buses and generating precise control signals based on instruction opcodes.
* **Build a Foundation for SoC Verification:** Establish a complete hardware verification pipeline, from C-code compilation to memory initialization (`.mem`) and RTL simulation.

---

## System Architecture & Core Modules
The CPU architecture is built with a strictly modularized hardware approach, separating the datapath from the control unit for clean and scalable RTL design.

* **Control Unit:** Decodes 32-bit instructions (`opcode`, `funct3`, `funct7`) and generates precise multiplexer (MUX) selection and write-enable signals for the entire datapath.
* **Register File:** A 32x32-bit dual-port read, single-port write memory architecture for high-speed local data storage. Hardwired `x0` register to zero.
* **Arithmetic Logic Unit (ALU):** Performs hardware-level arithmetic (ADD, SUB) and logical operations (AND, OR, XOR, Shifts) governed by 4-bit `alu_control` signals.
* **Immediate Extender:** Dynamically extracts and sign-extends (or zero-extends) immediate values based on the specific instruction type (I, S, B, U, J).
* **Memory Architecture:** Integrates independent Instruction Memory (ROM) and Data Memory (RAM) to fetch instructions and execute Load/Store operations concurrently in a single cycle.

---

##  Detailed Instruction Set Implementation
Successfully implemented hardware logic for all 6 base RV32I instruction formats:

1. **R-Type (Register-Register):** * Handled standard arithmetic and logical operations (`add`, `sub`, `sll`, `slt`, `xor`, etc.).
   * Implemented conditional subtraction and arithmetic shifts using the `funct7` field.
2. **I-Type (Immediate & Load):** * Designed sign-extension logic for arithmetic with immediates (`addi`, `srai`).
   * Implemented Load operations (`lw`, `lh`, `lhu`, `lb`, `lbu`) with precise byte/half-word masking and sign/zero-extension logic from Data Memory.
3. **S-Type (Store):** * Handled memory store operations (`sw`, `sh`, `sb`) by designing a write-enable logic that targets specific byte lanes in the Data Memory based on the address alignment.
4. **B-Type (Branch):** * Designed a dedicated comparator and branch evaluation logic (`btaken`) to handle conditional jumps (`beq`, `bne`, `blt`, `bge`, `bltu`, `bgeu`).
   * Integrated PC-offset calculation to update the Program Counter dynamically.
5. **U-Type (Upper Immediate):** * Implemented `lui` (Load Upper Immediate) and `auipc` (Add Upper Immediate to PC) for handling large 32-bit constants and PC-relative addressing.
6. **J-Type (Jump):** * Implemented unconditional jumps (`jal`, `jalr`) with return address linking (storing PC+4 into the destination register `rd`).

---

## Software-to-Hardware Verification Pipeline
To ensure the hardware operates correctly, a complete software-to-hardware test flow was established:
1. **C-Code Compilation:** Wrote a C program (sequential loop sum from 0 to 10) and compiled it into RISC-V Assembly using the RISC-V GCC toolchain.
2. **Memory Initialization:** Translated the assembly binaries into Hexadecimal Memory Files (`.mem`) and successfully loaded them into the Vivado instruction memory block.
3. **Vivado RTL Simulation:** Verified the entire CPU execution flow block-by-block on Xilinx Vivado. Confirmed that internal registers, PC branching, memory addressing, and ALU outputs perfectly matched the expected C-code execution logic.

---

## Repository Structure
* `documents/` : Official RISC-V specifications and reference manuals.
* `header/` : SystemVerilog header files containing macros for opcodes, ALU controls, and instruction types.
* `memory/` : `.mem` files containing compiled binary instructions and data for simulation.
* `source/` : Core SystemVerilog RTL files (`datapath.sv`, `control_unit.sv`, `alu.sv`, `imm_extender.sv`, etc.).
* `computer_architecture.pdf` : Detailed architectural diagrams, FSM charts, and timing simulation waveforms.

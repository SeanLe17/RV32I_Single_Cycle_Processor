# Single-Cycle RV32I Processor

SystemVerilog implementation of a simple single-cycle RV32I processor. Built in Vivado and synthesized for the Digilent Basys 3.

This is an RV32I subset, not a full implementation. It currently supports arithmetic, immediate, and branch instructions. There is no data memory / load-store support yet.

## What it has

- 32-bit ALU
- 32 x 32-bit register file
  - 2 asynchronous read ports
  - synchronous write port
  - `x0` is hardwired to 0
- Instruction decoder
- I-type and B-type immediate generators
- Branch comparison unit
- Program counter and basic instruction ROM

## Supported instructions

R-type:

`ADD`, `SUB`, `SLL`, `SLT`, `SLTU`, `XOR`, `SRL`, `SRA`, `OR`, `AND`

I-type:

`ADDI`, `SLLI`, `SLTI`, `SLTIU`, `XORI`, `SRLI`, `SRAI`, `ORI`, `ANDI`

Branches:

`BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`

## Test program

The current instruction memory runs this:

```assembly
addi x3, x0, 20
addi x2, x0, 22
add  x3, x3, x2    # x3 = 42
beq  x0, x0, 0     # loop here
```

For the Basys 3 build, the lower 16 bits of `x3` are connected to the LEDs, so the result should show `42` (`0x002A`).

## Verification

`ALU_TB.sv` runs 5,000 random cases for each of the 10 ALU operations, for 50,000 self-checking tests total. The simulation calls `$fatal` if an expected result does not match.

## FPGA results

Synthesized for the Basys 3 (Artix-7 XC7A35T). The design met timing at 100 MHz with about +3 ns slack; Vivado estimated an Fmax around 145 MHz.

## Files

```text
RV32I_Datapath.srcs/
├── sources_1/new/   # SystemVerilog design files
├── sim_1/new/       # testbenches
└── constrs_1/new/   # Basys 3 constraints
```

## Running it

Add the design sources and XDC file to a Vivado RTL project for the Basys 3. Use `basys_top` for the FPGA build. `rv32i_top` is the main CPU module.

## Next steps

- Add data memory and load/store instructions
- Use a real instruction memory initialization file instead of hardcoded instructions
- Add full-CPU testbenches

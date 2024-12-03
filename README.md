<div align="center">

# BrightFpga

</div>


## About the Project

This is my first VHDL program.\
Can Blink an LED at different frequencies depending on which switch are activated.

## Usage

You can use the test bench to run a simulation.\
I used AMD vivado to create this project and run simulations because it look like the most advanced tool out here.
For this basic project you could use any software such as Intel Quartus Prime, ModelSim , ect...

### Input truth table
| Enable | Switch 1 | Switch 2 | LED Drive Frequency |
|--------|----------|----------|---------------------|
| 0      | –        | –        | (disabled)          |
| 1      | 0        | 0        | 100 Hz              |
| 1      | 0        | 1        | 50 Hz               |
| 1      | 1        | 0        | 10 Hz               |
| 1      | 1        | 1        | 1 Hz                |

### Overview diagram
<p align="center">
  <img src="https://github.com/PasVegan/BrightFPGA/overview.png">
</p>

You can find a detailled schematic of the synthetized design on a Spartan-7 FPGA in the schematic.pdf

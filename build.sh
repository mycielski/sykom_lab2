#!/bin/bash

iverilog -o GpioEmu.vvp GpioEmu.v

# vvp GpioEmu.vvp

# gtkwave GpioEmu.vcd
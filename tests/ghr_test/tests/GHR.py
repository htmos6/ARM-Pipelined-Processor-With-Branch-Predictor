import cocotb
from cocotb.triggers import Timer
import random
import random
import cocotb
import warnings
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge
from cocotb.triggers import RisingEdge
from cocotb.triggers import Edge
from cocotb.binary import BinaryValue


@cocotb.test()
async def GHR(dut):
     #start the clock
    await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))
    #set clkedge as the FallingEdge for triggers
    clkedge = RisingEdge(dut.clk)
    await clkedge

    dut.reset.value = 1
    await clkedge
    await Timer(2, units="us")
    assert dut.out.value == 0 # 000

    dut.reset.value = 0
    await clkedge
    await Timer(2, units="us")


    dut.inp.value = 1
    dut.shift.value = 1
    await clkedge
    await Timer(2, units="us")
    assert dut.out.value == 0b001  # 000 --> 0 001 --> 001

    dut.inp.value = 1
    dut.shift.value = 1
    await clkedge
    await Timer(2, units="us")
    assert dut.out.value == 0b011  # 001 --> 0 011 --> 011

    dut.inp.value = 1
    dut.shift.value = 1
    await clkedge
    await Timer(2, units="us")
    assert dut.out.value == 0b111 # 011 --> 0 111 --> 111

    dut.inp.value = 0
    dut.shift.value = 1
    await clkedge
    await Timer(2, units="us")
    assert dut.out.value == 0b110 # 111 --> 1 110 --> 110

    dut.inp.value = 0
    dut.shift.value = 0
    await clkedge
    await Timer(2, units="us")
    assert dut.out.value == 0b110 # 110 --> 110 Stay same

    dut.reset.value = 1
    await clkedge
    await Timer(2, units="us")
    assert dut.out.value == 0 # 000 Reset




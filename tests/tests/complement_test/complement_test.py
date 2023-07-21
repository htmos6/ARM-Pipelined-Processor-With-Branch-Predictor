import random
import warnings

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge
from cocotb.triggers import RisingEdge
from cocotb.triggers import Edge
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue
#from cocotb.regression import TestFactory

# NOP = MOV R0, #0 
"""
MOV R0, #0          ;number zero
NOP
NOP
LDR R1,[R0, #16]    ;number to complement, location = 16
NOP
NOP
SUB R1, R0, R1      ;take complement
NOP
NOP
MOV R0, R1          ;to see if it is correct
NOP
NOP
"""

"""
0000A0E3
0000A0E3
0000A0E3
101090E5
0000A0E3
0000A0E3
011040E0
0000A0E3
0000A0E3
0100A0E1
0000A0E3
0000A0E3
"""

# number = 0000F3F2
number = 0x0000F3F2

@cocotb.test()
async def complement_test(dut):
    #start the clock
    await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))
    #set clkedge as the FallingEdge for triggers
    clkedge = RisingEdge(dut.clk)
    await clkedge
    # reset PC and RegFile
    dut.rst.value = 1
    await clkedge
    await clkedge
    dut.rst.value = 0
    assert dut.PC_out.value == 0
    #assert dut.Inst.value == 0
    # starts operation
    # MOV R0, #0
    # fetch MOV R0, #0
    await clkedge
    #assert dut.Inst.value == 0
    assert dut.PC_out.value == 0
    await clkedge
    # decode MOV R0, #0, fetch NOP
    print("dut.Inst.value",hex(dut.Inst.value))
    #assert dut.PC_out.value == 4
    await clkedge
    # Execute MOV R0, #0, fetch NOP, decode NOP
    await clkedge
    # Memory MOV R0, #0, execute NOP, decode NOP, fetch LDR R1,[R0, #16]
    await clkedge
    # write back MOV R0, #0, memory NOP, execute NOP, decode LDR R1,[R0, #16], fetch NOP
    print("dut.Inst.value",hex(dut.Inst.value))
    assert dut.REGWr.value == 1 
    r0 = 0
    await clkedge
    # fetch NOP, writeback NOP, memory NOP, execute LDR R1,[R0, #16], decode NOP
    assert dut.RD1.value == r0
    await clkedge
    # fetch SUB R1, R0, R1, writeback NOP, memory LDR R1,[R0, #16], execute NOP, decode NOP
    assert dut.REGWr.value == 1
    await clkedge
    # fetch NOP, writeback LDR R1,[R0, #16], memory NOP, execute NOP, decode SUB R1, R0, R1
    print("dut.Inst.value",hex(dut.Inst.value))
    assert dut.REGWr.value == 1
    assert dut.ALUOutW.value == 16
    assert dut.ReadDataW.value == number
    r1 = number
    await clkedge
    # fetch NOP, writeback NOP, memory NOP, execute SUB R1, R0, R1, decode NOP
    print("r0=", r0, int(dut.RD1.value), ", r1=", r1, ",dut.RD2.value=", int(dut.RD2.value))
    assert dut.RD1.value == r0
    assert dut.RD2.value == r1
    print("dut.ALUCnt.value=", int(dut.ALUCnt.value))
    assert dut.ALUCnt.value == 2  #substraction
    await clkedge
    # fetch MOV R0, R1 , writeback NOP, memory SUB R1, R0, R1, execute NOP, decode NOP
    await clkedge
    # fetch NOP, writeback SUB R1, R0, R1, memory NOP, execute NOP, decode MOV R0, R1
    print("dut.Inst.value",hex(dut.Inst.value))
    assert dut.REGWr.value == 1 
    comp = ~r1+1 + 2**32          # take 2s complement
    print("dut.ALUOutW.value= ", hex(dut.ALUOutW.value), "comp=", hex(comp))
    assert dut.ALUOutW.value == comp
    r1 = comp          # take 2s complement
    await clkedge
    # fetch NOP, writeback NOP, memory NOP, execute MOV R0, R1, decode NOP
    print("r0=", r0, "dut.RD1.value=", int(dut.RD1.value), ", r1=", bin(r1), ",dut.RD2.value=", bin(dut.RD2.value))
    assert int(dut.RD2.value) == r1
    await clkedge
    

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
NOP
BL store
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
store: BX LR
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
MOV R0, #0
"""

"""
0A0000EB
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
1EFF2FE1
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
0000A0E3
"""


@cocotb.test()
async def branch_test(dut):
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
    await clkedge
    # fetch BL store
    await clkedge
    await clkedge
    # decode BL store, fetch NOP
    print("dut.Inst.value",hex(dut.Inst.value))
    #assert dut.PC_out.value == 4
    await clkedge
    # Execute BL store, fetch NOP, decode NOP
    await clkedge
    # Memory BL store, execute NOP, decode NOP, fetch NOP
    assert dut.PCSrcM.value == 1
    await clkedge
    # write back BL store, memory NOP, execute NOP, decode NOP, fetch NOP
    print("before branch dut.PC_out.value",hex(dut.PC_out.value))
    print("before branch dut.ALUOutW.value", dut.ALUOutW.value)
    print("dut.PCPlus4W.value", dut.PCPlus4W.value)
    assert dut.REGWr.value == 1
    assert dut.RegSrcW.value == 1
    assert dut.WriteSrcW.value == 1
    await clkedge
    await clkedge
    # fetch BX LR, writeback NOP, memory NOP, execute NOP, decode NOP
    print("after branch dut.PC_out.value",hex(dut.PC_out.value))
    await clkedge
    # fetch NOP, writeback NOP, memory NOP, execute NOP, decode BX LR
    print("dut.Inst.value",hex(dut.Inst.value))
    await clkedge
    # fetch NOP, writeback NOP, memory NOP, execute BX LR, decode NOP
    print("dut.RD2.value", dut.RD2.value )
    print("dut.RD1.value", dut.RD1.value )
    #assert dut.RD2.value == 8
    await clkedge
    # fetch NOP, writeback NOP, memory BX LR, execute NOP, decode NOP
    await clkedge
    # fetch NOP, writeback BX LR, memory NOP, execute NOP, decode NOP
    print("before BX branch dut.PC_out.value",hex(dut.PC_out.value))
    print("before branch BX dut.ALUOutW.value", dut.ALUOutW.value)
    await clkedge
    # fetch NOP
    print("after branch BX dut.PC_out.value",hex(dut.PC_out.value))
    await clkedge
    print("after branch BX dut.PC_out.value",hex(dut.PC_out.value))
    await clkedge

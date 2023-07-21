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
MOV R0, #0              ;number zero
MOV R5, #0              ;keeps sum
MOV R1, #16             ;keeps number of cycles
MOV R2, #1              ;necessary for and op
LDR R3, [R0, #52]       ;number
NOP
NOP
loop: AND R4, R2, R3    ;find lsb
NOP
NOP
ADD R5, R5, R4          ;sum
ADD R3, R0, R3, shr #1  ;shift number     (A33080E0)     
SUBS R1, R1, #1         ;decrease counter
BNE loop                (1AFFFFF8) => (F8FFFF1A)
NOP
NOP
NOP
NOP
AND R5, R5, R2          ;return value, lsb of sum
NOP
NOP
ADD R5, R0, R5          ; to show value
NOP
NOP
NOP
NOP
"""

"""
0000A0E3
0050A0E3
1010A0E3
0120A0E3
343090E5
0000A0E3
0000A0E3
034002E0
0000A0E3
0000A0E3
045085E0
A33080E0
011051E2
F8FFFF1A
0000A0E3
0000A0E3
0000A0E3
0000A0E3
025005E0
0000A0E3
0000A0E3
055080E0
"""

# number = 00005201             #16bit number
number = 0x00005201
# binary 00000000000000000101001000000001
summ = 4
result = 0

@cocotb.test()
async def parity_test(dut):
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
    assert dut.Inst.value == 0
    #await clkedge
    # starts operation
    
    # fetch MOV R0, #0
    await clkedge
    assert dut.PC_out.value == 0
    await clkedge
    # decode MOV R0, #0, fetch MOV R5, #0 
    await clkedge
    # execute MOV R0, #0, decode MOV R5, #0, fetch MOV R1, #16
    await clkedge
    # memory MOV R0, #0, execute MOV R5, #0, decode MOV R1, #16, fetch MOV R2, #1
    await clkedge
    # writback MOV R0, #0, memory MOV R5, #0, execute MOV R1, #16, decode MOV R2, #1, fetch LDR R3, [R0, #52] 
    assert dut.REGWr.value == 1 
    r0 = 0
    await clkedge
    # writeback MOV R5, #0, memory MOV R1, #16, execute MOV R2, #1, decode LDR R3, [R0, #52], fetch NOP
    assert dut.REGWr.value == 1 
    r5 = 0
    await clkedge
    # writeback MOV R1, #16, memory MOV R2, #1, execute LDR R3, [R0, #52], decode NOP, fetch NOP
    assert dut.RD1.value == r0
    assert dut.REGWr.value == 1 
    r1 = 16
    """
    await clkedge
    # writeback MOV R2, #1, memory LDR R3, [R0, #52], execute NOP, decode NOP, fetch AND R4, R2, R3
    assert dut.REGWr.value == 1 
    r2 = 1 
    await clkedge
    # writeback LDR R3, [R0, #52], memory NOP, execute NOP, decode AND R4, R2, R3, fetch NOP
    assert dut.REGWr.value == 1
    r3 = number
    assert dut.ReadDataW.value == r3
    """
    
    r2 = 1 
    r3 = number
    
    await clkedge
    for i in range(16):
        print("Cycle ", i)
        # fetch AND R4, R2, R3
        await clkedge
        # decode AND R4, R2, R3, fetch NOP
        await clkedge
        # execute AND R4, R2, R3, decode NOP, fetch NOP
        assert dut.RD1.value == r2
        assert dut.RD2.value == r3
        await clkedge
        # memory AND R4, R2, R3, execute NOP, decode NOP, fetch ADD R5, R5, R4
        await clkedge
        # writeback AND R4, R2, R3, memory NOP, execute NOP, decode ADD R5, R5, R4, fetch ADD R3, R0, R3, shr #1
        r4 = r2 & r3
        assert dut.ALUOutW.value == r4
        await clkedge
        # writeback NOP, memory NOP, execute ADD R5, R5, R4, decode ADD R3, R0, R3, shr #1, fetch SUBS R1, R1, #1
        assert dut.RD1.value == r5                
        assert dut.RD2.value == r4                
        await clkedge
        # writeback NOP, memory ADD R5, R5, R4, execute ADD R3, R0, R3, shr #1, decode SUBS R1, R1, #1, fetch BNE loop
        assert dut.RD1.value == r0                
        assert dut.RD2.value == r3                
        await clkedge
        # writeback ADD R5, R5, R4, memory ADD R3, R0, R3, shr #1, execute SUBS R1, R1, #1, decode BNE loop, fetch NOP
        r5 = r5 + r4
        assert dut.ALUOutW.value == r5
        assert dut.RD1.value == r1                
        await clkedge
        # writeback ADD R3, R0, R3, shr #1, memory SUBS R1, R1, #1, execute BNE loop, decode NOP, fetch NOP
        r3 = (r3 >> 1)
        assert dut.ALUOutW.value == r3
        assert dut.REGWr.value == 1
        await clkedge
        # writeback SUBS R1, R1, #1, memory BNE loop, execute NOP, decode NOP, fetch NOP
        r1 = r1 - 1
        assert dut.ALUOutW.value == r1
        assert dut.REGWr.value == 1
        await clkedge
        # writeback BNE loop, memory NOP, execute NOP, decode NOP, fetch NOP
        await clkedge
        print("dut.PC_out.value", int(dut.PC_out.value))
    
        
    print("******traverse completed***********")
    # writeback NOP, memory NOP, execute NOP, decode NOP, fetch AND R5, R5, R2 
    await clkedge
    # writeback NOP, memory NOP, execute NOP, decode AND R5, R5, R2, fetch NOP
    await clkedge
    # writeback NOP, memory NOP, execute AND R5, R5, R2, decode NOP, fetch NOP
    assert dut.RD1.value == r5                 
    assert dut.RD2.value == r2                 
    assert dut.RD1.value == summ 
    await clkedge
    # Writeback NOP, memory AND R5, R5, R2, execute NOP, decode NOP, fetch ADD R5, R0, R5
    await clkedge
    # writeback AND R5, R5, R2, memory NOP, execute NOP, decode ADD R5, R0, R5, fetch NOP
    r5 = r5 & r2
    assert dut.ALUOutW.value == r5
    assert dut.REGWr.value == 1
    await clkedge
    # Writeback NOP, memory NOP, execute ADD R5, R0, R5, decode NOP, fetch NOP
    assert dut.RD1.value == r0                
    assert dut.RD2.value == r5                
    assert dut.RD2.value == result
    await clkedge
    # writeback NOP, memory ADD R5, R0, R5, execute NOP, decode NOP, fetch NOP
    await clkedge
    # writeback ADD R5, R0, R5, memory NOP, execute NOP, decode NOP, fetch NOP
    assert dut.ALUOutW.value == r5
    assert dut.REGWr.value == 1
    assert dut.ALUOutW.value == result
    print("subroutine completed")
        
        
        
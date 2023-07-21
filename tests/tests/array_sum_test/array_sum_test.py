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

# NOP = MOV R5, #0
"""
MOV R3, #0x3C       ;initial memory address for length and elements
MOV R0, #0          ;number zero
MOV R2, #0          ;keeps sum
LDR R1, [R3]        ;read from memory location 0x3A, keeps number of elements
NOP 
NOP 
L1: CMP R1, R0
                            NOP             //kalkacak
                            NOP             //kalkacak
BEQ store
NOP 
NOP 
NOP 
NOP 
ADD R3, #4
SUB R1, #1
NOP 
LDR R4, [R3]
NOP 
NOP 
ADDS R2, R2, R4
B L1
NOP 
NOP 
NOP 
NOP 
store: STR R2, [R3, #4]     ;R2 gives array sum 
NOP 
NOP 
NOP
NOP
done: B done
"""

"""
3C30A0E3
0000A0E3
0020A0E3
001093E5
0050A0E3
0050A0E3
000051E1
0F00000A
0050A0E3
0050A0E3
0050A0E3
0050A0E3
043083E2
011041E2
0050A0E3
004093E5
0050A0E3
0050A0E3
042092E0
F1FFFFEA
0050A0E3
0050A0E3
0050A0E3
0050A0E3
042083E5
0050A0E3
0050A0E3
FEFFFFEA
"""



@cocotb.test()
async def arrays_sum_test(dut):
    #start the clock
    await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))
    #set clkedge as the FallingEdge for triggers
    clkedge = RisingEdge(dut.clk)
    negclkedge = FallingEdge(dut.clk)
    await clkedge
    # reset PC and RegFile
    dut.rst.value = 1
    await clkedge
    await clkedge
    dut.rst.value = 0
    assert dut.PC_out.value == 0
    assert dut.Inst.value == 0
    #await clkedge
    # starts operation #######################################################
    await clkedge
    # fetch MOV R3, #0x3C
    #assert dut.Inst.value == 0
    assert dut.PC_out.value == 0
    await clkedge
    # decode MOV R3, #0x3C, fetch MOV R0, #0  
    print("dut.Inst.value",hex(dut.Inst.value))
    assert dut.PC_out.value == 4
    await clkedge
    # Execute MOV R3, #0x3C, decode MOV R0, #0, fetch MOV R2, #0
    print("dut.Inst.value",hex(dut.Inst.value))
    await clkedge
    # memory MOV R3, #0x3C, execute MOV R0, #0, decode MOV R2, #0, fetch LDR R1, [R3]
    await clkedge
    # writeback MOV R3, #0x3C, memory MOV R0, #0, execute MOV R2, #0, decode LDR R1, [R3], fetch NOP
    assert dut.ALUOutW.value == 0x3C
    assert dut.REGWr.value == 1 
    r3 = 0x3c
    await clkedge
    # writebak MOV R0, #0, memory MOV R2, #0, execute LDR R1, [R3], decode NOP, fetch NOP
    assert dut.ALUOutW.value == 0
    assert dut.REGWr.value == 1 
    assert dut.RD1.value == 0x3C
    print("Random check flags ", dut.Flags.value)
    r0 = 0
    """
    await clkedge
    # writeback MOV R2, #0, memory LDR R1, [R3], execute NOP, decode NOP, fetch CMP R1, R0
    assert dut.ALUOutW.value == 0
    assert dut.REGWr.value == 1 
    await clkedge
    # writeback LDR R1, [R3], memory NOP, execute NOP, decode CMP R1, R0, fetch NOP
    assert dut.REGWr.value == 1
    r1 = 3
    assert dut.ALUOutW.value == 0x3c
    assert dut.ReadDataW.value == r1
    """
    r1 = 3
    r2 = 0
    
    
    for i in range(r1):
        print("Cycle ", i)
        await clkedge
        print("dut.Inst.value",hex(dut.Inst.value))
        # fetch CMP R1, R0
        await clkedge
        print("0xE1510000 dut.Inst.value",hex(dut.Inst.value))
        # decode CMP R1, R0, fetch BEQ store
        print("before execute cmp dut.ALUFlags_w_w.value",dut.ALUFlags_w.value)
        await clkedge
        # execute CMP R1, R0, decode BEQ store, fetch NOP
        print("before execute cmp dut.ALUFlags_w.value",dut.ALUFlags_w.value)
        print("dut.PC_out.value", int(dut.PC_out.value))
        print("0x0A00000F dut.Inst.value",hex(dut.Inst.value))
        assert dut.RD1.value == r1
        assert dut.RD2.value == r0
        assert dut.FlagWriteE.value == 0b11
        print("before EQ cond determined from given flags ", dut.Flags.value)
        await clkedge
        # memory CMP R1, R0, execute BEQ store, decode NOP, fetch NOP
        print("after execute cmp dut.ALUFlags_w.value",dut.ALUFlags_w.value)
        print("dut.Inst.value",hex(dut.Inst.value))
        print("before before writeback cmp dut.ALUFlags_w.value",dut.ALUFlags_w.value)
        assert dut.FlagWriteE.value == 0
        assert dut.CondE.value == 0             # EQ
        print("EQ cond determined from given condex ", dut.condEx.value)
        print("EQ cond determined from given flags ", dut.Flags.value)
        print("EQ cond determined from given flags write", dut.FlagWrite.value)
        print("EQ condition", dut.CondE.value)
        await clkedge
        # writeback CMP R1, R0, memory BEQ store, execute NOP, decode NOP, fetch NOP
        print("after EQ cond determined from given flags ", dut.Flags.value)
        print("after EQ condition", dut.CondE.value)
        print("EQ cond determined from given condex ", dut.condEx.value)
        print("before writeback cmp dut.ALUFlags_w.value",dut.ALUFlags_w.value)
        print("before before writeback dut.PC_out.value", int(dut.PC_out.value))
        assert dut.ALUOutW.value == r1 - r0
        assert dut.PCSrcM.value == 0
        await clkedge
        # writeback BEQ store, memory NOP, execute NOP, decode NOP, fetch NOP
        print("after writeback cmp dut.ALUFlags_w.value",dut.ALUFlags_w.value)
        print("before writeback dut.PC_out.value", int(dut.PC_out.value))
        print("dut.Inst.value",hex(dut.Inst.value))
        print("dut.ALUFlags_w.value",dut.ALUFlags_w.value)
        await clkedge
        """
        # writeback NOP, memory BEQ store, execute NOP, decode NOP, fetch NOP
        assert dut.PCSrcM.value == 0
        print("dut.Inst.value",hex(dut.Inst.value))
        print("before before writeback dut.PC_out.value", int(dut.PC_out.value))
        await clkedge
        # writeback BEQ store, memory NOP, execute NOP, decode NOP, fetch NOP
        print("dut.Inst.value",hex(dut.Inst.value))
        print("before writeback dut.PC_out.value", int(dut.PC_out.value))
        print("dut.ALUOutW.value", int(dut.ALUOutW.value))
        
        assert dut.ALUOutW.value == 15*4
        await clkedge
        """
        # fetch ADD R3, #4, writeback NOP, memory NOP, execute NOP, decode NOP
        print("after branch dut.PC_out.value", int(dut.PC_out.value))
        print("dut.Inst.value",hex(dut.Inst.value))                             # buraya kadar instructionlar doğru
        await clkedge
        # decode ADD R3, #4, memory NOP, execute NOP, fetch SUB R1, #1
        print("0xE2833004 dut.Inst.value",hex(dut.Inst.value))
        print("dut.PC_out.value", int(dut.PC_out.value))
        await clkedge
        # execute ADD R3, #4, writeback NOP, memory NOP, decode SUB R1, #1, fetch NOP
        print("0xE2411001 dut.Inst.value",hex(dut.Inst.value))
        assert dut.RD1.value == r3
        await clkedge
        # memory ADD R3, #4, writeback NOP, execute SUB R1, #1, decode NOP, fetch LDR R4, [R3]
        print("dut.Inst.value",hex(dut.Inst.value))
        assert dut.RD1.value == r1
        await clkedge
        # writeback ADD R3, #4, memory SUB R1, #1, execute NOP, decode LDR R4, [R3], fetch NOP
        print("0xE5934000 dut.Inst.value",hex(dut.Inst.value))
        assert dut.ALUOutW.value == r3 + 4
        r3 = r3 + 4
        await clkedge
        # writeback SUB R1, #1, memory NOP, execute LDR R4, [R3], decode NOP, fetch NOP
        assert dut.ALUOutW.value == r1 - 1
        r1 = r1 - 1
        assert dut.RD1.value == r3
        await clkedge
        # writeback NOP, memory LDR R4, [R3], execute NOP, decode NOP, fetch ADDS R2, R2, R4
        await clkedge
        # writeback LDR R4, [R3], memory NOP, execute NOP, decode ADDS R2, R2, R4, fetch B L1
        if i == 0:
            r4 = 4
        elif i == 1:
            r4 = 1
        else:
            r4 = 2
        
        assert dut.ReadDataW.value == r4
        assert dut.ALUOutW.value == r3
        await clkedge
        # writeback NOP, memory NOP, execute ADDS R2, R2, R4, decode B L1, fetch NOP
        assert dut.RD1.value == r2                 
        assert dut.RD2.value == r4 
        await clkedge
        # Writeback NOP, memory ADDS R2, R2, R4, execute B L1, decode NOP, fetch NOP
        await clkedge
        # writeback ADDS R2, R2, R4, memory B L1, execute NOP, decode NOP, fetch nop        
        r2 = r2 + r4                
        assert dut.ALUOutW.value == r2
        await clkedge
        # writeback B L1, memory NOP, execute NOP, decode nop, fetch NOP
        
    print("traverse completed***********************")
    await clkedge
    # fetch CMP R1, R0
    await clkedge
    # decode CMP R1, R0, fetch BEQ store
    await clkedge
    # execute CMP R1, R0, decode BEQ store, fetch NOP
    assert dut.RD1.value == r1
    assert dut.RD2.value == r0
    assert dut.FlagWriteE.value == 0b11
    await clkedge
    # memory CMP R1, R0, execute BEQ store, decode NOP, fetch NOP
    assert dut.FlagWriteE.value == 0
    assert dut.CondE.value == 0b0000             # EQ
    await clkedge
    # writeback CMP R1, R0, memory BEQ store, execute NOP, decode NOP, fetch NOP
    assert dut.ALUOutW.value == r1 - r0
    assert dut.PCSrcM.value == 1
    await clkedge
    # writeback BEQ store, memory NOP, execute NOP, decode NOP, fetch NOP
    await clkedge
    # writeback NOP, memory NOP, execute NOP, decode NOP, fetch STR R2, [R3, #4]
    print("after branch dut.PC_out.value", int(dut.PC_out.value))
    await clkedge
    # writeback NOP, memory NOP, execute NOP, decode STR R2, [R3, #4], fetch NOP
    await clkedge
    # writeback NOP, memory NOP, execute STR R2, [R3, #4], decode NOP, fetch NOP
    assert dut.RD1.value == r3
    assert dut.RD2.value == r2              # desired result
    await clkedge
    
    
    

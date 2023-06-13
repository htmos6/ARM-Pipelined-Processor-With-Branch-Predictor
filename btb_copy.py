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
async def BTB(dut):
     #start the clock
     #await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))
     #set clkedge as the FallingEdge for triggers
     dut.aluBranchAddress.value = 0x00000000

     # cache0 --> 1108 
     # cache1 --> 2212 
     # cache2 --> 3316
     dut.reset.value = 0
     dut.pc.value = 0x8
     await Timer(2, units="us")
     assert dut.hit.value == 1
     assert dut.BTA.value == 0x11
     await Timer(2, units="us")
     assert dut.cache0.value == 0x0000001108

     # cache1 Reached --> Change its location with cache0
     # cache0 --> 2212
     # cache1 --> 1108 
     # cache2 --> 3316
     dut.pc.value = 0x12
     await Timer(2, units="us")
     assert dut.hit.value == 1
     assert dut.BTA.value == 0x22
     assert dut.cache0.value == 0x0000002212
     assert dut.cache1.value == 0x0000001108

     # We have reached to the cache2. It will be switched to cache0 location.
     # cache2 Reached --> Change its location with cache0

     # cache0 --> 3316
     # cache1 --> 2212
     # cache2 --> 1108 
     dut.pc.value = 0x16 
     await Timer(2, units="us")
     assert dut.hit.value == 1
     assert dut.BTA.value == 0x33
     assert dut.cache0.value == 0x0000003316
     assert dut.cache1.value == 0x0000002212
     assert dut.cache2.value == 0x0000001108

     dut.reset.value = 0
     await Timer(2, units="us")
     assert dut.cache0.value == 0x0000003316
     assert dut.cache1.value == 0x0000002212
     assert dut.cache2.value != 0x0000001109
     assert dut.cache2.value == 0x0000001108

     dut.aluBranchAddress.value = 0x00000044
     dut.pcOfAluBranchAddress.value = 0x00000020
     dut.branchTakenE.value = 1
     dut.branchPredictedE.value = 0
     await Timer(2, units="us")
     assert dut.cache0.value == 0x0000004420
     assert dut.cache1.value == 0x0000003316
     assert dut.cache2.value == 0x0000002212


     dut.reset.value = 1
     await Timer(2, units="us")
     assert dut.cache0.value == 0x0000000000
     assert dut.cache1.value == 0x0000000000
     assert dut.cache2.value == 0x0000000000

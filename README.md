# Pipelined Processor with Hazard Unit and Branch Predictor

## Introduction
* In the project, the same pipelined processor defined in lectures is used with modifications.

## Datapath Changes
* Shifter is added to the datapath immediately before B port of ALU module. To be able to multiply imm24 by 4, the extender is modified. To make Register File write to the registers on the negative edge of the clock, the clock of Register File is inverted. For branch instructions, PC+4 is also carried through the pipeline. For BX instruction, selection for A3 between R14 and carried WA3 signal, WriteSrc signal is carried through the pipeline.

* Regarding data processing instructions, the registers Rd and Rm are chosen as A1 and A2, respectively. Rd is then forwarded as the write address. Signals such as RD1, RD2, WA3D, and ExtImm are stored for use in the next cycle. The shifter, ALUSrc, and ALU signals are determined based on the instruction. RD2, ALUResult, and the write address for the Register File are also stored. In the subsequent cycle, during the memory stage, ReadData and ALUOut are captured, but the read data is not selected for the following cycle. During the writeback stage, when the RegWrite signal is high, the carried write address is connected to A3. At the falling edge of the cycle, the value of ALUOut is written to the register.

* For memory instructions, Rn is selected as A1, and for STR, Rd is chosen as A2. RD1, RD2, and ExtImm signals are captured at the rising edge of the clock. Then, the ExtImm signal is chosen and added to the value of RD1. No shifting operation is performed for memory instructions. ALUResult and RD2 values are recorded. In the next cycle, the data at the address specified by ALUResult is read and captured for LDR. For STR, when the MemWrite signal is high, the RD2 value is written to the specified position, completing the STR operation. In the subsequent stage, the readData is written to the Rd register for the LDR operation.

* In the case of B and BL instructions, R15 is selected for Register File, and the imm24 value is multiplied by 4. Then, in the next cycle, RD1 and ExtImm values are added, and the result is stored. During the memory stage, the memory is read, but the obtained data is not used. Then, in the writeback stage, when the PCSrc signal is high, the PC value will become ResultW in the next cycle. For the BL instruction, with RegWrite set to 1, the PC+4 value is written to the R14 register. The PC+4 value is the value forwarded during instruction decoding. As for BX, the Rm value is chosen as A2, and the RD2 value is stored. In the next cycle, the RD2 value is directly transferred to ALUResult and stored. Similar to data processing instructions, the memory is read, but its value is not used. Finally, in the writeback stage, the ALUResult is written to the PC register.

* To implement move immediate, immediate bit is considered to implement data processing instructions. Immediate data processing operations implemented as follows. For the shift amount signal shamt, the rot signal is shifted by 1. ImmSrc signal is 00 to choose imm8 and ALUSrc selects ExtImm signal. Shift operation for shifter is chosen as ROR.

* Similar structures mentioned in the lectures are added to the system for forwarding. For mispredictions and LDRstall, flush and stall signals are added. Flush and stall signals are applied not only to datapath registers but also control signals.

* To select PC addresses between ALUResultE, BTA, PCPlus4, carriedPCPlus4, MUX before PC register is implemented. When a branch is needed to be taken but not taken during fetch, the PC address should be ALUResultE. On the other hand, if a branch shouldn’t be taken but taken during fetch, the PC address should be PC+4 carried through the pipeline. If the branch predictor says that branch will be taken, MUX selects BTA, otherwise selects PC+4. Priority of information comes from execution higher than branch predictor information.

* For branch operations, signals related to the branch are not carried through pipeline after the execute stage since there is no operation related to pipeline for memory and writeback stages. Therefore, connection between writeback output and PC register is removed.

## Hazard Unit
* For mispredictions and LDRstall, flush and stall signals are added. Flush and stall signals are applied not only to datapath registers but also control signals.

##Data Hazard Handling
* Similar structures mentioned in the lectures are added to the system for forwarding. RA1, RA2 and WA3 signals are carried through the pipeline. When registers in the execute stage match with register names in memory or writeback stage, forwarding takes place. However, for some instructions such as move immediate instruction, RA1, RA2 or WA3 might not be valid and mismatches might take place. So, validity signals are added to the system. Moreover, for flush signals, validity signals are also flushed to prevent undesired matches with zeros of flush and R0 register.

* Stall only takes place for LDRstall since 4 cycle stalls for R15 write instruction won’t be used. Forwarding signals are the same as in lectures except validity of signals are checked.











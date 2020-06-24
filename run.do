vlog tb.v pipeline_RISCV.v PC.v Instruction_Memory.v registerFile.v Control_Unit.v ALU_64_bit.v Data_Memory.v Imm_data_extractor.v ALU_Control.v Adder.v mux_64.v IR1.v IR2.v IR3.v IR4.v Inst_parser.v bgt.v

vsim -novopt work.tb

view wave

#add wave -r /*

do wave.do

run 300ns	
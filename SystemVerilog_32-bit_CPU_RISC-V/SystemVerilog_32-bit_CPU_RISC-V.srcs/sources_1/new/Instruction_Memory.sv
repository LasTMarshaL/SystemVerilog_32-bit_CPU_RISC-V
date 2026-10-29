`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Instruction_Memory
(
    input logic [ADDRESS_WIDTH-1:0] address,
    output logic [INSTRUCTION_WIDTH-1:0] instruction
);

    localparam INDEX_BITS = $clog2(MEMORY_SIZE);
    
    logic [INSTRUCTION_WIDTH-1:0] memory [0:MEMORY_SIZE-1];
    

    initial
        begin
            for (int i = 0; i < MEMORY_SIZE; i++)
                begin
                    memory[i] = INSTRUCTION_WIDTH'('h00000013); 
                end
            
            memory[0] = INSTRUCTION_WIDTH'('h000123ac);
            memory[1] = INSTRUCTION_WIDTH'('h00ae2317);
            memory[2] = INSTRUCTION_WIDTH'('h471cd320);
            //$readmemh("CPU_Commands.mem", memory);
        end
        
        assign instruction = memory[address[INDEX_BITS+1:2]];


endmodule
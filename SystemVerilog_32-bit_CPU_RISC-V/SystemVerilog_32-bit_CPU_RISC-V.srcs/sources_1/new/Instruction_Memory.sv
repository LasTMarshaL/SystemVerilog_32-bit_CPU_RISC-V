`timescale 1ns / 1ps


module Instruction_Memory #(parameter ADDRESS_WIDTH = 32, INSTRUCTION_WIDTH = 32, MEMORY_SIZE = 16384)
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
                    memory[i] = 32'h00000013; 
                end
            
            memory[0] = 32'h000123ac;
            memory[1] = 32'h00ae2317;
            memory[2] = 32'h471cd320;
            //$readmemh("CPU_Commands.mem", memory);
        end
        
        assign instruction = memory[address[INDEX_BITS+1:2]];


endmodule
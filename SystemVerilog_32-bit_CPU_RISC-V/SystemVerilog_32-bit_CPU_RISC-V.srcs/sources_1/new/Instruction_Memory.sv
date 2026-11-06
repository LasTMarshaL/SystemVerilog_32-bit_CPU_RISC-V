`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Instruction_Memory
(
    input logic clk, 
    input logic reset, 
    
    input logic [ADDRESS_WIDTH-1:0] read_instruction_address,
    output logic [INSTRUCTION_WIDTH-1:0] instruction,                     
    
    input logic fencei_flush,
    
    input logic read_instruction_enable,
    input logic write_instruction_enable, 
    input logic [ADDRESS_WIDTH-1:0] write_instruction_address,      
    input logic [INSTRUCTION_WIDTH-1:0] write_instruction_data  
);

    localparam INDEX_BITS = $clog2(MEMORY_SIZE);
    
    logic [INSTRUCTION_WIDTH-1:0] memory [0:MEMORY_SIZE-1];
    logic [INSTRUCTION_WIDTH-1:0] current_instruction;

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
        
    always_ff @(posedge clk)
        begin
            if (reset)
                begin
                    current_instruction <= '0;
                end
            else if (fencei_flush)
                begin
                    current_instruction <= INSTRUCTION_WIDTH'('h00000013);
                end
            else
                begin
                    if (read_instruction_enable)
                        begin
                            current_instruction <= memory[read_instruction_address[INDEX_BITS+1:2]];
                        end
                    else if (write_instruction_enable)
                        begin
                            memory[write_instruction_address[INDEX_BITS+1:2]] <= write_instruction_data;
                        end
                end
        end

    assign instruction = current_instruction;


endmodule
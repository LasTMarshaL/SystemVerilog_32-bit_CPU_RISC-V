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
    
    output logic instruction_read_finished,
    
    output logic [DATA_WIDTH-1:0] instruction_exception
);
   
    typedef enum logic
    {
        IDLE,
        EXECUTE
    } memory_state_typedef;
    
    memory_state_typedef memory_state;
    
    logic [INSTRUCTION_WIDTH-1:0] memory [0:MEMORY_SIZE-1];
    logic [ADDRESS_WIDTH-1:0] register_read_instruction_address;

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
        
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    instruction <= '0;
                    instruction_read_finished <= 0;
                    instruction_exception <= '1;
                    memory_state <= IDLE;
                end
            else
                begin
                    if (instruction_exception == '1)
                        begin
                            if (fencei_flush)
                                begin
                                    instruction <= INSTRUCTION_WIDTH'('h00000013);
                                    instruction_read_finished <= 1;
                                end
                            else
                                begin
                                    instruction_read_finished <= 0;
                                    
                                    case (memory_state)
                                        IDLE:
                                            begin
                                                if (read_instruction_address[BYTES_QUATER_NUMBER:0] == '0)
                                                    begin
                                                        if (read_instruction_enable)
                                                            begin
                                                                if ($unsigned(read_instruction_address) < $unsigned(MEMORY_SIZE * 4))
                                                                    begin
                                                                        register_read_instruction_address <= read_instruction_address >> 2;
                                                                        memory_state <= EXECUTE;
                                                                    end 
                                                                else
                                                                    begin
                                                                        instruction_exception <= DATA_WIDTH'(1);
                                                                    end
                                                            end
                                                    end
                                                else
                                                    begin
                                                         instruction_exception <= DATA_WIDTH'(0);
                                                    end
                                            end
                                        EXECUTE:
                                            begin
                                                instruction <= memory[register_read_instruction_address];
                                                instruction_read_finished  <= 1;
                                                memory_state <= IDLE;
                                            end
                                        default: memory_state <= IDLE;
                                    endcase
                                 end
                        end
                end
        end
        
        
endmodule
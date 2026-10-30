`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Control_Unit
(
    input logic clk,
    input logic reset,
      
    input logic [INSTRUCTION_WIDTH-1:0] instruction,
    
    output logic alu_source,
    output logic memory_byte_mask_calculation_enable,
    
    output logic write_register_enable,
    output logic read_register_enable,
    
    output logic read_memory_enable,
    output logic [DATA_WIDTH/BYTE_SIZE-1:0] write_memory_byte_enable,
    
    output logic next_address_enable
);


    typedef enum logic
    {
        DECODE,
        EXECUTE,
        MEMORY_DELAY
    } state_typedef;
    
    
    state_typedef current_state, next_state;
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    current_state <= DECODE;
                end
            else
                begin
                    current_state <= next_state;
                end
        end

    always_comb 
        begin
            next_state = current_state;
            next_address_enable = 0;
            write_register_enable = 0;
            read_register_enable = 0;
            read_memory_enable = 0;
            memory_byte_mask_calculation_enable = 0;
            alu_source = 0;
            
            case(instruction[OPERATION_CODE-1:0])
                OPERATION_CODE'('b0110011): // R block
                    begin
                        if (current_state == DECODE)
                            begin
                                read_register_enable = 1;
                                next_state = EXECUTE;
                            end
                        else
                            begin
                                write_register_enable = 1;
                                next_address_enable = 1;
                                next_state = DECODE;
                            end
                    end
                OPERATION_CODE'('b0000011): // I block
                    begin
                        if (current_state == DECODE)
                            begin
                                read_register_enable = 1;
                                next_state = EXECUTE;
                            end
                        else if (current_state == EXECUTE)
                            begin
                                alu_source = 1;
                                read_memory_enable = 1;
                                next_state = MEMORY_DELAY;
                            end
                        else
                            begin
                                write_register_enable = 1;
                                next_address_enable = 1;
                                next_state = DECODE;
                            end
                    end
                OPERATION_CODE'('b0001111): ; // I block
                OPERATION_CODE'('b0010011): ; // I block
                OPERATION_CODE'('b1110011): ; // I block
                OPERATION_CODE'('b1100111): ; // I block
                OPERATION_CODE'('b0100011):  // S block
                    begin
                        if (current_state == DECODE)
                            begin
                                read_register_enable = 1;
                                next_state = EXECUTE;
                            end
                        else
                            begin
                                alu_source = 1;
                                memory_byte_mask_calculation_enable = 1;
                                next_address_enable = 1;
                                next_state = DECODE;
                            end
                    end
                OPERATION_CODE'('b1100011): ; // SB block
                OPERATION_CODE'('b0010111): ; // U block
                OPERATION_CODE'('b0110111): ; // U block
                OPERATION_CODE'('b1101111): ; // UJ block
                default: ;
            endcase
                           
                    
        end


endmodule

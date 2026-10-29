`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Control_Unit
(
    input logic clk,
    input logic reset,
      
    input logic [INSTRUCTION_WIDTH-1:0] instruction
);


    typedef enum logic
    {
        FETCH = 1'b0,
        WRITE = 1'b1
    } state_t;
    
    
    state_t current_state, next_state;
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    current_state <= FETCH;
                end
            else
                begin
                    current_state <= next_state;
                end
        end

    always_comb 
        begin
            case(instruction[OPERATION_CODE-1:0])
                OPERATION_CODE'('b0110011): ; // R block
                OPERATION_CODE'('b0000011): ; // I block
                OPERATION_CODE'('b0001111): ; // I block
                OPERATION_CODE'('b0010011): ; // I block
                OPERATION_CODE'('b1110011): ; // I block
                OPERATION_CODE'('b1100111): ; // I block
                OPERATION_CODE'('b1100011): ; // SB block
                OPERATION_CODE'('b0010111): ; // U block
                OPERATION_CODE'('b0110111): ; // U block
                OPERATION_CODE'('b1101111): ; // UJ block
                default: ;
            endcase
                           
                    
        end


endmodule

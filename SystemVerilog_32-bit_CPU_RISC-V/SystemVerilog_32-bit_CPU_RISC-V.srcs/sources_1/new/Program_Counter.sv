`timescale 1ns / 1ps


module Program_Counter #(parameter ADDRESS_WIDTH = 8)
(
    input logic clk,
    input logic reset,
    
    input logic next_address_enable,
    input logic jump_enable,
    input logic [ADDRESS_WIDTH-1:0] target_address,
    
    output logic [ADDRESS_WIDTH-1:0] instruction_address
);
    
    
    logic [ADDRESS_WIDTH-1:0] current_instruction_address;
    
    
    initial
        begin
            current_instruction_address = '0;
        end
        
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    current_instruction_address = 0;
                end
            else
                begin
                    if (jump_enable)
                        begin
                            current_instruction_address <= target_address;
                        end
                    else if (next_address_enable)
                        begin
                            current_instruction_address <= current_instruction_address + 1;
                        end
                end
        end
        
        
    assign instruction_address = current_instruction_address;
    
    
endmodule

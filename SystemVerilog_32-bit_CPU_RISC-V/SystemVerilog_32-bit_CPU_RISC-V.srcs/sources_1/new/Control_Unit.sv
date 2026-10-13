`timescale 1ns / 1ps


module Control_Unit #(parameter INSTRUCTION_WIDTH = 16, OPERATION_WIDTH = 4)
(
    input logic clk,
    input logic reset,
    
    input logic [INSTRUCTION_WIDTH-1:0] instruction,
    input logic zero_flag,
    
    output logic [OPERATION_WIDTH-1:0] alu_operation,
    output logic register_write_enable, 
    output logic flag_register_write_enable, 
    output logic jump_enable,
    output logic next_address_enable,
    
    output logic data_memory_read_enable,   
    output logic data_memory_write_enable,      
    output logic [1:0] register_write_source
);


    typedef enum logic
    {
        FETCH = 1'b0,
        WRITE = 1'b1
    } state_t;
    
    
    logic [OPERATION_WIDTH-1:0] operation_code;
    assign operation_code = instruction[INSTRUCTION_WIDTH-1:INSTRUCTION_WIDTH-OPERATION_WIDTH];
    
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
            alu_operation = 4'b0000;
            flag_register_write_enable = 1'b0;
            register_write_enable = 1'b0;
            jump_enable = 1'b0;
            next_address_enable = 1'b1;
            next_state = FETCH;
            
            data_memory_read_enable = 1'b0;
            data_memory_write_enable = 1'b0;
            register_write_source = 2'b00;
            
            case (operation_code)
                4'b0000: begin
                    // Skip
                end
                
                4'b1101: begin
                    register_write_enable = 1'b1;
                    register_write_source = 2'b10;
                end

                4'b1011: begin
                    if (current_state == FETCH)
                        begin
                            data_memory_read_enable = 1'b1;
                            register_write_enable = 1'b0;
                            next_address_enable = 1'b0;
                            next_state = WRITE;
                        end
                    else
                        begin
                        data_memory_read_enable = 1'b1;
                            register_write_enable = 1'b1;
                            next_address_enable = 1'b1;
                            register_write_source = 2'b01;
                            next_state = FETCH;
                        end
                end
                4'b0100: begin
                    data_memory_write_enable = 1'b1;
                    register_write_enable = 1'b0;
                end
                
                4'b0010: begin
                    next_address_enable = 1'b0;
                    jump_enable = 1'b1;
                end
                
                4'b1001: begin
                    if (zero_flag)
                        begin
                            next_address_enable = 1'b0;
                            jump_enable = 1'b1;
                        end
                end
                
                4'b0001,
                4'b0011,
                4'b0111,
                4'b1111,
                4'b1000,
                4'b1100,
                4'b1110,
                4'b0101,
                4'b1010,
                4'b0110:
                begin
                    alu_operation = operation_code;
                    register_write_enable = 1'b1;
                    flag_register_write_enable = 1'b1;
                    register_write_source = 2'b00;
                    
                end
            endcase
                           
                    
        end


endmodule

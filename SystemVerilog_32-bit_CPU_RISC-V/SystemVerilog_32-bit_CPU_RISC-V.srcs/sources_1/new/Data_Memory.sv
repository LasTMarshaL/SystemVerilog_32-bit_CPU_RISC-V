`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Data_Memory
(
    input logic clk,
    input logic reset,
    
    input logic read_memory_enable,
    input logic [DATA_WIDTH/BYTE_SIZE-1:0] write_memory_byte_enable,
    
    input logic [ADDRESS_WIDTH-1:0] memory_address,
    
    input logic [DATA_WIDTH-1:0] write_memory_data, 
    output logic [DATA_WIDTH-1:0] read_memory_data,
    
    output logic memory_read_finished,
    output logic memory_write_finished
);
    
    
    typedef enum logic
    {
        IDLE,
        EXECUTE
    } memory_state_typedef;
    
    memory_state_typedef memory_state;
    
    localparam INDEX_BITS = $clog2(MEMORY_SIZE);
    
    logic [INDEX_BITS-1:0] word_address;
    logic [INDEX_BITS-1:0] register_word_address;
    
    assign word_address = memory_address[INDEX_BITS+1:2];
    
    logic [DATA_WIDTH-1:0] memory [0:MEMORY_SIZE-1];
    
    initial
        begin
            for (int i = 0; i < MEMORY_SIZE; i++)
                begin
                    memory[i] = '0;
                end
        end
    
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    memory_state <= IDLE;
                    read_memory_data <= '0;
                    register_word_address <= '0;
                    memory_read_finished  <= 0;
                    memory_write_finished <= 0;
                end
            else
                begin
                    memory_read_finished <= 0;
                    memory_write_finished <= 0;
                    case (memory_state)
                        IDLE:
                            begin
                                if (read_memory_enable)
                                    begin
                                        register_word_address <= word_address;
                                        memory_state <= EXECUTE;
                                    end
                                else if (|write_memory_byte_enable)
                                    begin
                                        for (int i = 0; i < BYTES_NUMBER; i += 1)
                                            begin
                                                if (write_memory_byte_enable[i])
                                                    begin
                                                        memory[word_address][(i*BYTE_SIZE) +: BYTE_SIZE] <= write_memory_data[(i*BYTE_SIZE) +: BYTE_SIZE];
                                                    end
                                             end
                                        memory_write_finished <= 1;
                                        memory_state <= IDLE;
                                    end
                            end
                       EXECUTE:
                            begin
                                read_memory_data <= memory[register_word_address];
                                memory_read_finished  <= 1;
                                memory_state <= IDLE;
                            end
                        default: ;
                    endcase
                end    
        end


endmodule
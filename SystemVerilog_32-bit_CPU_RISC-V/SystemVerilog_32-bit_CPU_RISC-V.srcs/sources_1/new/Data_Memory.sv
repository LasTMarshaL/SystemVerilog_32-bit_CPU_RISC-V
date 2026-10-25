`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Data_Memory #()
(
    input logic clk,
    
    input logic read_enable,
    input logic [DATA_WIDTH/BYTE_SIZE-1:0] write_byte_enable,
    
    input logic [ADDRESS_WIDTH-1:0] address,
    
    input logic [DATA_WIDTH-1:0] write_data, 
    output logic [DATA_WIDTH-1:0] read_data
);

    localparam INDEX_BITS = $clog2(MEMORY_SIZE);
    logic [INDEX_BITS-1:0] word_address;
    
    assign word_address = address[INDEX_BITS+1:2];
    
    logic [DATA_WIDTH-1:0] memory [0:MEMORY_SIZE-1];
    
    initial
        begin
            for (int i = 0; i < MEMORY_SIZE; i++)
                begin
                    memory[i] = '0;
                end
        end
    
    
    always_ff @(posedge clk)
        begin
            if (|write_byte_enable)
                begin
                    for (int i = 0; i < BYTES_NUMBER; i += 1)
                        begin
                            if (write_byte_enable[i])
                                begin
                                    memory[word_address][(i*BYTE_SIZE) +: BYTE_SIZE] <= write_data[(i*BYTE_SIZE) +: BYTE_SIZE];
                                end
                        end
                end
            if (read_enable)
                begin
                    read_data <= memory[word_address];
                end
        end


endmodule
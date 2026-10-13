`timescale 1ns / 1ps


module Data_Memory #(parameter ADDRESS_WIDTH = 32, DATA_WIDTH = 32, MEMORY_SIZE = 16384)
(
    input logic clk,
    
    input logic read_enable,
    input logic [3:0] write_byte_enable,
    
    input logic [ADDRESS_WIDTH-1:0] address,
    
    input logic [DATA_WIDTH-1:0] write_data, 
    output logic [DATA_WIDTH-1:0] read_data
);

    logic [DATA_WIDTH-1:0] memory [0:MEMORY_SIZE-1];

    localparam INDEX_BITS = $clog2(MEMORY_SIZE);
    
    logic [INDEX_BITS-1:0] word_address;
    assign word_address = address[INDEX_BITS+1:2];
    
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
                   if (write_byte_enable[3])
                        begin
                            memory[word_address][31:24] <= write_data[31:24];
                        end
                    if (write_byte_enable[2])
                        begin
                            memory[word_address][23:16] <= write_data[23:16];
                        end
                    if (write_byte_enable[1])
                        begin
                            memory[word_address][15:8] <= write_data[15:8];
                        end
                    if (write_byte_enable[0])
                        begin
                            memory[word_address][7:0] <= write_data[7:0];
                        end
                end
            if (read_enable)
                begin
                    read_data <= memory[word_address];
                end
        end


endmodule
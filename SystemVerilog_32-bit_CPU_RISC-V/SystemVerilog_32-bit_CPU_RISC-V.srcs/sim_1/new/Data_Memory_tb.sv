`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Data_Memory_tb;


    logic clk;
    logic reset;
    
    logic read_memory_enable;
    logic store_word;
    logic store_half_word;
    logic store_byte;
    
    logic [ADDRESS_WIDTH-1:0] memory_address;
    
    logic [DATA_WIDTH-1:0] write_memory_data;
    logic [DATA_WIDTH-1:0] read_memory_data;
    
    logic memory_read_finished;
    logic memory_write_finished;
    
    logic [DATA_WIDTH-1:0] memory_exception;

    
    Data_Memory  uut ( 
        .clk(clk),
        .reset(reset),
        .store_byte(store_byte),
        .store_half_word(store_half_word),
        .store_word(store_word),
        .read_memory_enable(read_memory_enable),
        .memory_address(memory_address),
        .write_memory_data(write_memory_data),
        .read_memory_data(read_memory_data),
        .memory_read_finished(memory_read_finished),
        .memory_write_finished(memory_write_finished),
        .memory_exception(memory_exception)
    );
    
    
    always 
        begin
            #PROPAGATION_DELAY clk = ~clk;
        end
    
    
    initial
        begin
            clk = 0;
            reset = 1;
            store_byte = 0;
            store_half_word = 0;
            store_word = 0;
            read_memory_enable = 0;
            
            memory_address = '0;
            write_memory_data = '0;
            
            #OPERATION_DURATION
            
            reset = 0;
            
            @(negedge clk)
            
            store_byte = 1;
            memory_address = ADDRESS_WIDTH'(0);
            write_memory_data = DATA_WIDTH'('sd26) << BYTE_SIZE * 0;
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS SB: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL SB: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            store_byte = 0;
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS SB: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL SB: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end

            if (read_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE] == write_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE])
                begin
                    $display("SUCCESS SB: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL SB: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
                
            #OPERATION_DURATION
            @(negedge clk)
            
            store_byte = 1;
            memory_address = ADDRESS_WIDTH'(1);
            write_memory_data = DATA_WIDTH'('sd7) << BYTE_SIZE * 1;
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS SB : memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL SB: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            store_byte = 0;
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS SB: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL SB: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end

            if (read_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE] == write_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE])
                begin
                    $display("SUCCESS SB: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL SB: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            store_byte = 1;
            memory_address = ADDRESS_WIDTH'(2);
            write_memory_data = DATA_WIDTH'('sd12) << BYTE_SIZE * 2;
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS SB: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL SB: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            store_byte = 0;
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS SB: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL SB: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end

            if (read_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE] == write_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE])
                begin
                    $display("SUCCESS SB: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL SB: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            store_byte = 1;
            memory_address = ADDRESS_WIDTH'(3);
            write_memory_data = DATA_WIDTH'('sd64) << BYTE_SIZE * 3;
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS SB: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL SB: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            store_byte = 0;
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS SB: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL SB: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end

            if (read_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE] == write_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE])
                begin
                    $display("SUCCESS SB: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL SB: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            store_half_word = 1;
            memory_address = ADDRESS_WIDTH'(4);
            write_memory_data = DATA_WIDTH'('sd19) << BYTE_SIZE * 0;
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS SH: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL SH: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            store_half_word = 0;
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS SH: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL SH: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end

            if (read_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE] == write_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE])
                begin
                    $display("SUCCESS SH: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL SH: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            store_half_word = 1;
            memory_address = ADDRESS_WIDTH'(6);
            write_memory_data = DATA_WIDTH'('sd75) << BYTE_SIZE * 2;
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS SH: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL SH: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            store_half_word = 0;
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS SH: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL SH: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end

            if (read_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE] == write_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE])
                begin
                    $display("SUCCESS SH: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL SH: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            store_word = 1;
            memory_address = ADDRESS_WIDTH'(8);
            write_memory_data = DATA_WIDTH'('sd7678) << BYTE_SIZE * 0;
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS SW: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL SW: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            store_word = 0;
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS SW: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL SW: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end

            if (read_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE] == write_memory_data[(memory_address[1:0] * BYTE_SIZE) +: BYTE_SIZE])
                begin
                    $display("SUCCESS SW: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL SW: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
            
            #OPERATION_DURATION
            @(negedge clk);
            reset = 1;           

            @(negedge clk);      
            reset = 0;           
            
            @(negedge clk);
            @(negedge clk);
            
            store_half_word = 1;
            memory_address = ADDRESS_WIDTH'(9);
            write_memory_data = DATA_WIDTH'('sd189) << BYTE_SIZE * 0;
            
            @(negedge clk)
            
            if (memory_exception == DATA_WIDTH'(6))
                begin
                    $display("SUCCESS 6 ERROR: exception was handled correctly %d.", memory_exception);
                end
            else
                begin
                    $display("FAIL 6 ERROR: exception was not handled correctly %d.", memory_exception);
                end
            
            store_half_word = 0;
            
            #OPERATION_DURATION
            @(negedge clk);
            reset = 1;           

            @(negedge clk);      
            reset = 0;           
            
            @(negedge clk);
            
            store_word = 1;
            memory_address = ADDRESS_WIDTH'(1000000000);
            write_memory_data = DATA_WIDTH'('sd799) << BYTE_SIZE * 0;
            
            @(negedge clk)
            @(negedge clk);
            
            if (memory_exception == DATA_WIDTH'(7))
                begin
                    $display("SUCCESS 7 ERROR: exception was handled correctly %d.", memory_exception);
                end
            else
                begin
                    $display("FAIL 7 ERROR: exception was not handled correctly %d.", memory_exception);
                end
            
            store_word = 0;
            
            #OPERATION_DURATION
            @(negedge clk);
            reset = 1;           
            
            @(negedge clk);      
            reset = 0;           
            
            @(negedge clk);
            
            memory_address = ADDRESS_WIDTH'(1000000000);
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_exception == DATA_WIDTH'(5))
                begin
                    $display("SUCCESS 5 ERROR: exception was handled correctly %d.", memory_exception);
                end
            else
                begin
                    $display("FAIL 5 ERROR: exception was not handled correctly %d.", memory_exception);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
            
            #OPERATION_DURATION
            $finish;
        end
    

endmodule

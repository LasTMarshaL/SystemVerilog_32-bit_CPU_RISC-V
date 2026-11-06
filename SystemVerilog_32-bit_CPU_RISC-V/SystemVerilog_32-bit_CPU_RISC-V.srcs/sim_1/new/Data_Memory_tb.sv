`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Data_Memory_tb;


    logic clk;
    logic reset;
    
    logic [BYTES_NUMBER-1:0] write_memory_byte_enable;
    logic read_memory_enable;
    
    logic [ADDRESS_WIDTH-1:0] memory_address;
    
    logic [DATA_WIDTH-1:0] write_memory_data;
    logic [DATA_WIDTH-1:0] read_memory_data;
    
    logic memory_read_finished;
    logic memory_write_finished;
    
    logic [DATA_WIDTH-1:0] comparison_data;
    logic [DATA_WIDTH-1:0] comparison_result;
    logic [BYTES_NUMBER-1:0] comparison_byte_mask;
    
    
    Data_Memory uut (
        .clk(clk),
        .reset(reset),
        .write_memory_byte_enable(write_memory_byte_enable),
        .read_memory_enable(read_memory_enable),
        .memory_address(memory_address),
        .write_memory_data(write_memory_data),
        .read_memory_data(read_memory_data),
        .memory_read_finished(memory_read_finished),
        .memory_write_finished(memory_write_finished)
    );
    
    
    always 
        begin
            #PROPAGATION_DELAY clk = ~clk;
        end
    
    
    initial
        begin
            clk = 0;
            reset = 1;
            write_memory_byte_enable = BYTES_NUMBER'('b0000);
            read_memory_enable = 0;
            memory_address = '0;
            write_memory_data = '0;
            
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
            
            #OPERATION_DURATION
            reset = 0;
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b1111);
            comparison_byte_mask = write_memory_byte_enable;
            memory_address = ADDRESS_WIDTH'(4);
            write_memory_data = DATA_WIDTH'('sd346);
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            write_memory_byte_enable = BYTES_NUMBER'('b0000);
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end
            
            for (int i = 0; i < BYTES_NUMBER; i += 1)
                begin
                    comparison_data[i*BYTE_SIZE +: BYTE_SIZE] = write_memory_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                    comparison_result[i*BYTE_SIZE +: BYTE_SIZE] = read_memory_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                end
            
            if (comparison_result == comparison_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_memory_enable = 0;
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b1000);
            comparison_byte_mask = write_memory_byte_enable;
            memory_address = ADDRESS_WIDTH'(156);
            write_memory_data = DATA_WIDTH'(205) << DATA_WIDTH'(24);
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            write_memory_byte_enable = BYTES_NUMBER'('b0000);
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end
            
            for (int i = 0; i < BYTES_NUMBER; i += 1)
                begin
                    comparison_data[i*BYTE_SIZE +: BYTE_SIZE] = write_memory_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                    comparison_result[i*BYTE_SIZE +: BYTE_SIZE] = read_memory_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                end
            
            if (comparison_result == comparison_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            
            @(negedge clk)
            
            read_memory_enable = 0;
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b0110);
            comparison_byte_mask = write_memory_byte_enable;
            memory_address = ADDRESS_WIDTH'(400);
            write_memory_data = DATA_WIDTH'(475); 
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            write_memory_byte_enable = BYTES_NUMBER'('b0000); 
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end
            
            for (int i = 0; i < BYTES_NUMBER; i += 1)
                begin
                    comparison_data[i*BYTE_SIZE +: BYTE_SIZE] = write_memory_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                    comparison_result[i*BYTE_SIZE +: BYTE_SIZE] = read_memory_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                end
            
            if (comparison_result == comparison_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
                
            @(negedge clk)
            
            read_memory_enable = 0;
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b0101);
            comparison_byte_mask = write_memory_byte_enable;
            memory_address = ADDRESS_WIDTH'(12);
            write_memory_data = DATA_WIDTH'(1556);   
            
            @(negedge clk)
            
            if (memory_write_finished == 1)
                begin
                    $display("SUCCESS: memory_write_finished flag was set correctly %d.", memory_write_finished);
                end
            else
                begin
                    $display("FAIL: memory_write_finished flag was not set correctly %d.", memory_write_finished);
                end
            
            write_memory_byte_enable = BYTES_NUMBER'('b0000); 
            read_memory_enable = 1;
            
            @(negedge clk)
            @(negedge clk)
            
            if (memory_read_finished == 1)
                begin
                    $display("SUCCESS: memory_read_finished flag was set correctly %d.", memory_read_finished);
                end
            else
                begin
                    $display("FAIL: memory_read_finished flag was not set correctly %d.", memory_read_finished);
                end
            
            for (int i = 0; i < BYTES_NUMBER; i += 1)
                begin
                    comparison_data[i*BYTE_SIZE +: BYTE_SIZE] = write_memory_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                    comparison_result[i*BYTE_SIZE +: BYTE_SIZE] = read_memory_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                end
            
            if (comparison_result == comparison_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d.", write_memory_data, memory_address[ADDRESS_WIDTH-2:2]);
                end
            
            #OPERATION_DURATION
            $finish;
        end
    

endmodule

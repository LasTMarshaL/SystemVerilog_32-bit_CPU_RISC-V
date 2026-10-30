`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Data_Memory_tb;


    logic clk;
    
    logic [BYTES_NUMBER-1:0] write_memory_byte_enable;
    logic read_memory_enable;
    
    logic [ADDRESS_WIDTH-1:0] memory_address;
    
    logic [DATA_WIDTH-1:0] write_memory_data;
    logic [DATA_WIDTH-1:0] read_memory_data;
    
    logic [DATA_WIDTH-1:0] comparison_data;
    logic [DATA_WIDTH-1:0] comparison_result;
    logic [BYTES_NUMBER-1:0] comparison_byte_mask;
    
    
    Data_Memory uut (
        .clk(clk),
        .write_memory_byte_enable(write_memory_byte_enable),
        .read_memory_enable(read_memory_enable),
        .memory_address(memory_address),
        .write_memory_data(write_memory_data),
        .read_memory_data(read_memory_data)
    );
    
    
    always 
        begin
            #PROPAGATION_DELAY clk = ~clk;
        end
    
    
    initial
        begin
            clk = 0;
            write_memory_byte_enable = BYTES_NUMBER'('b0000);
            read_memory_enable = 0;
            memory_address = '0;
            write_memory_data = '0;
            
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b1111);
            comparison_byte_mask = write_memory_byte_enable;
            memory_address = ADDRESS_WIDTH'(4);
            write_memory_data = DATA_WIDTH'('sd346);
            
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b0000);
            read_memory_enable = 1;
            
            @(negedge clk)
            
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
            memory_address = ADDRESS_WIDTH'(1526726656);
            write_memory_data = DATA_WIDTH'(205) << DATA_WIDTH'(24);
            
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b0000);
            read_memory_enable = 1;
            
            @(negedge clk)
            
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
            memory_address = ADDRESS_WIDTH'(1526726656);
            write_memory_data = DATA_WIDTH'(15152384); 
            
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b0000); 
            read_memory_enable = 1;
            
            @(negedge clk)
            
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
            write_memory_data = DATA_WIDTH'(15138846);   
            
            @(negedge clk)
            
            write_memory_byte_enable = BYTES_NUMBER'('b0000); 
            read_memory_enable = 1;
            
            @(negedge clk)
            
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

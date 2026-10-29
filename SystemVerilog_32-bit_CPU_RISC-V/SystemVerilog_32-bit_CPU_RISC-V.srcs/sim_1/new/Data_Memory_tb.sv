`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Data_Memory_tb;


    logic clk;
    
    logic [BYTES_NUMBER-1:0] write_byte_enable;
    logic read_enable;
    
    logic [ADDRESS_WIDTH-1:0] address;
    
    logic signed [DATA_WIDTH-1:0] write_data;
    logic signed [DATA_WIDTH-1:0] read_data;
    
    logic [DATA_WIDTH-1:0] comparison_data;
    logic [DATA_WIDTH-1:0] comparison_result;
    logic [BYTES_NUMBER-1:0] comparison_byte_mask;
    
    
    Data_Memory uut (
        .clk(clk),
        .write_byte_enable(write_byte_enable),
        .read_enable(read_enable),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );
    
    
    always 
        begin
            #PROPAGATION_DELAY clk = ~clk;
        end
    
    
    initial
        begin
            clk = 0;
            write_byte_enable = BYTES_NUMBER'('b0000);
            read_enable = 0;
            address = '0;
            write_data = '0;
            
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_byte_enable = BYTES_NUMBER'('b1111);
            comparison_byte_mask = write_byte_enable;
            address = ADDRESS_WIDTH'(4);
            write_data = DATA_WIDTH'('sd346);
            
            @(negedge clk)
            
            write_byte_enable = BYTES_NUMBER'('b0000);
            read_enable = 1;
            
            @(negedge clk)
            
            for (int i = 0; i < BYTES_NUMBER; i += 1)
                begin
                    comparison_data[i*BYTE_SIZE +: BYTE_SIZE] = write_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                    comparison_result[i*BYTE_SIZE +: BYTE_SIZE] = read_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                end
            
            if (comparison_result == comparison_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d.", write_data, address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d.", write_data, address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk)
            
            read_enable = 0;
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_byte_enable = BYTES_NUMBER'('b1000);
            comparison_byte_mask = write_byte_enable;
            address = ADDRESS_WIDTH'(1526726656);
            write_data = DATA_WIDTH'(205) << DATA_WIDTH'(24);
            
            @(negedge clk)
            
            write_byte_enable = BYTES_NUMBER'('b0000);
            read_enable = 1;
            
            @(negedge clk)
            
            for (int i = 0; i < BYTES_NUMBER; i += 1)
                begin
                    comparison_data[i*BYTE_SIZE +: BYTE_SIZE] = write_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                    comparison_result[i*BYTE_SIZE +: BYTE_SIZE] = read_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                end
            
            if (comparison_result == comparison_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d.", write_data, address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d.", write_data, address[ADDRESS_WIDTH-2:2]);
                end
            
            @(negedge clk)
            
            read_enable = 0;
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_byte_enable = BYTES_NUMBER'('b0110);
            comparison_byte_mask = write_byte_enable;
            address = ADDRESS_WIDTH'(1526726656);
            write_data = DATA_WIDTH'(15152384); 
            
            @(negedge clk)
            
            write_byte_enable = BYTES_NUMBER'('b0000); 
            read_enable = 1;
            
            @(negedge clk)
            
            for (int i = 0; i < BYTES_NUMBER; i += 1)
                begin
                    comparison_data[i*BYTE_SIZE +: BYTE_SIZE] = write_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                    comparison_result[i*BYTE_SIZE +: BYTE_SIZE] = read_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                end
            
            if (comparison_result == comparison_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d.", write_data, address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d.", write_data, address[ADDRESS_WIDTH-2:2]);
                end
                
            @(negedge clk)
            
            read_enable = 0;
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_byte_enable = BYTES_NUMBER'('b0101);
            comparison_byte_mask = write_byte_enable;
            address = ADDRESS_WIDTH'(12);
            write_data = DATA_WIDTH'(15138846);   
            
            @(negedge clk)
            
            write_byte_enable = BYTES_NUMBER'('b0000); 
            read_enable = 1;
            
            @(negedge clk)
            
            for (int i = 0; i < BYTES_NUMBER; i += 1)
                begin
                    comparison_data[i*BYTE_SIZE +: BYTE_SIZE] = write_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                    comparison_result[i*BYTE_SIZE +: BYTE_SIZE] = read_data[i*BYTE_SIZE +: BYTE_SIZE] & {BYTE_SIZE{comparison_byte_mask[i]}};
                end
            
            if (comparison_result == comparison_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d.", write_data, address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d.", write_data, address[ADDRESS_WIDTH-2:2]);
                end
                
            @(negedge clk)
            
            read_enable = 0;
            comparison_data = '0;
            comparison_result = '0;
            comparison_byte_mask = '0;
            
            #OPERATION_DURATION
            $finish;
        end
    

endmodule

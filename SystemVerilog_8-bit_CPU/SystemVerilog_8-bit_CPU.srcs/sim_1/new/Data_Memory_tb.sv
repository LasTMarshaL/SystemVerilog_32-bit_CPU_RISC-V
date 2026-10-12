`timescale 1ns / 1ps


module Data_Memory_tb #(parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 32);


    logic clk;
    
    logic [3:0] write_byte_enable;
    logic read_enable;
    
    logic [ADDRESS_WIDTH-1:0] address;
    
    logic signed [DATA_WIDTH-1:0] write_data;
    logic signed [DATA_WIDTH-1:0] read_data;
    
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
            #5 clk = ~clk;
        end
    
    
    initial
        begin
            clk = 0;
            write_byte_enable = 4'b0000;
            read_enable = 0;
            address = '0;
            write_data = '0;
            
            #200
            @(negedge clk)
            
            write_byte_enable = 4'b1111;
            address = 32'b0000000000000000000000000000100;
            write_data = 32'sd346;
            
            @(posedge clk);
            #1 
            
            @(negedge clk);
            write_byte_enable = 4'b0000;
            read_enable = 1;
            
            @(posedge clk); 
            #1
            
            if (read_data == write_data)
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address word cell %d", write_data, address[ADDRESS_WIDTH-2:2]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address word cell %d", write_data, address[ADDRESS_WIDTH-2:2]);
                end
               
            @(negedge clk);
            read_enable = 0;
                
            #200
            @(negedge clk)
            
            write_byte_enable = 4'b1000;
            address = 32'b1011011000000000000000000000000;
            write_data = 32'b11001101 << 24;
            
            @(posedge clk);
            #1 
            
            @(negedge clk);
            write_byte_enable = 4'b0000;
            read_enable = 1;
            
            @(posedge clk); 
            #1
            
            if (read_data[31:24] == write_data[31:24])
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address byte cell 3", write_data[31:24]);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address byte cell 3", write_data[31:24]);
                end
            
            @(negedge clk);
            read_enable = 0;
            
            #200
            @(negedge clk)
            
            write_byte_enable = 4'b0110;
            read_enable = 0;
            address = 32'b1011011000000000000000000000000;
            write_data = 32'b00000000111001110011010100000000;
            
            @(posedge clk);
            #1 
            
            @(negedge clk);
            write_byte_enable = 4'b0000; 
            read_enable = 1;
            
            @(posedge clk); 
            #1
            
            if ({read_data[23:16], read_data[15:8]} == {write_data[23:16], write_data[15:8]})
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address byte cell 2 and 1", {write_data[23:16], write_data[15:8]});
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address byte cell 2 and 1", {write_data[23:16], write_data[15:8]});
                end
                
            @(negedge clk);
            read_enable = 0;
            
            #200
            @(negedge clk)
            
            write_byte_enable = 4'b0101;
            read_enable = 0;
            address = 32'b000000000000001100;
            write_data = 32'b00000000111001110000000000011110;
            
            @(posedge clk); 
            #1
            
            @(negedge clk);
            write_byte_enable = 4'b0000; 
            read_enable = 1;
            
            @(posedge clk); 
            #1
            
            if ({read_data[23:16], read_data[7:0]} == {write_data[23:16], write_data[7:0]})
                begin
                    $display("SUCCESS: Expected data (%d) was written to the address byte cell 2 and 0", {write_data[23:16], write_data[7:0]});
                end
            else
                begin
                    $display("FAIL: Expected data (%d) was not written to the address byte cell 2 and 0", {write_data[23:16], write_data[7:0]});
                end
                
            @(negedge clk);
            read_enable = 0;
            
            #200
            $finish;
        end
    

endmodule

`timescale 1ns / 1ps


module Register_File_tb #(parameter DATA_WIDTH = 32, REGISTER_SELECTION_WIDTH = 5);


    logic clk;
    
    logic write_register_enable;
    logic [REGISTER_SELECTION_WIDTH-1:0] write_register_select;
    logic signed [DATA_WIDTH-1:0] write_register_data;
    
    logic [REGISTER_SELECTION_WIDTH-1:0] read_register_select_1;
    logic [REGISTER_SELECTION_WIDTH-1:0] read_register_select_2;
    
    logic signed [DATA_WIDTH-1:0] read_register_data_1;
    logic signed [DATA_WIDTH-1:0] read_register_data_2;
    
    Register_File utt (
        .clk(clk),
        .write_register_enable(write_register_enable),
        .write_register_select(write_register_select),
        .write_register_data(write_register_data),
        .read_register_select_1(read_register_select_1),
        .read_register_select_2(read_register_select_2),
        .read_register_data_1(read_register_data_1),
        .read_register_data_2(read_register_data_2)
    );
    
    
    always
        begin
            #5 clk = ~clk;
        end
        
    
    initial 
        begin
            clk = 0;
            write_register_enable = 0;
            write_register_select = 0;
            write_register_data = 0;
            read_register_select_1 = 0;
            read_register_select_2 = 0;          
            
            #200
            @(negedge clk)
            
            write_register_enable = 1;
            write_register_select = 0; 
            write_register_data = 32'sd24;
            
            @(posedge clk)
            #1
            
            write_register_enable = 0;
            read_register_select_1 = 0;
            
            #1
            if (read_register_data_1 == '0)
                begin
                    $display("SUCCESS: Register 0 was keeped unchanged");
                end
            else
                begin
                    $display("FAIL: Register 0 was not keeped unchanged");
                end
            
            #200
            @(negedge clk)
            
            write_register_enable = 1;
            write_register_select = 23;
            write_register_data = -32'sd38;
            
            @ (posedge clk)
            #1
            
            write_register_enable = 0;
            read_register_select_2 = 23;
            
            #1
            if (read_register_data_2 == write_register_data)
                begin
                    $display("SUCCESS: Number %d was written in register %d", write_register_data, write_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in register %d", write_register_data, write_register_select);
                end
                
            #200
            @(negedge clk)
            
            write_register_enable = 0;
            write_register_select = 23;
            write_register_data = 32'sd51;
            
            @(posedge clk)
            #1
            
            write_register_enable = 0;
            read_register_select_2 = 23;
            
            #1
            if (read_register_data_2 == -32'sd38)
                begin
                    $display("SUCCESS: Register %d was keeped unchanged", write_register_select);
                end
            else
                begin
                    $display("FAIL: Register %d was not keeped unchanged", write_register_select);
                end
                
            #200
            $finish;
        end    


endmodule

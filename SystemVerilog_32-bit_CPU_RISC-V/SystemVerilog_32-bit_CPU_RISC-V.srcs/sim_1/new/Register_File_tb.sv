`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Register_File_tb;


    logic clk;
    
    logic write_register_enable;
    logic read_register_enable;
    logic [REGISTER_SELECTION_WIDTH-1:0] write_register_select;
    logic signed [DATA_WIDTH-1:0] write_register_data;
    
    logic [REGISTER_SELECTION_WIDTH-1:0] read_register_select_1;
    logic [REGISTER_SELECTION_WIDTH-1:0] read_register_select_2;
    
    logic signed [DATA_WIDTH-1:0] read_register_data_1;
    logic signed [DATA_WIDTH-1:0] read_register_data_2;
    
    Register_File uut (
        .clk(clk),
        .write_register_enable(write_register_enable),
        .read_register_enable(read_register_enable),
        .write_register_select(write_register_select),
        .write_register_data(write_register_data),
        .read_register_select_1(read_register_select_1),
        .read_register_select_2(read_register_select_2),
        .read_register_data_1(read_register_data_1),
        .read_register_data_2(read_register_data_2)
    );
    
    
    always
        begin
            #PROPAGATION_DELAY clk = ~clk;
        end
        
    
    initial 
        begin
            clk = 0;
            read_register_enable = 0;
            write_register_enable = 0;
            write_register_select = '0;
            write_register_data = '0;
            read_register_select_1 = '0;
            read_register_select_2 = '0;          
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_register_enable = 1;
            read_register_enable = 0;
            write_register_select = REGISTER_SELECTION_WIDTH'(0); 
            write_register_data = DATA_WIDTH'('sd24);
            
            @(negedge clk)
            
            write_register_enable = 0;
            read_register_enable = 1;
            read_register_select_1 = '0;
            
            @(negedge clk)
            
            if (read_register_data_1 == '0)
                begin
                    $display("SUCCESS: Register 0 was kept unchanged.");
                end
            else
                begin
                    $display("FAIL: Register 0 was not kept unchanged.");
                end
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_register_enable = 1;
            read_register_enable = 0;
            write_register_select = REGISTER_SELECTION_WIDTH'(23);
            write_register_data = -DATA_WIDTH'('sd38);
            
            @(negedge clk)
            
            write_register_enable = 0;
            read_register_enable = 1;
            read_register_select_2 = REGISTER_SELECTION_WIDTH'(23);
            
            @(negedge clk)
            
            if (read_register_data_2 == write_register_data)
                begin
                    $display("SUCCESS: Number %d was written in register %d.", write_register_data, write_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in register %d.", write_register_data, write_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_register_enable = 0;
            read_register_enable = 0;
            write_register_select = REGISTER_SELECTION_WIDTH'(23);
            write_register_data = DATA_WIDTH'(32'sd51);
            
            @(negedge clk)
            
            write_register_enable = 0;
            read_register_enable = 1;
            read_register_select_2 = REGISTER_SELECTION_WIDTH'(23);
            
            @(negedge clk)
            
            if (read_register_data_2 == -DATA_WIDTH'('sd38))
                begin
                    $display("SUCCESS: Register %d was kept unchanged.", write_register_select);
                end
            else
                begin
                    $display("FAIL: Register %d was not kept unchanged.", write_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_register_enable = 1;
            read_register_enable = 0;
            write_register_select = REGISTER_SELECTION_WIDTH'(18);
            write_register_data = -DATA_WIDTH'('sd535);
            
            @(negedge clk)
            
            write_register_enable = 0;
            read_register_enable = 1;
            read_register_select_1 = REGISTER_SELECTION_WIDTH'(18);
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_register_enable = 1;
            read_register_enable = 0;
            write_register_select = REGISTER_SELECTION_WIDTH'(13);
            write_register_data = DATA_WIDTH'('sd134);
            
            @(negedge clk)
            
            write_register_enable = 0;
            read_register_enable = 1;
            read_register_select_2 = REGISTER_SELECTION_WIDTH'(13);
            
            @(negedge clk)
            
            if (read_register_data_2 == DATA_WIDTH'('sd134) && read_register_data_1 == -DATA_WIDTH'('sd535))
                begin
                    $display("SUCCESS: Both registors got and gave rigth data.");
                end
            else
                begin
                    $display("FAIL: Both registors didn't get and give rigth data.");
                end
                
            #OPERATION_DURATION
            $finish;
        end    


endmodule

`timescale 1ns / 1ps

import CPU_Parameters_Config::*;


module System_Register_File_tb();


    logic clk;
    
    logic read_system_register_enable;
    logic write_system_register_enable;
    
    logic [I_IMMEDIATE_WIDTH-1:0] read_system_register_select;
    logic [I_IMMEDIATE_WIDTH-1:0] write_system_register_select;
    
    logic [DATA_WIDTH-1:0] write_system_register_data;
    logic [DATA_WIDTH-1:0] read_system_register_data;
    
    logic [DATA_WIDTH-1:0] write_system_register_data_previous;
    
    System_Register_File uut (
        .clk(clk),
        .read_system_register_enable(read_system_register_enable),
        .write_system_register_enable(write_system_register_enable),
        .read_system_register_select(read_system_register_select),
        .write_system_register_select(write_system_register_select),
        .write_system_register_data(write_system_register_data),
        .read_system_register_data(read_system_register_data)
    );
    
    
    always
        begin
            #PROPAGATION_DELAY clk = ~clk;
        end
        
    
    initial 
        begin
            clk = 0;
            read_system_register_enable = 0;
            write_system_register_enable = 0;    
            read_system_register_select = 0;
            write_system_register_select = 0;
            write_system_register_data = '0;
            
            write_system_register_data_previous = '0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h300); 
            write_system_register_data = DATA_WIDTH'(642);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h300); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data)
                begin
                    $display("SUCCESS: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
                end
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h304); 
            write_system_register_data = DATA_WIDTH'(234);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h304); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data)
                begin
                    $display("SUCCESS: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h305); 
            write_system_register_data = DATA_WIDTH'(78);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h305); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data)
                begin
                    $display("SUCCESS: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h340); 
            write_system_register_data = DATA_WIDTH'(344);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h340); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data)
                begin
                    $display("SUCCESS: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h341); 
            write_system_register_data = DATA_WIDTH'(98);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h341); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data)
                begin
                    $display("SUCCESS: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h342); 
            write_system_register_data = DATA_WIDTH'(1678);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h342); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data)
                begin
                    $display("SUCCESS: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h343); 
            write_system_register_data = DATA_WIDTH'(365);
            write_system_register_data_previous = write_system_register_data;
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h343); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data)
                begin
                    $display("SUCCESS: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h343); 
            write_system_register_data = DATA_WIDTH'(436);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 0;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h343); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data_previous)
                begin
                    $display("SUCCESS: register %d was kept unchanged.", write_system_register_select);
                end
            else
                begin
                    $display("FAIL: register %d was not kept unchanged.",write_system_register_select);
                end
                
            #OPERATION_DURATION
            $finish;
        end
    

endmodule

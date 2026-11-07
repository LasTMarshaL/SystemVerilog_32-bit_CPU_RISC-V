`timescale 1ns / 1ps

import CPU_Parameters_Config::*;


module System_Register_File_tb();


    logic clk;
    logic reset;
    
    logic read_system_register_enable;
    logic write_system_register_enable;
    
    logic [I_IMMEDIATE_WIDTH-1:0] read_system_register_select;
    logic [I_IMMEDIATE_WIDTH-1:0] write_system_register_select;
    
    logic [DATA_WIDTH-1:0] write_system_register_data;
    logic [DATA_WIDTH-1:0] read_system_register_data;
    
    logic [DATA_WIDTH-1:0] write_system_register_data_previous;
    
    logic [DATA_WIDTH-1:0] system_register_exception;
    
    System_Register_File uut (
        .clk(clk),
        .reset(reset),
        .read_system_register_enable(read_system_register_enable),
        .write_system_register_enable(write_system_register_enable),
        .read_system_register_select(read_system_register_select),
        .write_system_register_select(write_system_register_select),
        .write_system_register_data(write_system_register_data),
        .read_system_register_data(read_system_register_data),
        .system_register_exception(system_register_exception)
    );
    
    
    always
        begin
            #PROPAGATION_DELAY clk = ~clk;
        end
        
    
    initial 
        begin
            clk = 0;
            reset = 1;
            read_system_register_enable = 0;
            write_system_register_enable = 0;    
            read_system_register_select = 0;
            write_system_register_select = 0;
            write_system_register_data = '0;
            
            write_system_register_data_previous = '0;
            
            #OPERATION_DURATION
            
            reset = 0;
            
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
                    $display("SUCCESS MSTATUS: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL MSTATUS: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
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
                    $display("SUCCESS MIE: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL MIE: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
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
                    $display("SUCCESS MTVEC: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL MTVEC: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
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
                    $display("SUCCESS MSCRATCH: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL MSCRATCH: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
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
                    $display("SUCCESS MEPC: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL MEPC: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
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
                    $display("SUCCESS MCAUSE: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL MCAUSE: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
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
                    $display("SUCCESS MTVAL: Number %d was written in system register %d.", write_system_register_data, write_system_register_select);
                end
            else
                begin
                    $display("FAIL MTVAL: Number %d was not written in system register %d.", write_system_register_data, write_system_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h343); 
            write_system_register_data = DATA_WIDTH'(436);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h343); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data_previous)
                begin
                    $display("SUCCESS: register %d was kept unchanged (no permission).", write_system_register_select);
                end
            else
                begin
                    $display("FAIL: register %d was not kept unchanged (no permission).",write_system_register_select);
                end
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h363); 
            write_system_register_data = DATA_WIDTH'(56);
            
            @(negedge clk)
            
            if (system_register_exception == DATA_WIDTH'(2))
                begin
                    $display("SUCCESS 4 ERROR: non-available system register during writing was received.", system_register_exception);
                end
            else
                begin
                    $display("FAIL 4 ERROR: non-available system register during writing was not received.", system_register_exception);
                end
                        
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h363); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (system_register_exception == DATA_WIDTH'(2))
                begin
                    $display("SUCCESS 4 ERROR: non-available system register during reading was received.", system_register_exception);
                end
            else
                begin
                    $display("FAIL 4 ERROR: non-available system register during reading was not received.", system_register_exception);
                end       
            
            #OPERATION_DURATION
            @(negedge clk)
            
            write_system_register_enable = 1;
            read_system_register_enable = 0;
            write_system_register_select = I_IMMEDIATE_WIDTH'('h343); 
            write_system_register_data = DATA_WIDTH'(686);
            
            @(negedge clk)
            
            write_system_register_enable = 0;
            read_system_register_enable = 1;
            read_system_register_select = I_IMMEDIATE_WIDTH'('h343); 
            
            @(negedge clk)
            @(negedge clk)
            
            if (read_system_register_data == write_system_register_data_previous)
                begin
                    $display("SUCCESS: register %d was kept unchanged (exception).", write_system_register_select);
                end
            else
                begin
                    $display("FAIL: register %d was not kept unchanged (exception).",write_system_register_select);
                end
                
            #OPERATION_DURATION
            $finish;
        end
    

endmodule

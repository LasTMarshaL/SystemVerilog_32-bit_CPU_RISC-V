`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Instruction_Memory_tb;


    logic clk;
    logic reset;
    
    logic [ADDRESS_WIDTH-1:0] read_instruction_address;
    logic [INSTRUCTION_WIDTH-1:0] instruction;                  
    
    logic fencei_flush;
    
    logic read_instruction_enable;
    logic write_instruction_enable;
    logic [ADDRESS_WIDTH-1:0] write_instruction_address;
    logic [INSTRUCTION_WIDTH-1:0] write_instruction_data;
    
    Instruction_Memory uut (
        .clk(clk),
        .reset(reset),
        .read_instruction_address(read_instruction_address),
        .instruction(instruction),
        .fencei_flush(fencei_flush),
        .read_instruction_enable(read_instruction_enable),
        .write_instruction_enable(write_instruction_enable),
        .write_instruction_address(write_instruction_address),
        .write_instruction_data(write_instruction_data)
    );
    
    always
        begin
            #5 clk = ~clk;
        end
    
    initial
        begin
            clk = 0;
            reset = 1;
            fencei_flush = 0;
            read_instruction_address = '0;
            read_instruction_enable = 0;
            write_instruction_enable = 0;
            write_instruction_address = '0;
            write_instruction_data = '0;
            
            #OPERATION_DURATION
            reset = 0;
            @(negedge clk)
            
            fencei_flush = 1;
            
            @(negedge clk)
            
            if (instruction == INSTRUCTION_WIDTH'('h00000013))
                begin
                    $display("SUCCESS: FENCE.I command was implemented correctly.");
                end
            else
                begin
                    $display("FAIL:  FENCE.I command was not implemented correctly.");
                end
            
            fencei_flush = 0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            read_instruction_enable = 1;
            read_instruction_address = '0;
            
            @(negedge clk)
            
            if (instruction == INSTRUCTION_WIDTH'('h000123ac))
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d.", instruction, read_instruction_address);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d.", instruction, read_instruction_address);
                end
                
            @(negedge clk)
            
            read_instruction_enable = 0;
            read_instruction_address = '0;
                
            #OPERATION_DURATION
            @(negedge clk)
            
            read_instruction_enable = 1;
            read_instruction_address = ADDRESS_WIDTH'(4);
            
            @(negedge clk)

            if (instruction == INSTRUCTION_WIDTH'('h00ae2317))
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d.", instruction, read_instruction_address);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d.", instruction, read_instruction_address);
                end
                
            @(negedge clk)
            
            read_instruction_enable = 0;
            read_instruction_address = '0;
            
            #OPERATION_DURATION
            @(negedge clk)
            
            read_instruction_enable = 1;
            read_instruction_address = ADDRESS_WIDTH'(8);
            
            @(negedge clk)

            if (instruction == INSTRUCTION_WIDTH'('h471cd320))
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d.", instruction, read_instruction_address);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d.", instruction, read_instruction_address);
                end
            
            @(negedge clk)
            
            read_instruction_enable = 0;
            read_instruction_address = '0;
                
            #OPERATION_DURATION
            @(negedge clk)
            
            write_instruction_address = ADDRESS_WIDTH'(24);
            write_instruction_enable = 1;
            write_instruction_data = DATA_WIDTH'('h45ace120);
            
            @(negedge clk)
            
            write_instruction_enable = 0;
            read_instruction_enable = 1;
            
            @(negedge clk)

           if (write_instruction_data == INSTRUCTION_WIDTH'('h45ace120))
                begin
                    $display("SUCCESS: Expected data (%d) were written in the address cell %d.", write_instruction_data, write_instruction_address);
                end
           else
                begin
                    $display("FAIL: Expected data (%d) were not written located in the address cell %d.", write_instruction_data, write_instruction_address);
                end
                
           write_instruction_enable = 0;
           read_instruction_enable = 0;
           write_instruction_address = '0;
           write_instruction_enable = 0;
           write_instruction_data = '0;
                
           #OPERATION_DURATION
           $finish;
        end

endmodule

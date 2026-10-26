`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Instruction_Memory_tb #();


    logic [ADDRESS_WIDTH-1:0] address;
    logic [INSTRUCTION_WIDTH-1:0] instruction;
    
    Instruction_Memory uut (
        .address(address),
        .instruction(instruction)
    );
    
    
    initial
        begin
            address = '0;
            
            #PROPAGATION_DELAY
            
            if (instruction == INSTRUCTION_WIDTH'('h000123ac))
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d.", instruction, address);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d.", instruction, address);
                end
                
            #OPERATION_DURATION
                
            address = ADDRESS_WIDTH'(4);
            
            #PROPAGATION_DELAY
            
            if (instruction == INSTRUCTION_WIDTH'('h00ae2317))
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d.", instruction, address);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d.", instruction, address);
                end
                
            #OPERATION_DURATION

           address = ADDRESS_WIDTH'(8);
           
           #PROPAGATION_DELAY

           if (instruction == INSTRUCTION_WIDTH'('h471cd320))
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d.", instruction, address);
                end
           else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d.", instruction, address);
                end
                
           #200 $finish;
        end

endmodule

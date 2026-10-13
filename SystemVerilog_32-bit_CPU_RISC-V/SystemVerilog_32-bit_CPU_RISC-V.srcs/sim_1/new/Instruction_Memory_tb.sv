`timescale 1ns / 1ps


module Instruction_Memory_tb #(parameter ADDRESS_WIDTH = 32, INSTRUCTION_WIDTH = 32);


    logic [ADDRESS_WIDTH-1:0] address;
    logic [INSTRUCTION_WIDTH-1:0] instruction;
    
    Instruction_Memory uut (
        .address(address),
        .instruction(instruction)
    );
    
    
    initial
        begin
            address = 32'b00000000000000000000000000000000;
            #1
            
            if (instruction == 32'h000123ac)
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d", instruction, address);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d", instruction, address);
                end
            #200
                
            address = 32'b00000000000000000000000000000100;
            #1
            
            if (instruction == 32'h00ae2317)
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d", instruction, address);
                end
            else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d", instruction, address);
                end
            #200
                

           address = 32'b00000000000000000000000000001000;
           #1

           if (instruction == 32'h471cd320)
                begin
                    $display("SUCCESS: Expected data (%d) is located in the address cell %d", instruction, address);
                end
           else
                begin
                    $display("FAIL: Expected data (%d) is not located in the address cell %d", instruction, address);
                end
                
           #200 $finish;
        end

endmodule

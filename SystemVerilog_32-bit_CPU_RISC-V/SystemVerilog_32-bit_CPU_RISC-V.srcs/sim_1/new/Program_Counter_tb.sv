`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Program_Counter_tb #();


    logic clk;
    logic reset;
    
    logic [6:0] operation_code;
    logic [2:0] function3;
    
    logic next_address_enable;
    
    logic [ADDRESS_WIDTH-1:0] auipc_offset;
    logic [ADDRESS_WIDTH-1:0] auipc_offset_address;
    logic [ADDRESS_WIDTH-1:0] branch_offset;
    logic [ADDRESS_WIDTH-1:0] jump_jal_offset;
    logic [ADDRESS_WIDTH-1:0] jump_jalr_target;
    logic [ADDRESS_WIDTH-1:0] return_instruction_address;
    
    logic equal;
    logic signed_less;
    logic unsigned_less;
    
    logic [ADDRESS_WIDTH-1:0] instruction_address;
    
    
    Program_Counter uut (
        .clk(clk),
        .reset(reset),
        .operation_code(operation_code),
        .function3(function3),
        .next_address_enable(next_address_enable),
        .auipc_offset(auipc_offset),
        .auipc_offset_address(auipc_offset_address),
        .branch_offset(branch_offset),
        .jump_jal_offset(jump_jal_offset),
        .jump_jalr_target(jump_jalr_target),
        .return_instruction_address(return_instruction_address),
        .equal(equal),
        .signed_less(signed_less),
        .unsigned_less(unsigned_less),
        .instruction_address(instruction_address)
    );
    
    
    always
        begin
            #5 clk = ~clk;
        end
        
        
    initial
        begin
            clk = 0;
            reset = 1;
            operation_code = '0;
            function3 = '0;
            next_address_enable = 0;
            auipc_offset = '0;
            auipc_offset_address = '0;
            branch_offset = '0;
            jump_jal_offset = '0;
            jump_jalr_target = '0;  
            equal = 0;
            signed_less = 0;
            unsigned_less = 0;
            
            #200
            @(negedge clk)      
            
            reset = 0;
            next_address_enable = 1;
            
            @(negedge clk)
            
            next_address_enable = 0;
            if (instruction_address == ADDRESS_WIDTH'(4))
                begin
                    $display("SUCCESS: Expected instruction address (%d) was received correctly", instruction_address);
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) was not received correctly", instruction_address);
                end
            
            //!\\ - IN PROGRESS!!!
            /*
            #200
            @(negedge clk)      
            
            reset = 0;
            next_address_enable = 1;
            operation_code = 0010111;
            function3 = '0;
            
            @(posedge clk)
            #1
            
            next_address_enable = 0;
            if (instruction_address == 8'd20)
                begin
                    $display("SUCCESS: Expected instruction address (%d) was received correctly", instruction_address);
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) was not received correctly", instruction_address);
                end
                
            #200
            @(negedge clk)      
            
            reset = 1;
            next_address_enable = 0;
            jump_enable = 0;
            target_address  = '0;
            
            @(posedge clk)
            #1
            
            if (instruction_address == '0)
                begin
                    $display("SUCCESS: Expected instruction address (%d) was received correctly", instruction_address);
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) was not received correctly", instruction_address);
                end
                
            #200
            @(negedge clk)      
            
            reset = 0;
            next_address_enable = 0;
            jump_enable = 0;
            target_address  = 29;
            
            @(posedge clk)
            #1
            
            next_address_enable = 0;
            if (instruction_address == '0)
                begin
                    $display("SUCCESS: Expected instruction address was not changed", instruction_address);
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) was changed", instruction_address);
                end
                */
            #200
            $finish;
        end


endmodule

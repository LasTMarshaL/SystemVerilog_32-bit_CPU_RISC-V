`timescale 1ns / 1ps


module Program_Counter_tb #(parameter ADDRESS_WIDTH = 8);


    logic clk;
    logic reset;
    
    logic next_address_enable;
    logic jump_enable;
    logic [ADDRESS_WIDTH-1:0] target_address;
    
    logic [ADDRESS_WIDTH-1:0] instruction_address;
    
    
    Program_Counter uut (
        .clk(clk),
        .reset(reset),
        .next_address_enable(next_address_enable),
        .jump_enable(jump_enable),
        .target_address(target_address),
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
            next_address_enable = 0;
            jump_enable = 0;
            target_address  = '0;
            
            #200
            @(negedge clk)      
            
            reset = 0;
            next_address_enable = 0;
            jump_enable = 1;
            target_address = 19;
            
            @(posedge clk)
            #1
            
            jump_enable = 1;
            if (instruction_address == 8'd19)
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
            next_address_enable = 1;
            jump_enable = 0;
            target_address  = '0;
            
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
            #200 $finish;
        end


endmodule

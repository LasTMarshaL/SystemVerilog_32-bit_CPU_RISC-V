`timescale 1ns / 1ps

module Control_Unit_tb #(parameter INSTRUCTION_WIDTH = 16, OPERATION_WIDTH = 4);

    
    logic clk;
    logic reset;
    
    logic [INSTRUCTION_WIDTH-1:0] instruction;
    
    logic [OPERATION_WIDTH-1:0] alu_operation;
    logic zero_flag;
    logic register_write_enable;  
    logic jump_enable;
    logic next_address_enable;
    
    logic data_memory_read_enable;  
    logic data_memory_write_enable;      
    logic [1:0] register_write_source;
    
    
    Control_Unit uut (
        .instruction(instruction),
        .alu_operation(alu_operation),
        .zero_flag(zero_flag),
        .register_write_enable(register_write_enable),
        .jump_enable(jump_enable),
        .next_address_enable(next_address_enable),
        .data_memory_read_enable(data_memory_read_enable),
        .data_memory_write_enable(data_memory_write_enable),
        .register_write_source(register_write_source)
    );
    
    
    always
        begin
            #5 clk = ~clk;
        end
    
    initial
        begin
            clk = 0;
            reset = 1;
            zero_flag = 1'b0;
            instruction = '0;
            
            #200
            @(negedge clk)
            
            instruction = {4'b1101, 12'b0};
            
            #5
            if (register_write_enable == 1'b1)
                begin
                     $display("SUCCESS LOADI: Expected result (%d) was received correctly", register_write_enable);
                end
            else
                begin
                    $display("FAIL LOADI: Expected result (%d) was not received correctly", register_write_enable);
                end
            if (register_write_source == 2'b10)
                begin
                     $display("SUCCESS LOADI: Expected result (%d) was received correctly", register_write_source);
                end
            else
                begin
                    $display("FAIL LOADI: Expected result (%d) was not received correctly", register_write_source);
                end
                
            #200
            @(negedge clk)
            
            instruction = {4'b1011, 12'b0};
            
            #20
   
            @(posedge clk)
            #1 
            
            if (data_memory_read_enable == 1'b1)
                begin
                     $display("SUCCESS LOAD: Expected result (%d) was received correctly", data_memory_read_enable);
                end
            else
                begin
                    $display("FAIL LOAD: Expected result (%d) was not received correctly", data_memory_read_enable);
                end
            if (register_write_enable == 1'b1)
                begin
                     $display("SUCCESS LOAD: Expected result (%d) was received correctly", register_write_enable);
                end
            else
                begin
                    $display("FAIL LOAD: Expected result (%d) was not received correctly", register_write_enable);
                end
            if (register_write_source == 2'b01)
                begin
                     $display("SUCCESS LOAD: Expected result (%d) was received correctly", register_write_source);
                end
            else
                begin
                    $display("FAIL LOAD: Expected result (%d) was not received correctly", register_write_source);
                end
                
            #200
            @(negedge clk)
            
            instruction = {4'b0100, 12'b0};
            
            @(posedge clk)
            #1 
            if (data_memory_write_enable == 1'b1)
                begin
                     $display("SUCCESS STORE: Expected result (%d) was received correctly", data_memory_write_enable);
                end
            else
                begin
                    $display("FAIL STORE: Expected result (%d) was not received correctly", data_memory_write_enable);
                end
            if (register_write_enable == 1'b0)
                begin
                     $display("SUCCESS STORE: Expected result (%d) was received correctly", register_write_enable);
                end
            else
                begin
                    $display("FAIL STORE: Expected result (%d) was not received correctly", register_write_enable);
                end
                
            #200
            @(negedge clk)
            
            instruction = {4'b0010, 12'b0};
            
            @(posedge clk)
            #1 
            if (jump_enable == 1'b1)
                begin
                     $display("SUCCESS JMP: Expected result (%d) was received correctly", jump_enable);
                end
            else
                begin
                    $display("FAIL JMP: Expected result (%d) was not received correctly", jump_enable);
                end
                
            #200
            @(negedge clk)
            
            zero_flag = 1'b1;
            instruction = {4'b1001, 12'b0};
            
            @(posedge clk)
            #1 
            if (jump_enable == 1'b1)
                begin
                     $display("SUCCESS JZ: Expected result (%d) was received correctly", jump_enable);
                end
            else
                begin
                    $display("FAIL JZ: Expected result (%d) was not received correctly", jump_enable);
                end
                
            #200
            @(negedge clk)
            
            zero_flag = 1'b0;
            instruction = {4'b0001, 12'b0};
            
            @(posedge clk)
            #1 
            
            if (register_write_enable == 1'b1)
                begin
                     $display("SUCCESS ALU: Expected result (%d) was received correctly", register_write_enable);
                end
            else
                begin
                    $display("FAIL ALU: Expected result (%d) was not received correctly", register_write_enable);
                end
            if (register_write_source == 2'b00)
                begin
                     $display("SUCCESS ALU: Expected result (%d) was received correctly", register_write_source);
                end
            else
                begin
                    $display("FAIL ALU: Expected result (%d) was not received correctly", register_write_source);
                end
                
            #200
            $finish;
        end


endmodule

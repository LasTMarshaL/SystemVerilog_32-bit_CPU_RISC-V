`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Program_Counter_tb;


    logic clk;
    logic reset;
    
    logic [OPERATION_CODE-1:0] operation_code;
    logic [FUNCTION_THREE-1:0] function3;
    
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
    
    logic [ADDRESS_WIDTH-1:0] latched_return_instruction_address;
    
    
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
            #PROPAGATION_DELAY clk = ~clk;
        end
        
        
    initial
        begin
            clk = 0;
            reset = 1;
            operation_code = '0;
            function3 = '0;
            next_address_enable = 0;
            auipc_offset = '0;
            branch_offset = '0;
            jump_jal_offset = '0;
            jump_jalr_target = '0;  
            equal = 0;
            signed_less = 0;
            unsigned_less = 0;
            
            latched_return_instruction_address = '0;
            
            #OPERATION_DURATION
            @(negedge clk)      
            
            reset = 0;
            next_address_enable = 1;
            
            @(negedge clk)
            
            next_address_enable = 0;
            if (instruction_address == ADDRESS_WIDTH'(4))
                begin
                    $display("SUCCESS: Expected instruction address (%d) was received correctly.", instruction_address);
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) was not received correctly.", instruction_address);
                end
            
            
            #OPERATION_DURATION // AUIPC
            @(negedge clk)      
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b0010111);
            function3 = '0;
            auipc_offset = ADDRESS_WIDTH'(400);
            
            @(negedge clk)  
            
            latched_return_instruction_address = return_instruction_address;
            next_address_enable = 0;
            auipc_offset = '0;
            if (instruction_address == ADDRESS_WIDTH'(8) && latched_return_instruction_address == ADDRESS_WIDTH'(12) && auipc_offset_address == ADDRESS_WIDTH'(408))
                begin
                    $display("SUCCESS: Expected instruction address, latched_return_instruction_address, auipc_offset_address (%d, %d, %d) were received correctly.", instruction_address, latched_return_instruction_address, auipc_offset_address);
                end
            else
                begin
                    $display("FAIL: Expected instruction address, latched_return_instruction_address, auipc_offset_address (%d, %d, %d) were not received correctly.", instruction_address, latched_return_instruction_address, auipc_offset_address);
                end
                
            #OPERATION_DURATION // JALR
            @(negedge clk)      
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100111);
            function3 = FUNCTION_THREE'('b000);
            latched_return_instruction_address = return_instruction_address; 
            jump_jalr_target = ADDRESS_WIDTH'(52);
            
            @(negedge clk) 
            
            next_address_enable = 0;
            jump_jalr_target = '0;
            if (instruction_address == ADDRESS_WIDTH'(52) && latched_return_instruction_address == ADDRESS_WIDTH'(12))
                begin
                    $display("SUCCESS: Expected instruction address, latched_return_instruction_address (%d, %d) were received correctly.", instruction_address, latched_return_instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address, latched_return_instruction_address (%d, %d) were not received correctly.", instruction_address, latched_return_instruction_address); 
                end
            latched_return_instruction_address = '0;
                
            #OPERATION_DURATION // JAL
            @(negedge clk)      
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1101111);          
            function3 = '0;
            latched_return_instruction_address = return_instruction_address;                   
            jump_jal_offset = ADDRESS_WIDTH'(192);
            
           @(negedge clk)
            
            next_address_enable = 0;
            jump_jal_offset = '0;
            if (instruction_address == ADDRESS_WIDTH'(244) && latched_return_instruction_address == ADDRESS_WIDTH'(56))
                begin
                    $display("SUCCESS: Expected instruction address, latched_return_instruction_address (%d, %d) were received correctly.", instruction_address, latched_return_instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address, latched_return_instruction_address (%d, %d) were not received correctly.", instruction_address, latched_return_instruction_address); 
                end
            latched_return_instruction_address = '0;
            
            reset = 1; // For convinience in simulation (start SB block checking from 0 address)
            
            @(negedge clk)
            
            reset = 0;
            
            #OPERATION_DURATION // BEQ
            @(negedge clk)      
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b000);              
            equal = 1;
            branch_offset = ADDRESS_WIDTH'(16);
            
           @(negedge clk)
            
            next_address_enable = 0;
            equal = 0;
            if (instruction_address == ADDRESS_WIDTH'(16))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end
                
            #OPERATION_DURATION // BEQ
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b000);              
            equal = 0;
            branch_offset = ADDRESS_WIDTH'(16);
            
           @(negedge clk)
            
            next_address_enable = 0;
            equal = 0;
            if (instruction_address == ADDRESS_WIDTH'(20))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end          
   
                
            #OPERATION_DURATION // BNE
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b001);              
            equal = 0;
            branch_offset = ADDRESS_WIDTH'(8);
            
           @(negedge clk)
            
            next_address_enable = 0;
            equal = 0;
            if (instruction_address == ADDRESS_WIDTH'(28))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end
                
            #OPERATION_DURATION // BNE
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b001);              
            equal = 1;
            branch_offset = ADDRESS_WIDTH'(12);
            
           @(negedge clk)
            
            next_address_enable = 0;
            equal = 0;
            if (instruction_address == ADDRESS_WIDTH'(32))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end
                
            #OPERATION_DURATION // BLT
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b100);              
            signed_less = 1;
            branch_offset = ADDRESS_WIDTH'(20);
            
           @(negedge clk)
            
            next_address_enable = 0;
            signed_less = 0;
            if (instruction_address == ADDRESS_WIDTH'(52))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end
                
            #OPERATION_DURATION // BLT
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b100);              
            signed_less = 0;
            branch_offset = ADDRESS_WIDTH'(24);
            
           @(negedge clk)
            
            next_address_enable = 0;
            signed_less = 0;
            if (instruction_address == ADDRESS_WIDTH'(56))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end
                
            #OPERATION_DURATION // BGE
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b101);              
            signed_less = 0;
            branch_offset = ADDRESS_WIDTH'(8);
            
           @(negedge clk)
            
            next_address_enable = 0;
            signed_less = 0;
            if (instruction_address == ADDRESS_WIDTH'(64))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end
                
            #OPERATION_DURATION // BGE
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b101);              
            signed_less = 1;
            branch_offset = ADDRESS_WIDTH'(128);
            
           @(negedge clk)
            
            next_address_enable = 0;
            signed_less = 0;
            if (instruction_address == ADDRESS_WIDTH'(68))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end 
                
            #OPERATION_DURATION // BLTU
            @(negedge clk)      
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b110);              
            unsigned_less = 1;
            branch_offset = ADDRESS_WIDTH'(12);
            
           @(negedge clk)
            
            next_address_enable = 0;
            unsigned_less = 0;
            if (instruction_address == ADDRESS_WIDTH'(80))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end
                
            #OPERATION_DURATION // BLTU
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b110);              
            unsigned_less = 0;
            branch_offset = ADDRESS_WIDTH'(16);
            
           @(negedge clk)
            
            next_address_enable = 0;
            unsigned_less = 0;
            if (instruction_address == ADDRESS_WIDTH'(84))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end 
                
            #OPERATION_DURATION // BGEU
            @(negedge clk)      
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b111);              
            unsigned_less = 0;
            branch_offset = ADDRESS_WIDTH'(16);
            
           @(negedge clk)
            
            next_address_enable = 0;
            unsigned_less = 0;
            if (instruction_address == ADDRESS_WIDTH'(100))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end
                
            #OPERATION_DURATION // BGEU
            @(negedge clk)                 
            
            next_address_enable = 1;
            operation_code = OPERATION_CODE'('b1100011);          
            function3 = FUNCTION_THREE'('b111);              
            unsigned_less = 1;
            branch_offset = ADDRESS_WIDTH'(40);
            
           @(negedge clk)
            
            next_address_enable = 0;
            unsigned_less = 0;
            if (instruction_address == ADDRESS_WIDTH'(104))
                begin
                    $display("SUCCESS: Expected instruction address (%d) were received correctly.", instruction_address);                           
                end
            else
                begin
                    $display("FAIL: Expected instruction address (%d) were not received correctly.", instruction_address); 
                end 
                
            #OPERATION_DURATION 
            $finish;
        end


endmodule

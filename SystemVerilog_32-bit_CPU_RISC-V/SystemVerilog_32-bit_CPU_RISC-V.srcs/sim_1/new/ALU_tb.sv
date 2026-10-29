`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module ALU_tb;


    logic [OPERATION_CODE-1:0] operation_code;
    logic [FUNCTION_THREE-1:0] function3;
    logic [FUNCTION_SEVEN-1:0] function7;
    
    logic [DATA_WIDTH-1:0] data_in_operand_a;
    logic [DATA_WIDTH-1:0] data_in_operand_b;
    
    logic [DATA_WIDTH-1:0] data_out;
    logic zero;
    logic ltu;
    logic lt;
    
    ALU uut (
        .operation_code(operation_code),
        .function3(function3),
        .function7(function7),
        .data_in_operand_a(data_in_operand_a),
        .data_in_operand_b(data_in_operand_b),
        .data_out(data_out),
        .zero(zero),
        .ltu(ltu),
        .lt(lt)
    );
    
    
    initial
        begin
            operation_code = '0;
            function3 = '0;
            function7 = '0;
            data_in_operand_a = '0;
            data_in_operand_b = '0;
            
            #PROPAGATION_DELAY
            
            if (data_out == '0)
                begin
                     $display("SUCCESS DEFAULT: 0 was got correctly.");
                end
            else
                begin
                    $display("FAIL DEFAULT: 0 was not got correctly.");
                end
            
            #OPERATION_DURATION // ADD
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b000);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd453748);
            data_in_operand_b = DATA_WIDTH'('sd3144556);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'('sd3598304))
                begin
                     $display("SUCCESS ADD: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL ADD: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SUB
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b000);
            function7 = FUNCTION_SEVEN'('b0100000);
            data_in_operand_a = DATA_WIDTH'('sd57467);
            data_in_operand_b = DATA_WIDTH'('sd46685);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'('sd10782))
                begin
                     $display("SUCCESS SUB: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL SUB: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SLL
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b001);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd45425);
            data_in_operand_b = DATA_WIDTH'('sd4);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'('sd726800))
                begin
                     $display("SUCCESS SLL: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL SLL: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SLL
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b001);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd45425);
            data_in_operand_b = DATA_WIDTH'('sd40);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'('sd11628800))
                begin
                     $display("SUCCESS SLL: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL SLL: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SLT
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b010);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd34);
            data_in_operand_b = DATA_WIDTH'('sd45355);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'(1)) 
                begin
                     $display("SUCCESS STL: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL STL: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SLT
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b010);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd341578);
            data_in_operand_b = DATA_WIDTH'('sd47495);
            
            #PROPAGATION_DELAY
            
            if (data_out == '0) 
                begin
                     $display("SUCCESS STL: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL STL: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SLTU
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b011);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'(34256);
            data_in_operand_b = DATA_WIDTH'(7468946);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'(1)) 
                begin
                     $display("SUCCESS STLU: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL STLU: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SLTU
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b011);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'(3425635);
            data_in_operand_b = DATA_WIDTH'(74686);
            
            #PROPAGATION_DELAY
            
            if (data_out == '0) 
                begin
                     $display("SUCCESS STLU: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL STLU: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // XOR
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b100);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd341578);
            data_in_operand_b = DATA_WIDTH'('sd231345);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'('sd438779)) 
                begin
                     $display("SUCCESS XOR: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL XOR: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // XOR
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b100);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd42665);
            data_in_operand_b = DATA_WIDTH'('sd42665);
            
            #PROPAGATION_DELAY
            
            if (data_out == '0) 
                begin
                     $display("SUCCESS XOR: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL XOR: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SRL
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b101);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'(324450);
            data_in_operand_b = DATA_WIDTH'(3);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'(40556)) 
                begin
                     $display("SUCCESS SRL: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL SRL: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SRL
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b101);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'(4566);
            data_in_operand_b = DATA_WIDTH'(450949);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'(142)) 
                begin
                     $display("SUCCESS SRL: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL SRL: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SRA
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b101);
            function7 = FUNCTION_SEVEN'('b0100000);
            data_in_operand_a = -DATA_WIDTH'('sd45886);
            data_in_operand_b = DATA_WIDTH'('sd6);
            
            #PROPAGATION_DELAY
            
            if (data_out == -DATA_WIDTH'('sd717)) 
                begin
                     $display("SUCCESS SRA: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL SRA: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // SRA
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b101);
            function7 = FUNCTION_SEVEN'('b0100000);
            data_in_operand_a = DATA_WIDTH'('sd467665);
            data_in_operand_b = DATA_WIDTH'('sd36);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'('sd29229)) 
                begin
                     $display("SUCCESS SRA: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL SRA: Expected result (%d) was not received correctly.", data_out);
                end
            
            #OPERATION_DURATION // OR
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b110);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd0);
            data_in_operand_b = -DATA_WIDTH'('sd2452);
            
            #PROPAGATION_DELAY
            
            if (data_out == -DATA_WIDTH'('sd2452)) 
                begin
                     $display("SUCCESS OR: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL OR: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // OR
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b110);
            function7 = '0;
            data_in_operand_a = -DATA_WIDTH'('sd8667);
            data_in_operand_b = DATA_WIDTH'('sd3127);
            
            #PROPAGATION_DELAY
            
            if (data_out == -DATA_WIDTH'('sd8649)) 
                begin
                     $display("SUCCESS OR: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL OR: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION // OR
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b110);
            function7 = '0;
            data_in_operand_a = '0;
            data_in_operand_b = '0;
            
            #PROPAGATION_DELAY
            
            if (data_out == '0) 
                begin
                     $display("SUCCESS OR: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL OR: Expected result (%d) was not received correctly.", data_out);
                end
            
            #OPERATION_DURATION // AND
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b111);
            function7 = '0;
            data_in_operand_a = DATA_WIDTH'('sd6744);
            data_in_operand_b = DATA_WIDTH'('sd1234);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'('sd80)) 
                begin
                     $display("SUCCESS AND: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL AND: Expected result (%d) was not received correctly.", data_out);
                end
            
            #OPERATION_DURATION // AND
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b111);
            function7 = '0;
            data_in_operand_a = -DATA_WIDTH'('sd8667);
            data_in_operand_b = DATA_WIDTH'('sd3127);
            
            #PROPAGATION_DELAY
            
            if (data_out == DATA_WIDTH'('sd3109))
                begin
                     $display("SUCCESS AND: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL AND: Expected result (%d) was not received correctly.", data_out);
                end
            
            #OPERATION_DURATION // AND
            
            operation_code = OPERATION_CODE'('b0110011);
            function3 = FUNCTION_THREE'('b111);
            function7 = '0;
            data_in_operand_a = '0;
            data_in_operand_b = DATA_WIDTH'('sd31567);
            
            #PROPAGATION_DELAY
            
            if (data_out == '0) 
                begin
                     $display("SUCCESS AND: Expected result (%d) was received correctly.", data_out);
                end
            else
                begin
                    $display("FAIL AND: Expected result (%d) was not received correctly.", data_out);
                end
                
            #OPERATION_DURATION
            $finish;
        end


endmodule

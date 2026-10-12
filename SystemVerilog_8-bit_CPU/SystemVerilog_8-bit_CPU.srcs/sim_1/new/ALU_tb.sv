`timescale 1ns / 1ps


module ALU_tb #(parameter DATA_WIDTH = 32);


    logic [6:0] operation_code;
    logic [2:0] function3;
    logic [6:0] function7;
    
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
            
            #5
            if (data_out == '0)
                begin
                     $display("SUCCESS DEFAULT: 0 was got correctly");
                end
            else
                begin
                    $display("FAIL DEFAULT: 0 was not got correctly");
                end
            
            #200 // ADD
            operation_code = 7'b0110011;
            function3 = 3'b000;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd453748;
            data_in_operand_b = 32'sd3144556;
            
            #5
            if (data_out == 32'sd3598304)
                begin
                     $display("SUCCESS ADD: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL ADD: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SUB
            operation_code = 7'b0110011;
            function3 = 3'b000;
            function7 = 7'b0100000;
            data_in_operand_a = 32'sd57467;
            data_in_operand_b = 32'sd46685;
            
            #5
            if (data_out == 32'sd10782)
                begin
                     $display("SUCCESS SUB: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL SUB: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SLL
            operation_code = 7'b0110011;
            function3 = 3'b001;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd45425;
            data_in_operand_b = 32'sd4;
            
            #5
            if (data_out == 32'sd726800)
                begin
                     $display("SUCCESS SLL: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL SLL: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SLL
            operation_code = 7'b0110011;
            function3 = 3'b001;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd45425;
            data_in_operand_b = 32'sd40;
            
            #5
            if (data_out == 32'sd11628800)
                begin
                     $display("SUCCESS SLL: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL SLL: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SLT
            operation_code = 7'b0110011;
            function3 = 3'b010;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd34;
            data_in_operand_b = 32'sd45355;
            
            #5
            if (data_out == 32'sd1) 
                begin
                     $display("SUCCESS STL: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL STL: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SLT
            operation_code = 7'b0110011;
            function3 = 3'b010;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd341578;
            data_in_operand_b = 32'sd47495;
            
            #5
            if (data_out == 32'sd0) 
                begin
                     $display("SUCCESS STL: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL STL: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SLTU
            operation_code = 7'b0110011;
            function3 = 3'b011;
            function7 = 7'b0000000;
            data_in_operand_a = 32'd34256;
            data_in_operand_b = 32'd7468946;
            
            #5
            if (data_out == 32'sd1) 
                begin
                     $display("SUCCESS STLU: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL STLU: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SLTU
            operation_code = 7'b0110011;
            function3 = 3'b011;
            function7 = 7'b0000000;
            data_in_operand_a = 32'd3425635;
            data_in_operand_b = 32'd74686;
            
            #5
            if (data_out == 32'sd0) 
                begin
                     $display("SUCCESS STLU: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL STLU: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // XOR
            operation_code = 7'b0110011;
            function3 = 3'b100;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd341578;
            data_in_operand_b = 32'sd231345;
            
            #5
            if (data_out == 32'sd438779) 
                begin
                     $display("SUCCESS XOR: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL XOR: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // XOR
            operation_code = 7'b0110011;
            function3 = 3'b100;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd42665;
            data_in_operand_b = 32'sd42665;
            
            #5
            if (data_out == 32'sd0) 
                begin
                     $display("SUCCESS XOR: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL XOR: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SRL
            operation_code = 7'b0110011;
            function3 = 3'b101;
            function7 = 7'b0000000;
            data_in_operand_a = 32'd324450;
            data_in_operand_b = 32'd3;
            
            #5
            if (data_out == 32'd40556) 
                begin
                     $display("SUCCESS SRL: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL SRL: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SRL
            operation_code = 7'b0110011;
            function3 = 3'b101;
            function7 = 7'b0000000;
            data_in_operand_a = 32'd4566;
            data_in_operand_b = 32'd450949;
            
            #5
            if (data_out == 32'd142) 
                begin
                     $display("SUCCESS SRL: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL SRL: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SRA
            operation_code = 7'b0110011;
            function3 = 3'b101;
            function7 = 7'b0100000;
            data_in_operand_a = -32'sd45886;
            data_in_operand_b = 32'sd6;
            
            #5
            if (data_out == -32'sd717) 
                begin
                     $display("SUCCESS SRA: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL SRA: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // SRA
            operation_code = 7'b0110011;
            function3 = 3'b101;
            function7 = 7'b0100000;
            data_in_operand_a = 32'sd467665;
            data_in_operand_b = 32'sd36;
            
            #5
            if (data_out == 32'sd29229) 
                begin
                     $display("SUCCESS SRA: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL SRA: Expected result (%d) was not received correctly", data_out);
                end
            
            #200 // OR
            operation_code = 7'b0110011;
            function3 = 3'b110;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd0;
            data_in_operand_b = -32'sd2452;
            
            #5
            if (data_out == -32'sd2452) 
                begin
                     $display("SUCCESS OR: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL OR: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // OR
            operation_code = 7'b0110011;
            function3 = 3'b110;
            function7 = 7'b0000000;
            data_in_operand_a = -32'sd8667;
            data_in_operand_b = 32'sd3127;
            
            #5
            if (data_out == -32'sd8649) 
                begin
                     $display("SUCCESS OR: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL OR: Expected result (%d) was not received correctly", data_out);
                end
                
            #200 // OR
            operation_code = 7'b0110011;
            function3 = 3'b110;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd0;
            data_in_operand_b = 32'sd0;
            
            #5
            if (data_out == 32'sd0) 
                begin
                     $display("SUCCESS OR: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL OR: Expected result (%d) was not received correctly", data_out);
                end
            
            #200 // AND
            operation_code = 7'b0110011;
            function3 = 3'b111;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd6744;
            data_in_operand_b = 32'sd1234;
            
            #5
            if (data_out == 32'sd80) 
                begin
                     $display("SUCCESS AND: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL AND: Expected result (%d) was not received correctly", data_out);
                end
            
            #200 // AND
            operation_code = 7'b0110011;
            function3 = 3'b111;
            function7 = 7'b0000000;
            data_in_operand_a = -32'sd8667;
            data_in_operand_b = 32'sd3127;
            
            #5
            if (data_out == 32'sd3109) 
                begin
                     $display("SUCCESS AND: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL AND: Expected result (%d) was not received correctly", data_out);
                end
            
            #200 // AND
            operation_code = 7'b0110011;
            function3 = 3'b111;
            function7 = 7'b0000000;
            data_in_operand_a = 32'sd0;
            data_in_operand_b = 32'sd31567;
            
            #5
            if (data_out == 32'sd0) 
                begin
                     $display("SUCCESS AND: Expected result (%d) was received correctly", data_out);
                end
            else
                begin
                    $display("FAIL AND: Expected result (%d) was not received correctly", data_out);
                end
                
            #200
            $finish;
        end


endmodule

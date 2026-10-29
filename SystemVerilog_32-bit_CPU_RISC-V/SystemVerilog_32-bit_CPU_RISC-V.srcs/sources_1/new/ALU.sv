`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module ALU 
(
    input logic [OPERATION_CODE-1:0] operation_code,
    input logic [FUNCTION_THREE-1:0] function3,
    input logic [FUNCTION_SEVEN-1:0] function7,
    
    input logic [DATA_WIDTH-1:0] data_in_operand_a,
    input logic [DATA_WIDTH-1:0] data_in_operand_b,
    
    output logic [DATA_WIDTH-1:0] data_out,
    output logic zero,
    output logic equal,
    output logic ltu,
    output logic lt
);

    
    localparam SHIFT_BITS = $clog2(DATA_WIDTH);
    
    logic [DATA_WIDTH-1:0] temprorary_sum;
    logic alu_zero;
    logic alu_equal;
    logic alu_ltu;
    logic alu_lt;
    
    assign zero = (alu_zero == 1);
    assign equal = (alu_equal == 1);
    assign lt = (alu_lt == 1);
    assign ltu = (alu_ltu == 1);

    always_comb 
        begin
            data_out = '0;
            alu_lt = ($signed(data_in_operand_a) < $signed(data_in_operand_b) ? 1 : 0);
            alu_ltu = (data_in_operand_a < data_in_operand_b ? 1 : 0);
            
            case (operation_code)
                7'b0110011: // R block
                    case (function3)
                        FUNCTION_THREE'('b000): 
                            case (function7)
                                FUNCTION_SEVEN'('b0000000): temprorary_sum = data_in_operand_a + data_in_operand_b; // ADD
                                FUNCTION_SEVEN'('b0100000): temprorary_sum = data_in_operand_a - data_in_operand_b; // SUB
                                default:    temprorary_sum = '0;
                            endcase
                        FUNCTION_THREE'('b001): 
                            case (function7)
                                FUNCTION_SEVEN'('b0000000): temprorary_sum = data_in_operand_a << data_in_operand_b[SHIFT_BITS-1:0]; // SLL
                                default:    temprorary_sum = '0;
                            endcase
                        FUNCTION_THREE'('b010): 
                            case (function7)
                                FUNCTION_SEVEN'('b0000000): temprorary_sum = ($signed(data_in_operand_a) < $signed(data_in_operand_b) ? DATA_WIDTH'(1) : '0); // SLT
                                default:    temprorary_sum = '0;
                            endcase
                        FUNCTION_THREE'('b011): 
                            case (function7)
                                FUNCTION_SEVEN'('b0000000): temprorary_sum = (data_in_operand_a < data_in_operand_b ? DATA_WIDTH'(1) : '0); // SLTU
                                default:    temprorary_sum = '0;
                            endcase
                        FUNCTION_THREE'('b100): 
                            case (function7)
                                FUNCTION_SEVEN'('b0000000): temprorary_sum = (data_in_operand_a ^ data_in_operand_b); // XOR
                                default:    temprorary_sum = '0;
                            endcase
                        FUNCTION_THREE'('b101): 
                            case (function7)
                                FUNCTION_SEVEN'('b0000000): temprorary_sum = data_in_operand_a >> data_in_operand_b[SHIFT_BITS-1:0]; // SRL
                                FUNCTION_SEVEN'('b0100000): temprorary_sum = $unsigned($signed(data_in_operand_a) >>> data_in_operand_b[SHIFT_BITS-1:0]); // SRA
                                default:    temprorary_sum = '0;
                            endcase
                        FUNCTION_THREE'('b110): 
                            case (function7)
                                FUNCTION_SEVEN'('b0000000): temprorary_sum = (data_in_operand_a | data_in_operand_b); // OR
                                default:    temprorary_sum = '0;
                            endcase
                        FUNCTION_THREE'('b111): 
                            case (function7)
                                FUNCTION_SEVEN'('b0000000): temprorary_sum = (data_in_operand_a & data_in_operand_b); // AND
                                default:    temprorary_sum = '0;
                            endcase
                        default: temprorary_sum = '0;
                    endcase
                default: temprorary_sum = '0;
            endcase
            
            data_out = temprorary_sum;
            alu_zero = (data_out == '0);
            alu_equal = (data_in_operand_a == data_in_operand_b);
        end
    

endmodule
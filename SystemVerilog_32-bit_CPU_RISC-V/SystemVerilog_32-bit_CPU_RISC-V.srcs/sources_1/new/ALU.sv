`timescale 1ns / 1ps


module ALU #(parameter DATA_WIDTH = 32)
(
    input logic [6:0] operation_code,
    input logic [2:0] function3,
    input logic [6:0] function7,
    
    input logic [DATA_WIDTH-1:0] data_in_operand_a,
    input logic [DATA_WIDTH-1:0] data_in_operand_b,
    
    output logic [DATA_WIDTH-1:0] data_out,
    output logic zero,
    output logic ltu,
    output logic lt
);


    logic [DATA_WIDTH:0] temprorary_sum;
    logic alu_zero;
    logic alu_ltu;
    logic alu_lt;
    
    assign zero = (alu_zero == 1 ? 1 : 0);
    assign lt = (alu_lt == 1 ? 1 : 0);
    assign ltu = (alu_ltu == 1 ? 1 : 0);

    always_comb 
        begin
            data_out = '0;
            alu_lt = ($signed(data_in_operand_a) < $signed(data_in_operand_b) ? 1 : 0);
            alu_ltu = (data_in_operand_a < data_in_operand_b ? 1 : 0);
            
            case (operation_code)
                7'b0110011: // R block
                    case (function3)
                        3'b000: 
                            case (function7)
                                7'b0000000: temprorary_sum = data_in_operand_a + data_in_operand_b; // ADD
                                7'b0100000: temprorary_sum = data_in_operand_a - data_in_operand_b; // SUB
                                default:    temprorary_sum = '0;
                            endcase
                        3'b001: 
                            case (function7)
                                7'b0000000: temprorary_sum = data_in_operand_a << data_in_operand_b[4:0]; // SLL
                                default:    temprorary_sum = '0;
                            endcase
                        3'b010: 
                            case (function7)
                                7'b0000000: temprorary_sum = ($signed(data_in_operand_a) < $signed(data_in_operand_b) ? 32'b1 : 32'b0); // SLT
                                default:    temprorary_sum = '0;
                            endcase
                        3'b011: 
                            case (function7)
                                7'b0000000: temprorary_sum = (data_in_operand_a < data_in_operand_b ? 1 : 0); // SLTU
                                default:    temprorary_sum = '0;
                            endcase
                        3'b100: 
                            case (function7)
                                7'b0000000: temprorary_sum = (data_in_operand_a ^ data_in_operand_b); // XOR
                                default:    temprorary_sum = '0;
                            endcase
                        3'b101: 
                            case (function7)
                                7'b0000000: temprorary_sum = data_in_operand_a >> data_in_operand_b[4:0]; // SRL
                                7'b0100000: temprorary_sum = $unsigned($signed(data_in_operand_a) >>> data_in_operand_b[4:0]); // SRA
                                default:    temprorary_sum = '0;
                            endcase
                        3'b110: 
                            case (function7)
                                7'b0000000: temprorary_sum = (data_in_operand_a | data_in_operand_b); // OR
                                default:    temprorary_sum = '0;
                            endcase
                        3'b111: 
                            case (function7)
                                7'b0000000: temprorary_sum = (data_in_operand_a & data_in_operand_b); // AND
                                default:    temprorary_sum = '0;
                            endcase
                        default: temprorary_sum = '0;
                    endcase
                default: temprorary_sum = '0;
            endcase
            
            data_out = temprorary_sum;
            alu_zero = (data_out == 0 ? 1 : 0);
        end
    

endmodule
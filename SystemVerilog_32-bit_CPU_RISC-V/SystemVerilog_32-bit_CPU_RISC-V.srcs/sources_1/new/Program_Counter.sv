`timescale 1ns / 1ps


module Program_Counter #(parameter ADDRESS_WIDTH = 32)
(
    input logic clk,
    input logic reset,
    
    input logic [6:0] operation_code,
    input logic [2:0] function3,
    
    input logic next_address_enable,
    
    input logic [ADDRESS_WIDTH-1:0] branch_offset,
    input logic [ADDRESS_WIDTH-1:0] jump_jal_offset,
    input logic [ADDRESS_WIDTH-1:0] jump_jarl_offset,
    input logic [ADDRESS_WIDTH-1:0] return_address,
    
    input logic equal,
    input logic signed_less,
    input logic unsigned_less,
    
    output logic [ADDRESS_WIDTH-1:0] instruction_address
);
    
    
    logic [ADDRESS_WIDTH-1:0] current_instruction_address;
    logic [ADDRESS_WIDTH-1:0] return_instruction_address;
   
    assign return_address = return_instruction_address;
    
    initial
        begin
            current_instruction_address = '0;
        end
        
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    current_instruction_address = 0;
                end
            else
                begin
                if (next_address_enable)
                    begin
                        case (operation_code)
                        7'b0010111: ;// U block, AUIPC
                        7'b1100011: // SB block
                            case (function3)
                                3'b000: current_instruction_address <= current_instruction_address + (equal == 1 ? branch_offset : 0); // BEQ
                                3'b001: current_instruction_address <= current_instruction_address + (equal == 0 ? branch_offset : 0); // BNE
                                3'b100: current_instruction_address <= current_instruction_address + (signed_less == 1 ? branch_offset : 0); // BLT
                                3'b101: current_instruction_address <= current_instruction_address + (signed_less == 0 ? branch_offset : 0); // BGE
                                3'b110: current_instruction_address <= current_instruction_address + (unsigned_less == 1 ? branch_offset : 0); // BLTU
                                3'b111: current_instruction_address <= current_instruction_address + (unsigned_less == 0 ? branch_offset : 0); // BGEU
                                default: ;
                            endcase
                        7'b1100111: // I block
                            case (function3)
                                3'b000: // JARL
                                    begin
                                        return_instruction_address <= current_instruction_address + 3'b100;
                                        current_instruction_address <= current_instruction_address + jump_jarl_offset;
                                    end
                                default: ;
                            endcase
                        7'b1101111: // UJ block, JAL
                            begin
                                return_instruction_address <= current_instruction_address + 32'd4;
                                current_instruction_address <= current_instruction_address + jump_jal_offset;
                            end
                        default: current_instruction_address <= current_instruction_address + 32'd4;
                    endcase
                    end  
                end
        end
        
        
    assign instruction_address = current_instruction_address;
    
    
endmodule

`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Program_Counter
(
    input logic clk,
    input logic reset,
    
    input logic [OPERATION_CODE-1:0] operation_code,
    input logic [FUNCTION_THREE-1:0] function3,
    
    input logic next_address_enable,
    
    input logic [ADDRESS_WIDTH-1:0] auipc_offset,
    output logic [ADDRESS_WIDTH-1:0] auipc_offset_address,
    input logic [ADDRESS_WIDTH-1:0] branch_offset,
    input logic [ADDRESS_WIDTH-1:0] jump_jal_offset,
    input logic [ADDRESS_WIDTH-1:0] jump_jalr_target,
    output logic [ADDRESS_WIDTH-1:0] return_instruction_address,
    
    input logic equal,
    input logic signed_less,
    input logic unsigned_less,
    
    output logic [ADDRESS_WIDTH-1:0] instruction_address
);
    
    
    logic [ADDRESS_WIDTH-1:0] current_instruction_address;
    
    assign return_instruction_address = current_instruction_address + ADDRESS_WIDTH'(4);
    assign auipc_offset_address = current_instruction_address + auipc_offset;
     
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    current_instruction_address <= RESET_ADDRESS;
                end
            else
                begin
                if (next_address_enable)
                    begin
                        case (operation_code)
                        FUNCTION_SEVEN'('b0010111): // U block, AUIPC
                            begin
                                current_instruction_address <= current_instruction_address + ADDRESS_WIDTH'(4);
                            end
                        FUNCTION_SEVEN'('b1100011): // SB block
                            case (function3)
                                FUNCTION_THREE'('b000): current_instruction_address <= current_instruction_address + (equal ? branch_offset : ADDRESS_WIDTH'(4)); // BEQ
                                FUNCTION_THREE'('b001): current_instruction_address <= current_instruction_address + (!equal ? branch_offset : ADDRESS_WIDTH'(4)); // BNE
                                FUNCTION_THREE'('b100): current_instruction_address <= current_instruction_address + (signed_less ? branch_offset : ADDRESS_WIDTH'(4)); // BLT
                                FUNCTION_THREE'('b101): current_instruction_address <= current_instruction_address + (!signed_less ? branch_offset : ADDRESS_WIDTH'(4)); // BGE
                                FUNCTION_THREE'('b110): current_instruction_address <= current_instruction_address + (unsigned_less ? branch_offset : ADDRESS_WIDTH'(4)); // BLTU
                                FUNCTION_THREE'('b111): current_instruction_address <= current_instruction_address + (!unsigned_less? branch_offset : ADDRESS_WIDTH'(4)); // BGEU
                                default: current_instruction_address <= current_instruction_address + ADDRESS_WIDTH'(4);
                            endcase
                        FUNCTION_SEVEN'('b1100111): // I block
                            case (function3)
                                FUNCTION_THREE'('b000): // JALR
                                    begin
                                        current_instruction_address <= jump_jalr_target;
                                    end
                                default: current_instruction_address <= current_instruction_address + ADDRESS_WIDTH'(4);
                            endcase
                        FUNCTION_SEVEN'('b1101111): // UJ block, JAL
                            begin
                                current_instruction_address <= current_instruction_address + jump_jal_offset;
                            end
                        default: current_instruction_address <= current_instruction_address + ADDRESS_WIDTH'(4);
                    endcase
                    end  
                end
        end
        
        
    assign instruction_address = current_instruction_address;
    
    
endmodule

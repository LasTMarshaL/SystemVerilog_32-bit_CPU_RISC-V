`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Control_Unit
(
    input logic clk,
    input logic reset,
      
    input logic [INSTRUCTION_WIDTH-1:0] instruction,
    
    output logic alu_source,
    output logic memory_byte_mask,
    
    output logic read_instruction_enable,
    output logic write_instruction_enable,
    
    output logic read_register_enable,
    output logic write_register_enable,
    
    output logic read_system_register_enable,
    output logic write_system_register_enable,

    input logic [DATA_WIDTH-1:0] outside_exception_code,
    output logic [I_IMMEDIATE_WIDTH-1:0] read_system_register_select,
    output logic [I_IMMEDIATE_WIDTH-1:0] write_system_register_select,

  
    output logic read_memory_enable,
    output logic store_byte,
    output logic store_half_word,
    output logic store_word,
    output logic [DATA_WIDTH/BYTE_SIZE-1:0] write_memory_byte_enable,   
    
    input logic memory_read_finished,
    input logic memory_write_finished,
    // input logic input_read_finished, UART is unknow yet
    // input logic output_write_finished,
    
    output logic fence_stall,
    output logic fencei_flush,
    
    output logic ebreak,
    output logic ecall,
    output logic mret,
    
    output logic next_address_enable
);

    typedef enum logic
    {
        FETCH_START,
        FETCH_WAIT,
        DECODE,
        EXECUTE,
        MEMORY_DELAY,
        SYSTEM_DELAY
    } state_typedef;
    
    state_typedef current_state, next_state;
    
    assign fence_should_stall = (instruction[SR_POSITION] | instruction[SW_POSITION]) & ((instruction[PR_POSITION] & !memory_read_finished) | (instruction[PW_POSITION] & !memory_write_finished));
    
    logic [DATA_WIDTH-1:0] exception_code;   
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    current_state <= FETCH_START;
                end
            else
                begin
                    current_state <= next_state;
                end
        end

    always_comb 
        begin
            exception_code = outside_exception_code;
            next_state = current_state;
            next_address_enable = 0;
            read_instruction_enable = 0;
            write_instruction_enable = 0;
            read_register_enable = 0;
            write_register_enable = 0;
            read_system_register_enable = 0;
            write_system_register_enable = 0;
            read_system_register_select = '0;
            write_system_register_select = '0;
            read_memory_enable = 0;
            store_byte = 0;
            store_half_word = 0;
            store_word = 0;
            write_memory_byte_enable = '0; 
            alu_source = 0;
            fence_stall = 0;
            fencei_flush = 0;
            ebreak = 0;
            ecall = 0;
            mret = 0;
            
            if (current_state == FETCH_START)
                begin
                    read_instruction_enable = 1;
                    next_state = FETCH_WAIT;
                end
            else if (current_state == FETCH_WAIT)
                begin
                    read_instruction_enable = 1;
                    next_state = DECODE;
                end
            else
                begin
                    case(instruction[INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-FUNCTION_THREE-REGISTER_SELECTION_WIDTH-1:INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-FUNCTION_THREE-REGISTER_SELECTION_WIDTH-OPERATION_CODE])
                        OPERATION_CODE'('b0110011): // R block
                            begin
                                if (current_state == DECODE)
                                    begin
                                        read_register_enable = 1;
                                        next_state = EXECUTE;
                                    end
                                else
                                    begin
                                        read_register_enable = 1;
                                        write_register_enable = 1;
                                        next_address_enable = 1;
                                        next_state = FETCH_START;
                                    end
                            end
                        OPERATION_CODE'('b0000011): // I block
                            begin
                                if (current_state == DECODE)
                                    begin
                                        read_register_enable = 1;
                                        next_state = EXECUTE;
                                    end
                                else if (current_state == EXECUTE)
                                    begin
                                        alu_source = 1;
                                        read_register_enable = 1;
                                        read_memory_enable = 1;
                                       /* 
                                        case(instruction[INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-1:INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-FUNCTION_THREE])
                                                FUNCTION_THREE'('b000): // LB
                                                FUNCTION_THREE'('b001): // LH
                                                FUNCTION_THREE'('b010): // LW
                                                FUNCTION_THREE'('b100): // LBU
                                                FUNCTION_THREE'('b101): // LHU
                                        endcase
                                        */
                                        next_state = MEMORY_DELAY;
                                    end
                                else 
                                    begin
                                        read_memory_enable = 1;   
                                        
                                        if (memory_read_finished)
                                            begin
                                                write_register_enable = 1;
                                                next_address_enable = 1;
                                                next_state = FETCH_START; 
                                            end 
                                        else
                                            begin
                                                next_state = MEMORY_DELAY;
                                            end
                                    end
                            end
                        OPERATION_CODE'('b0001111): // I block
                            begin
                                case(instruction[INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-1:INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-FUNCTION_THREE])
                                    FUNCTION_THREE'('b000): // FENCE
                                        begin
                                            if (current_state == DECODE)
                                                begin
                                                    if (fence_should_stall)
                                                        begin
                                                            fence_stall = 1;
                                                            next_state = DECODE;
                                                        end
                                                    else
                                                        begin
                                                            next_state = FETCH_START;
                                                        end
                                                end
                                            else
                                                begin
                                                    next_address_enable = 1;
                                                    next_state = FETCH_START;
                                                end
                                        end
                                    FUNCTION_THREE'('b001): // FENCE.I
                                        begin
                                            if (current_state == DECODE)
                                                begin
                                                    fencei_flush = 1; 
                                                    next_state = EXECUTE;
                                                end
                                            else 
                                                begin
                                                    next_address_enable = 1;
                                                    next_state = FETCH_START;
                                                end
                                        end
                                    default: ;
                                endcase
                            end
                            OPERATION_CODE'('b0010011): // I block
                            begin
                                if (current_state == DECODE)
                                    begin
                                        read_register_enable = 1;
                                        next_state = EXECUTE;
                                    end
                                else
                                    begin
                                        alu_source = 1;
                                        read_register_enable = 1;
                                        write_register_enable = 1;
                                        next_address_enable = 1;
                                        next_state = FETCH_START;
                                    end
                            end
                        OPERATION_CODE'('b1100111): ; // I block
                        OPERATION_CODE'('b1110011): // I block
                            begin
                                case(instruction[INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-1:INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-FUNCTION_THREE])
                                    FUNCTION_THREE'('b000):
                                        begin
                                            if (current_state == DECODE)
                                                begin
                                                    case(instruction[INSTRUCTION_WIDTH-1:INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH])
                                                        I_IMMEDIATE_WIDTH'('b000000000000): // ECALL
                                                            begin
                                                                if (current_state == DECODE)
                                                                    begin
                                                                        read_system_register_enable = 1;
                                                                        next_state = EXECUTE;
                                                                    end
                                                                else if (current_state == EXECUTE)
                                                                    begin
                                                                        read_system_register_enable = 1;
                                                                        write_system_register_enable = 1;
                                                                        next_state = MEMORY_DELAY;
                                                                    end
                                                                else
                                                                    begin
                                                                        exception_code = DATA_WIDTH'(11);
                                                                        write_system_register_select = I_IMMEDIATE_WIDTH'('h342);
                                                                        write_system_register_enable = 1;
                                                                        next_state = FETCH_START;
                                                                        next_address_enable = 1;
                                                                        ecall = 1;
                                                                    end
                                                            end
                                                        I_IMMEDIATE_WIDTH'('b000000000001): // EBRAKE
                                                            begin
                                                                ebreak = 1;
                                                                next_state = current_state;
                                                            end
                                                        I_IMMEDIATE_WIDTH'('b001100000010): // MRET
                                                            begin
                                                                if (current_state == DECODE)
                                                                    begin
                                                                        read_system_register_enable = 1;
                                                                        next_state = EXECUTE;
                                                                    end
                                                                else
                                                                    begin
                                                                        read_system_register_enable = 1;
                                                                        write_system_register_enable = 1;
                                                                        next_state = FETCH_START;
                                                                        next_address_enable = 1;
                                                                        mret = 1;;
                                                                    end
                                                            end
                                                        default: ;
                                                    endcase
                                                end
                                        end
                                    FUNCTION_THREE'('b001): // CSRRW
                                        begin
                                            if (current_state == DECODE)
                                                begin
                                                    read_system_register_enable = 1;
                                                    next_state = EXECUTE;
                                                end
                                            else if (current_state == EXECUTE)
                                                begin
                                                    read_system_register_enable = 1;
                                                    write_register_enable = 1;
                                                    next_state = MEMORY_DELAY;
                                                end
                                            else if (current_state == MEMORY_DELAY)
                                                begin
                                                    read_register_enable = 1;
                                                    next_state = SYSTEM_DELAY;
                                                end
                                            else 
                                                begin
                                                    read_register_enable = 1;
                                                    write_system_register_enable = 1;
                                                    next_state = FETCH_START;
                                                    next_address_enable = 1;
                                                end
                                        end
                                    FUNCTION_THREE'('b101): // CSRRWI 
                                        begin
                                            if (current_state == DECODE)
                                                begin
                                                    read_system_register_enable = 1;
                                                    next_state = EXECUTE;
                                                end
                                            else if (current_state == EXECUTE)
                                                begin
                                                    read_system_register_enable = 1;
                                                    write_register_enable = 1;
                                                    next_state = MEMORY_DELAY;
                                                end
                                            else
                                                begin 
                                                    write_system_register_enable = 1;
                                                    next_state = FETCH_START;
                                                    next_address_enable = 1;
                                                end
                                       end
                                    default: ; 
                                endcase
                            end
                        OPERATION_CODE'('b0100011):  // S block
                            begin
                                if (current_state == DECODE)
                                    begin
                                        read_register_enable = 1;
                                        next_state = EXECUTE;
                                    end
                                else
                                    begin
                                        alu_source = 1;
                                        read_register_enable = 1;
                                        
                                        case(instruction[INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-1:INSTRUCTION_WIDTH-I_IMMEDIATE_WIDTH-REGISTER_SELECTION_WIDTH-FUNCTION_THREE])
                                            FUNCTION_THREE'('b000): // SB
                                                begin
                                                    store_byte = 1;
                                                    write_memory_byte_enable = 1;
                                                end
                                            FUNCTION_THREE'('b001): // SH
                                                begin
                                                    store_byte = 1;
                                                    write_memory_byte_enable = 1;
                                                end
                                            FUNCTION_THREE'('b010): //SW
                                                begin
                                                    store_byte = 1;
                                                    write_memory_byte_enable = 1;
                                                end
                                             default: ;
                                        endcase
                                        
                                        if (memory_write_finished)
                                            begin
                                                next_address_enable = 1;
                                                next_state = FETCH_START;
                                            end
                                        else
                                            begin
                                                next_state = EXECUTE;
                                            end
                                    end
                            end
                        OPERATION_CODE'('b1100011): ; // SB block
                        OPERATION_CODE'('b0010111): ; // U block
                        OPERATION_CODE'('b0110111): ; // U block
                        OPERATION_CODE'('b1101111): ; // UJ block
                        default: ;
                    endcase
                end
        end


endmodule

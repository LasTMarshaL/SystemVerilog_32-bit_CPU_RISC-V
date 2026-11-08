`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Data_Memory
(
    input logic clk,
    input logic reset,
    
    input logic read_memory_enable,
    input logic store_byte,
    input logic store_half_word,
    input logic store_word,
    
    input logic [ADDRESS_WIDTH-1:0] memory_address,
    
    input logic [DATA_WIDTH-1:0] write_memory_data, 
    output logic [DATA_WIDTH-1:0] read_memory_data,
    
    output logic memory_read_finished,
    output logic memory_write_finished,
    
    output logic [DATA_WIDTH-1:0] memory_exception
);
    
    
    typedef enum logic
    {
        IDLE,
        EXECUTE
    } memory_state_typedef;
    
    memory_state_typedef memory_state;
    
    logic [ADDRESS_WIDTH-1:0] register_memory_address;
    logic [DATA_WIDTH-1:0] memory [0:MEMORY_SIZE-1];
    
    logic [BYTES_NUMBER-1:0] mask;

    
    initial
        begin
            for (int i = 0; i < MEMORY_SIZE; i++)
                begin
                    memory[i] = '0;
                end
        end
    
    always_comb
        begin
            mask = '0;
                if (store_byte)
                    begin
                        case (memory_address[BYTES_NUMBER-1:0])
                            BYTES_HALF_NUMBER'('b00): mask = BYTES_NUMBER'('b0001);
                            BYTES_HALF_NUMBER'('b01): mask = BYTES_NUMBER'('b0010);
                            BYTES_HALF_NUMBER'('b10): mask = BYTES_NUMBER'('b0100);
                            BYTES_HALF_NUMBER'('b11): mask = BYTES_NUMBER'('b1000);
                       endcase
                   end
                else if (store_half_word)
                    begin
                        mask = (memory_address[BYTES_QUATER_NUMBER] == 0) ? BYTES_NUMBER'('b0011) : BYTES_NUMBER'('b1100);
                    end 
                else if (store_word)
                    begin
                        mask = BYTES_NUMBER'('b1111);
                    end
        end
        
        
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    memory_state <= IDLE;
                    read_memory_data <= '0;
                    register_memory_address <= '0;
                    memory_read_finished  <= 0;
                    memory_write_finished <= 0;
                    memory_exception <= '1;
                end
            else
                begin
                    memory_read_finished <= 0;
                    memory_write_finished <= 0;
                    
                    if (memory_exception == '1)
                        begin
                            case (memory_state)
                                IDLE:
                                    begin
                                        if (read_memory_enable)
                                            begin
                                                if ($unsigned(memory_address) < $unsigned(MEMORY_SIZE) * 4)
                                                    begin
                                                        register_memory_address <= memory_address >> 2;
                                                        memory_state <= EXECUTE;
                                                    end
                                                else
                                                    begin
                                                        memory_exception <= DATA_WIDTH'(5);
                                                    end
                                            end
                                        else if (store_byte || store_half_word || store_word)
                                            begin
                                                if (store_byte || (store_half_word && (memory_address[0] == '0)) || (store_word && (memory_address[BYTES_QUATER_NUMBER:0] == '0)))
                                                    begin
                                                        if ($unsigned(memory_address) < $unsigned(MEMORY_SIZE) * 4)
                                                            begin
                                                                for (int i = 0; i < BYTES_NUMBER; i += 1)
                                                                    begin
                                                                        if (mask[i])
                                                                            begin
                                                                                memory[memory_address >> 2][(i*BYTE_SIZE) +: BYTE_SIZE] <= (write_memory_data >> (memory_address[BYTES_QUATER_NUMBER:0] * BYTE_SIZE)); // >> will be moved to Immediate Generator
                                                                            end
                                                                    end
                                                                memory_write_finished <= 1;
                                                                memory_state <= IDLE;
                                                            end
                                                        else
                                                            begin
                                                                memory_exception <= DATA_WIDTH'(7);
                                                            end
                                                    end
                                                else
                                                    begin
                                                        memory_exception <= DATA_WIDTH'(6);
                                                    end
                                            end
                                    end
                                EXECUTE:
                                    begin
                                        read_memory_data <= memory[register_memory_address];
                                        memory_read_finished  <= 1;
                                        memory_state <= IDLE;
                                    end
                                default: memory_state <= IDLE;
                            endcase
                        end
                end    
        end


endmodule

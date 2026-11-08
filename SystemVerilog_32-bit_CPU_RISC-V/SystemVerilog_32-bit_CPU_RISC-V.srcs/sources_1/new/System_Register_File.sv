`timescale 1ns / 1ps

import CPU_Parameters_Config::*;


module System_Register_File(
    input logic clk,
    input logic reset,
    
    input logic read_system_register_enable,
    input logic write_system_register_enable,
    
    input logic [I_IMMEDIATE_WIDTH-1:0] read_system_register_select,
    input logic [I_IMMEDIATE_WIDTH-1:0] write_system_register_select,
    
    input logic [DATA_WIDTH-1:0] write_system_register_data,
    output logic [DATA_WIDTH-1:0] read_system_register_data,
    
    output logic [DATA_WIDTH-1:0] system_register_exception
    );
    
    
    typedef enum logic
    {
        IDLE,
        EXECUTE
    } system_register_state_typedef;
    
    system_register_state_typedef system_register_state;
    
    logic [DATA_WIDTH-1:0] mstatus;
    logic [DATA_WIDTH-1:0] mie;
    logic [DATA_WIDTH-1:0] mtvec;
    logic [DATA_WIDTH-1:0] mscratch;
    logic [DATA_WIDTH-1:0] mepc;
    logic [DATA_WIDTH-1:0] mcause;
    logic [DATA_WIDTH-1:0] mtval;
    
    logic [I_IMMEDIATE_WIDTH-1:0] register_read_system_register_select;
    
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    read_system_register_data <= '0;
                    register_read_system_register_select <= 0;
                    system_register_exception <= '1;
                    system_register_state <= IDLE;
                end
            else
                begin
                    if (system_register_exception == '1)
                        begin
                            case(system_register_state)
                                IDLE:
                                    begin
                                         if (read_system_register_enable)
                                            begin
                                                register_read_system_register_select <= read_system_register_select;
                                                system_register_state <= EXECUTE;
                                            end
                                         if (write_system_register_enable)
                                             begin
                                                case (write_system_register_select)
                                                    I_IMMEDIATE_WIDTH'('h300): mstatus <= write_system_register_data;
                                                    I_IMMEDIATE_WIDTH'('h304): mie <= write_system_register_data;
                                                    I_IMMEDIATE_WIDTH'('h305): mtvec <= write_system_register_data;
                                                    I_IMMEDIATE_WIDTH'('h340): mscratch <= write_system_register_data;
                                                    I_IMMEDIATE_WIDTH'('h341): mepc <= write_system_register_data;
                                                    I_IMMEDIATE_WIDTH'('h342): mcause <= write_system_register_data;
                                                    I_IMMEDIATE_WIDTH'('h343): mtval <= write_system_register_data;
                                                    default:
                                                        begin
                                                            system_register_exception <= DATA_WIDTH'(2);
                                                            mcause <= DATA_WIDTH'(2);
                                                        end
                                                    endcase
                                            end
                                    end
                                 EXECUTE:
                                    begin
                                        case (register_read_system_register_select)
                                            I_IMMEDIATE_WIDTH'('h300): read_system_register_data <= mstatus;
                                            I_IMMEDIATE_WIDTH'('h304): read_system_register_data <= mie;
                                            I_IMMEDIATE_WIDTH'('h305): read_system_register_data <= mtvec;
                                            I_IMMEDIATE_WIDTH'('h340): read_system_register_data <= mscratch;
                                            I_IMMEDIATE_WIDTH'('h341): read_system_register_data <= mepc;
                                            I_IMMEDIATE_WIDTH'('h342): read_system_register_data <= mcause;
                                            I_IMMEDIATE_WIDTH'('h343): read_system_register_data <= mtval;
                                            default:
                                                begin
                                                    read_system_register_data <= '0;
                                                    system_register_exception <= DATA_WIDTH'(2);
                                                    mcause <= DATA_WIDTH'(2);
                                                end
                                        endcase
                                        system_register_state <= IDLE;
                                    end
                                default: system_register_state <= IDLE;
                            endcase
                        end
                end    
        end
    
    
endmodule

`timescale 1ns / 1ps

import CPU_Parameters_Config::*;


module System_Register_File(
    input logic clk,
    
    input logic read_system_register_enable,
    input logic write_system_register_enable,
    
    input logic [I_IMMEDIATE_WIDTH-1:0] read_system_register_select,
    input logic [I_IMMEDIATE_WIDTH-1:0] write_system_register_select,
    
    input logic [DATA_WIDTH-1:0] write_system_register_data,
    output logic [DATA_WIDTH-1:0] read_system_register_data,
    
    output logic system_register_exception
    );
    
    
    logic [DATA_WIDTH-1:0] mstatus;
    logic [DATA_WIDTH-1:0] mie;
    logic [DATA_WIDTH-1:0] mtvec;
    logic [DATA_WIDTH-1:0] mscratch;
    logic [DATA_WIDTH-1:0] mepc;
    logic [DATA_WIDTH-1:0] mcause;
    logic [DATA_WIDTH-1:0] mtval;
    
    
    always_ff @(posedge clk)
        begin
            if (read_system_register_enable)
                begin
                    case (read_system_register_select)
                        I_IMMEDIATE_WIDTH'('h300): read_system_register_data <= mstatus;
                        I_IMMEDIATE_WIDTH'('h304): read_system_register_data <= mie;
                        I_IMMEDIATE_WIDTH'('h305): read_system_register_data <= mtvec;
                        I_IMMEDIATE_WIDTH'('h340): read_system_register_data <= mscratch;
                        I_IMMEDIATE_WIDTH'('h341): read_system_register_data <= mepc;
                        I_IMMEDIATE_WIDTH'('h342): read_system_register_data <= mcause;
                        I_IMMEDIATE_WIDTH'('h343): read_system_register_data <= mtval;
                        default:read_system_register_data <= '0;
                    endcase
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
                        default: ; 
                    endcase
                end
        end
    
    
endmodule

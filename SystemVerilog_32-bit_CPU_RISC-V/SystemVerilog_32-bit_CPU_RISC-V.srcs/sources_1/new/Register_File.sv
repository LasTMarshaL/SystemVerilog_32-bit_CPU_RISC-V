`timescale 1ns / 1ps


import CPU_Parameters_Config::*;


module Register_File #()
(
    input logic clk,
    input logic reset,
    
    input logic write_register_enable,
    input logic read_register_enable,
    input logic [REGISTER_SELECTION_WIDTH-1:0] write_register_select,
    input logic [DATA_WIDTH-1:0] write_register_data,
    
    input logic [REGISTER_SELECTION_WIDTH-1:0] read_register_select_1,
    input logic [REGISTER_SELECTION_WIDTH-1:0] read_register_select_2,
    
    output logic [DATA_WIDTH-1:0] read_register_data_1,
    output logic [DATA_WIDTH-1:0] read_register_data_2
);
    
    typedef enum logic
    {
        IDLE,
        EXECUTE
    } register_state_typedef;
    
    register_state_typedef register_state;
    
    logic [DATA_WIDTH-1:0] register [0:31];
    logic [REGISTER_SELECTION_WIDTH-1:0] register_read_register_select_1;
    logic [REGISTER_SELECTION_WIDTH-1:0] register_read_register_select_2;
    
    always_ff @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    register_read_register_select_1 <= '0;
                    register_read_register_select_2 <= '0;
                    register_state <= IDLE;
                end
            else
                begin
                    case (register_state)
                        IDLE:
                            begin
                                if (read_register_enable)
                                    begin
                                        register_read_register_select_1 <= read_register_select_1;
                                        register_read_register_select_2 <= read_register_select_2;
                                        register_state <= EXECUTE;
                                    end
                                if (write_register_enable && write_register_select != '0)
                                    begin
                                        register[write_register_select] <= write_register_data;
                                    end
                            end
                        EXECUTE:
                            begin
                                read_register_data_1 <= (register_read_register_select_1 == '0 ? '0 : register[register_read_register_select_1]);
                                read_register_data_2 <= (register_read_register_select_2 == '0 ? '0 : register[register_read_register_select_2]);
                                register_state <= IDLE;
                            end
                        default: register_state <= IDLE;
                    endcase
                end
        end
    

endmodule
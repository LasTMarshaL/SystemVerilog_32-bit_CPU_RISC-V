`timescale 1ns / 1ps


module Register_File #(parameter DATA_WIDTH = 32, REGISTER_SELECTION_WIDTH = 5)
(
    input logic clk,
    
    input logic write_register_enable,
    input logic [REGISTER_SELECTION_WIDTH-1:0] write_register_select,
    input logic signed [DATA_WIDTH-1:0] write_register_data,
    
    input logic [REGISTER_SELECTION_WIDTH-1:0] read_register_select_1,
    input logic [REGISTER_SELECTION_WIDTH-1:0] read_register_select_2,
    
    output logic signed [DATA_WIDTH-1:0] read_register_data_1,
    output logic signed [DATA_WIDTH-1:0] read_register_data_2
);
    
    
    logic signed [DATA_WIDTH-1:0] register [0:31];
    
    assign read_register_data_1 = (read_register_select_1 == 5'd0 ? 0 : register[read_register_select_1]);
    assign read_register_data_2 = (read_register_select_2 == 5'd0 ? 0 : register[read_register_select_2]);

    always_ff @(posedge clk)
        begin
            if (write_register_enable && write_register_select != 5'd0)
                begin
                    register[write_register_select] <= write_register_data;
                end
        end
    

endmodule
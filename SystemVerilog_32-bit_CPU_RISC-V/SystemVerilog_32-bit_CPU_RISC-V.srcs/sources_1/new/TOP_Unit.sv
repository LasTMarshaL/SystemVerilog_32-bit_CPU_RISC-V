`timescale 1ns / 1ps

/*
module TOP_Unit #(parameter INSTRUCTION_WIDTH = 16, OPERATION_WIDTH = 4, DATA_WIDTH = 8, ADDRESS_WIDTH = 8, REGISTER_SELECTION_WIDTH = 1)
(
    input logic clk,
    input logic reset
);


    logic signed [DATA_WIDTH-1:0] alu_result;
    
    
    logic [INSTRUCTION_WIDTH-1:0] instruction;
    logic [ADDRESS_WIDTH-1:0] instruction_address;
    
    logic register_write_enable;  
    logic flag_register_write_enable;  
    logic jump_enable;
    logic next_address_enable;
    
    logic data_memory_read_enable;   
    logic data_memory_write_enable;      
    logic [1:0] register_write_source;
    
    logic [DATA_WIDTH-1:0] write_register_data_mux;
    
    logic signed [DATA_WIDTH-1:0] register_0_data;
    logic signed [DATA_WIDTH-1:0] register_1_data;
    
    
    flags_t alu_register_flags;
    flags_t current_register_flags;
    
    logic signed [DATA_WIDTH-1:0] data_memory_output;
    logic signed [DATA_WIDTH-1:0] data_memory_write_source_mux;
    
    assign data_memory_write_source_mux = (instruction[INSTRUCTION_WIDTH-OPERATION_WIDTH-1:INSTRUCTION_WIDTH-OPERATION_WIDTH-REGISTER_SELECTION_WIDTH] == 1'b0) ? register_0_data : register_1_data;
    
    
    assign write_register_data_mux = (register_write_source == 2'b00) ? alu_result:    
                        (register_write_source == 2'b01) ? data_memory_output:     
                                                            instruction[INSTRUCTION_WIDTH-OPERATION_WIDTH-REGISTER_SELECTION_WIDTH-1:INSTRUCTION_WIDTH-OPERATION_WIDTH-REGISTER_SELECTION_WIDTH-ADDRESS_WIDTH];
    
    
    ALU alu_instance ( 
        .command(instruction[INSTRUCTION_WIDTH-1:INSTRUCTION_WIDTH-OPERATION_WIDTH]),
        .carry_in(current_register_flags.carry_out),
        .flags(alu_register_flags),
        .data_in_operand_a(register_0_data),
        .data_in_operand_b(register_1_data),
        .data_out(alu_result)
    );
    
    Register_File register_file_instance ( 
        .clk(clk),
        .reset(reset),
        .write_register_enable(register_write_enable),
        .write_register_select(instruction[INSTRUCTION_WIDTH-OPERATION_WIDTH-REGISTER_SELECTION_WIDTH]),
        .write_register_data(write_register_data_mux),
        .read_register_0(register_0_data),
        .read_register_1(register_1_data)
    );
    
    Flag_Register flag_register_instance ( 
        .clk(clk),
        .reset(reset),
        .write_enable(flag_register_write_enable),
        .flags_in(alu_register_flags),
        .flags_out(current_register_flags)
    );
    
    Data_Memory data_memory_instance (
        .clk(clk),
        .write_enable(data_memory_write_enable),
        .read_enable(data_memory_read_enable),
        .address(instruction[INSTRUCTION_WIDTH-OPERATION_WIDTH-REGISTER_SELECTION_WIDTH-1:INSTRUCTION_WIDTH-OPERATION_WIDTH-REGISTER_SELECTION_WIDTH-ADDRESS_WIDTH]),
        .write_data(data_memory_write_source_mux),
        .read_data(data_memory_output)
    );
    
    Control_Unit control_unit_instance( 
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .zero_flag(current_register_flags.zero),
        .register_write_enable(register_write_enable),
        .flag_register_write_enable(flag_register_write_enable),
        .jump_enable(jump_enable),
        .next_address_enable(next_address_enable),
        .data_memory_read_enable(data_memory_read_enable),
        .data_memory_write_enable(data_memory_write_enable),
        .register_write_source(register_write_source)
    );
    
    Instruction_Memory instruction_memory_instance (
        .address(instruction_address),
        .instruction(instruction)
    );
    
    Program_Counter program_counter_instance (
        .clk(clk),
        .reset(reset),
        .next_address_enable(next_address_enable),
        .jump_enable(jump_enable),
        .target_address(instruction[INSTRUCTION_WIDTH-OPERATION_WIDTH-REGISTER_SELECTION_WIDTH-1:INSTRUCTION_WIDTH-OPERATION_WIDTH-REGISTER_SELECTION_WIDTH-ADDRESS_WIDTH]),
        .instruction_address(instruction_address)
    );
    
 
 */
//endmodule

package CPU_Parameters_Config;
    localparam ADDRESS_WIDTH = 32;
    localparam DATA_WIDTH = 32;
    localparam BYTE_SIZE = 8;
    localparam BYTES_NUMBER = DATA_WIDTH / BYTE_SIZE ;
    localparam INSTRUCTION_WIDTH = 32;
    localparam MEMORY_SIZE = 16384;
    localparam REGISTER_SELECTION_WIDTH = 5;
    localparam [ADDRESS_WIDTH-1:0] RESET_ADDRESS = '0;
endpackage

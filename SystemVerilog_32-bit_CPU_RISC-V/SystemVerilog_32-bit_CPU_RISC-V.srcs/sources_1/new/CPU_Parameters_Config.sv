package CPU_Parameters_Config;
    localparam OPERATION_CODE = 7;
    localparam FUNCTION_THREE = 3;
    localparam FUNCTION_SEVEN = 7;
    
    localparam ADDRESS_WIDTH = 32;
    localparam [ADDRESS_WIDTH-1:0] RESET_ADDRESS = '0;
    
    localparam DATA_WIDTH = 32;
    localparam INSTRUCTION_WIDTH = 32;
    
    localparam BYTE_SIZE = 8;
    localparam BYTES_NUMBER = DATA_WIDTH / BYTE_SIZE ;
    
    localparam MEMORY_SIZE = 16384;
    localparam REGISTER_SELECTION_WIDTH = 5;
    
    localparam OPERATION_DURATION = 200;
    localparam PROPAGATION_DELAY = 5;
    
    localparam I_IMMEDIATE_WIDTH = 12;

    localparam S_HIGH_IMMEDIATE_WIDTH = 7;
    localparam S_LOW_IMMEDIATE_WIDTH  = 5;

    localparam B_SIGN_IMMEDIATE_WIDTH = 1;
    localparam B_BIT7_IMMEDIATE_WIDTH = 1;
    localparam B_HIGH_IMMEDIATE_WIDTH = 6;
    localparam B_LOW_IMMEDIATE_WIDTH  = 4;

    localparam U_IMMEDIATE = 20;

    localparam J_SIGN_IMMEDIATE_WIDTH = 1;
    localparam J_HIGH_IMMEDIATE_WIDTH = 8;
    localparam J_BIT20_IMMEDIATE_WIDTH = 1;
    localparam J_LOW_IMMEDIATE_WIDTH  = 10;
endpackage

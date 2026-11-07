package CPU_Parameters_Config;
    localparam OPERATION_CODE = 7;
    localparam FUNCTION_THREE = 3;
    localparam FUNCTION_SEVEN = 7;
    
    localparam ADDRESS_WIDTH = 32;
    localparam [ADDRESS_WIDTH-1:0] RESET_ADDRESS = '0;
    localparam FORCE_SYSTEM_TRAP_WIDTH = 2;
    
    localparam DATA_WIDTH = 32;
    localparam INSTRUCTION_WIDTH = 32;
    
    localparam BYTE_SIZE = 8;
    localparam BYTES_NUMBER = 4;
    localparam BYTES_HALF_NUMBER = 2;
    localparam BYTES_QUATER_NUMBER = 1;
    
    localparam MEMORY_SIZE = 16384;
    localparam REGISTER_SELECTION_WIDTH = 5;
    
    localparam OPERATION_DURATION = 200;
    localparam PROPAGATION_DELAY = 5;
    
    localparam FENCE_FLAG_WIDTH = 1;
    localparam PI_POSITION = 27;
    localparam PO_POSITION = 26;
    localparam PR_POSITION = 25;
    localparam PW_POSITION = 24;
    localparam SI_POSITION = 23;
    localparam SO_POSITION = 22;
    localparam SR_POSITION = 21;
    localparam SW_POSITION = 20;
    
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

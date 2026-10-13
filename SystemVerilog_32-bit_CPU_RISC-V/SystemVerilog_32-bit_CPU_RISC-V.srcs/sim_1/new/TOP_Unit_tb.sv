`timescale 1ns / 1ps


module TOP_Unit_tb();


    logic clk;
    logic reset;


    TOP_Unit uut (
        .clk(clk),
        .reset(reset)
    );
    
    
    always
        begin
            #5 clk = ~clk;
        end
        
        
    initial
        begin
            clk = 0;
            reset = 1;
            
            #50;
            reset = 0;
            
            
        end

endmodule

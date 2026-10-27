`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for top_crypto module
//////////////////////////////////////////////////////////////////////////////////

module tb_crypto();
    reg clk;
    reg [1:0] sw;
    reg [1:0] btn;
    wire [3:0] led;

    // Instantiate Unit Under Test (UUT)
    top_crypto uut (
        .clk(clk),
        .sw(sw),
        .btn(btn),
        .led(led)
    );

    // Clock generation: 125 MHz clock period = 8ns (4ns HIGH, 4ns LOW)
    initial clk = 0;
    always #4 clk = ~clk;

    initial begin
        // Initialize Inputs
        sw  = 2'b00;
        btn = 2'b01; // Hold Reset (BTN0) high
        #20;
        
        btn = 2'b00; // Release Reset
        #20;
        
        // Test Case 1: Plaintext = 2'b10
        sw = 2'b10;
        #40;
        
        // Pulse BTN1 to step LFSR and update key stream
        btn = 2'b10;
        #8;
        btn = 2'b00;
        #100;

        // Test Case 2: Change Plaintext = 2'b01
        sw = 2'b01;
        #40;
        
        // Pulse BTN1 again
        btn = 2'b10;
        #8;
        btn = 2'b00;
        #100;
        
        $stop; // Finish simulation
    end
endmodule

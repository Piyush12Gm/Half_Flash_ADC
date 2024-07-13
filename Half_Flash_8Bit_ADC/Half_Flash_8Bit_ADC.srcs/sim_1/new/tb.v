`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 12:30:45
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg [7:0] analog_in;
    wire [7:0] digital_out;

    // Instantiate the half_flash_adc module
    half_flash_adc uut (
        .clk(clk),
        .reset(reset),
        .analog_in(analog_in),
        .digital_out(digital_out)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns period, 100 MHz clock

    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        analog_in = 0;

        // Apply reset
        reset = 1;
        #10;
        reset = 0;

        // Apply test vectors
        #10 analog_in = 8'b00000000; // Minimum value
        #10 analog_in = 8'b00001111; // Low value
        #10 analog_in = 8'b00111100; // Mid-low value
        #10 analog_in = 8'b01111111; // Mid value
        #10 analog_in = 8'b10101010; // Mid-high value
        #10 analog_in = 8'b11110000; // High value
        #10 analog_in = 8'b11111111; // Maximum value

        // Finish simulation
        #10 $finish;
    end

    // Monitor the output
    initial begin
        $monitor("Time: %0dns, analog_in: %b, digital_out: %b", $time, analog_in, digital_out);
    end
endmodule


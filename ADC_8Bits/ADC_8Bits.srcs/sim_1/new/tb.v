`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2024 23:15:45
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


module tb( );
// Testbench signals
reg clk;
reg reset;
reg [7:0] analog_in;
wire [7:0] digital_out;

// Instantiate the ADC module
ADC uut (
    .clk(clk),
    .reset(reset),
    .analog_in(analog_in),
    .digital_out(digital_out)
);

// Clock generation
always #5 clk = ~clk; // 100MHz clock

initial begin
    // Initialize signals
    clk = 0;
    reset = 0;
    analog_in = 8'b0;

    // Apply reset
    reset = 1;
    #10;
    reset = 0;

    // Apply test vectors
    #10 analog_in = 8'b00001111; // Example analog value
    #10 analog_in = 8'b11110000; // Example analog value
    #10 analog_in = 8'b10101010; // Example analog value
    #10 analog_in = 8'b01010101; // Example analog value

    // Finish simulation
    #10 $finish;
end

// Monitor signals
initial begin
    $monitor("At time %t, analog_in = %h, digital_out = %h", $time, analog_in, digital_out);
end

endmodule

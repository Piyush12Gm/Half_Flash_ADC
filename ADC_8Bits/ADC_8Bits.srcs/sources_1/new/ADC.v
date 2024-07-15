`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2024 23:06:09
// Design Name: 
// Module Name: ADC
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


module ADC(
    input wire clk,           // Clock input
    input wire reset,         // Reset input
    input wire [7:0] analog_in, // 8-bit analog input (for simplicity, this is already digital)
    output reg [7:0] digital_out // 8-bit digital output
);

// ADC process
always @(posedge clk or posedge reset) begin
    if (reset) begin
        digital_out <= 8'b0; // Reset output to 0
    end else begin
        digital_out <= analog_in; // Assign the analog input to digital output
    end
end

endmodule

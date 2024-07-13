`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 11:19:45
// Design Name: 
// Module Name: half_flash_adc
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


module half_flash_adc (
    input clk,
    input reset,
    input [7:0] analog_in,
    output reg [7:0] digital_out
);

    // Intermediate signals
    reg [3:0] msb; // Most significant 4 bits
    reg [3:0] lsb; // Least significant 4 bits

    // Comparator outputs
    wire [15:0] msb_compare;
    wire [15:0] lsb_compare;

    // Flash comparators for MSB
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : msb_comparators
            assign msb_compare[i] = (analog_in >= (i << 4)) ? 1'b1 : 1'b0;
        end
    endgenerate

    // Flash comparators for LSB
    generate
        for (i = 0; i < 16; i = i + 1) begin : lsb_comparators
            assign lsb_compare[i] = (analog_in >= ((msb << 4) | i)) ? 1'b1 : 1'b0;
        end
    endgenerate

    integer j;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            msb <= 4'b0000;
            lsb <= 4'b0000;
            digital_out <= 8'b00000000;
        end else begin
            // Find MSB
            msb <= 4'b0000;
            for (j = 15; j >= 0; j = j - 1) begin
                if (msb_compare[j]) begin
                    msb <= j[3:0];
                end
            end

            // Find LSB
            lsb <= 4'b0000;
            for (j = 15; j >= 0; j = j - 1) begin
                if (lsb_compare[j]) begin
                    lsb <= j[3:0];
                end
            end

            // Combine MSB and LSB to form the final digital output
            digital_out <= {msb, lsb};
        end
    end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2025 08:17:09 PM
// Design Name: 
// Module Name: second_weight_padder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Pad 256-bit intermediate hash (SHA256(header)) 
//              to form 512-bit block for the second SHA256.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module second_weight_padder(
    input clk, reset,
    input [255:0] data,
    output reg [511:0] padded_data
);

always @(posedge clk) begin
    if (reset) begin
        padded_data <= 512'b0;
    end else begin
        padded_data <= {
            data,                              // 256 bits (32 bytes)
            8'h80,                             // 1 bit '1' + 7 bit '0'
            23'd0,                             // 23 bytes zero (184 bits)
            64'd256               
        };
    end
end

endmodule

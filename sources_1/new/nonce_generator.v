`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2025 06:30:13 PM
// Design Name: 
// Module Name: nonce_generator
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


module nonce_generator(
    input clk,
    input reset,
    output [31:0] nonce
);

reg [31:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= 32'b0;
    end else begin
        count <= count + 32'b1;
    end
end

assign nonce = count;

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2025 07:01:33 PM
// Design Name: 
// Module Name: weight_padder
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


module weight_padder(
    input clk, reset,
    input [31:0] version,
    input [255:0] prev_block_hash,
    input [255:0] merkle_root,
    input [31:0] timestamp,
    input [31:0] bits,
    input [31:0] nonce,
    output reg [1023:0] padded_data
);

always @(posedge clk) begin
    if (reset) begin
        padded_data <= 1024'b0;
    end else begin
        padded_data <= {version, prev_block_hash, merkle_root, timestamp, bits, nonce, 8'b10000000, 312'b0, 64'd640};
    end
end

endmodule

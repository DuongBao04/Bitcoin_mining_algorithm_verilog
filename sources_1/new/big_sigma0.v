`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2025 10:23:50 AM
// Design Name: 
// Module Name: big_sigma1
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


module big_sigma0(
    input [31:0] in_data,
    output [31:0] out_data
    );
    
    wire [31:0] rotR2 = (in_data >> 2) | (in_data << 30);
    wire [31:0] rotR13 = (in_data >> 13) | (in_data << 19);
    wire [31:0] rotR22 = (in_data >> 22) | (in_data << 10);
    assign out_data = rotR2 ^ rotR13 ^ rotR22;
endmodule

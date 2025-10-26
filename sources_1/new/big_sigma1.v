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


module big_sigma1(
    input [31:0] in_data,
    output [31:0] out_data
    );
    
    wire [31:0] rotR6 = (in_data >> 6) | (in_data << 26);
    wire [31:0] rotR11 = (in_data >> 11) | (in_data << 21);
    wire [31:0] rotR25 = (in_data >> 25) | (in_data << 7);
    assign out_data = rotR6 ^ rotR11 ^ rotR25;
endmodule

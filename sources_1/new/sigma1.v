`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2025 11:40:49 PM
// Design Name: 
// Module Name: sigma0
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


module sigma1(
    input [31:0] in_data,
    output [31:0] out_data
    );
    
    wire [31:0] rot17 = (in_data >> 17) | (in_data << 15);
    wire [31:0] rot19 = (in_data >> 19) | (in_data << 13);
    wire [31:0] shR10 = (in_data >> 10);
    assign out_data = rot17 ^ rot19 ^ shR10;
    
endmodule

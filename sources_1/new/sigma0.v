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


module sigma0(
    input [31:0] in_data,
    output [31:0] out_data
    );
    
    wire [31:0] rot7 = (in_data >> 7) | (in_data << 25);
    wire [31:0] rot18 = (in_data >> 18) | (in_data << 14);
    wire [31:0] shR3 = (in_data >> 3);
    assign out_data = rot7 ^ rot18 ^ shR3;
    
endmodule

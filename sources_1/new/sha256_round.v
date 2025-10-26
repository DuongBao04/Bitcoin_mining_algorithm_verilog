`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2025 10:40:31 AM
// Design Name: 
// Module Name: sha256_round
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


module sha256_round(
    input clk, reset,
    input [31:0] a_old,
    input [31:0] b_old,
    input [31:0] c_old,
    input [31:0] d_old,
    input [31:0] e_old,
    input [31:0] f_old,
    input [31:0] g_old,
    input [31:0] h_old,
    input [31:0] k_value,
    input [31:0] word_block,
    
    output reg [31:0] a,
    output reg [31:0] b,
    output reg [31:0] c,
    output reg [31:0] d,
    output reg [31:0] e,
    output reg [31:0] f,
    output reg [31:0] g,
    output reg [31:0] h
    );
    
    wire [31:0] t1, t2;
    wire [31:0] p, q; // To store the value of big sigma a and e
    
    wire [31:0] ch  = (e_old & f_old) ^ (~e_old & g_old);
    wire [31:0] maj = (a_old & b_old) ^ (a_old & c_old) ^ (b_old & c_old);
    
    big_sigma0 calc0 (
        .in_data(a_old),
        .out_data(p)
    );
    
    big_sigma1 calc1 (
        .in_data(e_old),
        .out_data(q)
    );
    
    assign t1  = h_old + q + ch + k_value + word_block;
    assign t2  = p + maj;
    
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            h <= 32'b0;
            g <= 32'b0;
            f <= 32'b0;
            d <= 32'b0;
            c <= 32'b0;
            b <= 32'b0;
            h <= 32'b0;
            h <= 32'b0;
        end else begin
            h <= g_old;
            g <= f_old;
            f <= e_old;
            e <= d_old + t1;
            d <= c_old;
            c <= b_old;
            b <= a_old;
            a <= t1+ t2;
        end    
    end
    
endmodule

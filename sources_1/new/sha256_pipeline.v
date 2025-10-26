`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2025 10:13:24 AM
// Design Name: 
// Module Name: sha256_pipeline
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

`include "defines.vh"
module sha256_pipeline(
    input   clk, reset,
    input   [2047:0] w,
    input   [31:0] h1, h2, h3, h4, h5, h6, h7, h8, 
    
    output reg [255:0] H
    );
    
    // Pipeline
    wire [31:0] a_old [64:0];
    wire [31:0] b_old [64:0];
    wire [31:0] c_old [64:0];
    wire [31:0] d_old [64:0];
    wire [31:0] e_old [64:0];
    wire [31:0] f_old [64:0];
    wire [31:0] g_old [64:0];
    wire [31:0] h_old [64:0];
    wire [31:0] k_value [63:0];
    
    // Initial
    assign a_old [0] = h1;
    assign b_old [0] = h2;
    assign c_old [0] = h3;
    assign d_old [0] = h4;
    assign e_old [0] = h5;
    assign f_old [0] = h6;
    assign g_old [0] = h7;
    assign h_old [0] = h8;
    
    reg [6:0] round_counter;
    always @(posedge clk or posedge reset) begin
        if (reset)
            round_counter <= 0;
        else if (round_counter <= 64)
            round_counter <= round_counter + 1;
    end
    
    
    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin : chain
            sha256_k_rom rom_instance (
                .index(i),
                .k_val(k_value[i])
            );
        
            sha256_round round_instance (
                .clk(clk),
                .reset(reset),
                .a_old(a_old[i]),
                .b_old(b_old[i]),
                .c_old(c_old[i]),
                .d_old(d_old[i]),
                .e_old(e_old[i]),
                .f_old(f_old[i]),
                .g_old(g_old[i]),
                .h_old(h_old[i]),
                .k_value(k_value[i]),
                .word_block(w[(i*32) +: 32]),
                
                .a(a_old[i+1]),
                .b(b_old[i+1]),
                .c(c_old[i+1]),
                .d(d_old[i+1]),
                .e(e_old[i+1]),
                .f(f_old[i+1]),
                .g(g_old[i+1]),
                .h(h_old[i+1])
            );
        
        end 
    endgenerate
    wire [31:0] H1 = a_old[64] + a_old[0];
    wire [31:0] H2 = b_old[64] + b_old[0];
    wire [31:0] H3 = c_old[64] + c_old[0];
    wire [31:0] H4 = d_old[64] + d_old[0];
    wire [31:0] H5 = e_old[64] + e_old[0];
    wire [31:0] H6 = f_old[64] + f_old[0];
    wire [31:0] H7 = g_old[64] + g_old[0];
    wire [31:0] H8 = h_old[64] + h_old[0];
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            H <= 256'b0;
        end
        else if (round_counter > 64) begin
            H <= {H1, H2, H3, H4, H5, H6, H7, H8};
        end else begin
            H <= 256'b0;
        end
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2025 12:00:26 AM
// Design Name: 
// Module Name: tb_sha256_pipeline
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

module tb_sha256_pipeline();
    reg clk;
    reg reset;
    
    reg [511:0] block;
    wire [2047:0] w;
    wire [255:0] final_hash;
    
    // --------------------------------------------------------------
    function [511:0] sha256_pad;
        input [511:0] msg;       // dữ liệu gốc (LSB chứa dữ liệu)
        input integer msg_bytes; // số byte thực tế
        integer i;
        reg [511:0] temp;
        reg [63:0] bit_len;
    begin
        bit_len = msg_bytes * 8;
        temp = 512'h0;
    
        for (i = 0; i < msg_bytes; i = i + 1)
            temp[511 - i*8 -: 8] = msg[(msg_bytes - 1 - i)*8 +: 8];
    
        temp[511 - msg_bytes*8 -: 8] = 8'h80;
        temp[63:0] = bit_len;
        sha256_pad = temp;
    end
    endfunction

    // --------------------------------------------------------------
    
    always #5 clk = ~clk;
    
    message_scheduler uut1(
        .clk(clk),
        .reset(reset),
        .block(block),
        .w(w)
    );
    
    sha256_pipeline uut2 (  
        .clk(clk),
        .reset(reset),
        .w(w),             
        .h1(`H1_INIT),
        .h2(`H2_INIT),
        .h3(`H3_INIT),
        .h4(`H4_INIT),
        .h5(`H5_INIT),
        .h6(`H6_INIT),
        .h7(`H7_INIT),
        .h8(`H8_INIT),
        .H(final_hash)            // output intermediate hash sau block 1
    );
    
    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        
        block = sha256_pad(512'h616263, 3);
        
        #1000;
        
        $stop;
    end
    
endmodule

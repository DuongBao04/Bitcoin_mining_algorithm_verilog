`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2025 01:56:47 PM
// Design Name: 
// Module Name: bitcoin_mining_asic
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
module bitcoin_mining_asic(
    input clk, reset,
    input [31:0] version,
    input [255:0] prev_block_hash,
    input [255:0] merkle_root,
    input [31:0] timestamp,
    input [31:0] bits,
    input [255:0] target,
    
    output valid
    );
    
    wire [31:0] nonce;
    wire [1023:0] padded_data_1;
    wire [511:0] padded_data_2;
    wire [511:0] block_header1 = padded_data_1[1023:512];   
    wire [511:0] block_header2 = padded_data_1[511:0];   
    wire [2047:0] w1, w2, w3;
    wire [511:0] final_hash;
    
    nonce_generator nonce_gen (
        .clk(clk),
        .reset(reset),
        .nonce(nonce)
    );
    
    weight_padder u_pad1(
        .clk(clk),
        .reset(reset),
        .version(version),
        .prev_block_hash(prev_block_hash),
        .merkle_root(merkle_root),
        .timestamp(timestamp),
        .bits(bits),
        .nonce(nonce),
        .padded_data(padded_data_1)
    );
    
    message_scheduler u_sched1(
        .clk(clk),
        .reset(reset),
        .block(block_header1),
        .w(w1)
    );
    
    message_scheduler u_sched2(
        .clk(clk),
        .reset(reset),
        .block(block_header2),
        .w(w2)
    );
    
    wire [255:0] temp1, temp2;
    // --- Block 1 ---
    sha256_pipeline u_sha1 (
        .clk(clk),
        .reset(reset),
        .w(w1),             
        .h1(`H1_INIT),
        .h2(`H2_INIT),
        .h3(`H3_INIT),
        .h4(`H4_INIT),
        .h5(`H5_INIT),
        .h6(`H6_INIT),
        .h7(`H7_INIT),
        .h8(`H8_INIT),
        .H(temp1)            // output intermediate hash sau block 1
    );
    
    // --- Block 2 ---
    sha256_pipeline u_sha2 (
        .clk(clk),
        .reset(reset),
        .w(w2),             
        // input hash từ output của block trước
        .h1(temp1[255:224]),
        .h2(temp1[223:192]),
        .h3(temp1[191:160]),
        .h4(temp1[159:128]),
        .h5(temp1[127:96]),
        .h6(temp1[95:64]),
        .h7(temp1[63:32]),
        .h8(temp1[31:0]),
        .H(temp2)       // output cuối cùng của SHA256(message)
    );
    
    second_weight_padder u_pad2 (
        .clk(clk),
        .reset(reset),
        .data(temp2),
        .padded_data(padded_data_2)
    );
    
    message_scheduler u_sched3 (
        .clk(clk),
        .reset(reset),
        .block(padded_data_2),
        .w(w3)
    );
    
    sha256_pipeline u_sha3 (
        .clk(clk),
        .reset(reset),
        .w(w3),             
        .h1(`H1_INIT),
        .h2(`H2_INIT),
        .h3(`H3_INIT),
        .h4(`H4_INIT),
        .h5(`H5_INIT),
        .h6(`H6_INIT),
        .h7(`H7_INIT),
        .h8(`H8_INIT),
        .H(final_hash)       
    );
    
    sha256_target_checker taget_check (
        .clk(clk),
        .reset(reset),
        .hash_value(final_hash),
        .target(target),
        
        .valid(valid)
    );

    
endmodule

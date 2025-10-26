`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2025 12:13:00 AM
// Design Name: 
// Module Name: tb_bitcoin_mining
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


module tb_bitcoin_mining();
    // Clock & reset
    reg clk;
    reg reset;

    // Inputs
    reg [31:0] version;
    reg [255:0] prev_block_hash;
    reg [255:0] merkle_root;
    reg [31:0] timestamp;
    reg [31:0] bits;
    reg [255:0] target;

    // Outputs
    wire valid;

    // Clock generation
    always #5 clk = ~clk;  // 100 MHz clock

    // DUT instance
    bitcoin_mining_asic dut (
        .clk(clk),
        .reset(reset),
        .version(version),
        .prev_block_hash(prev_block_hash),
        .merkle_root(merkle_root),
        .timestamp(timestamp),
        .bits(bits),
        .target(target),
        .valid(valid)
    );

    initial begin
        clk = 0;
        reset = 1;

        #20;
        reset = 0;

        // Example test vector (Block #0 from Bitcoin genesis block)
        version          = 32'h01000000;
        prev_block_hash  = 256'h0000000000000000000000000000000000000000000000000000000000000000;
        merkle_root      = 256'h3ba3edfd7a7b12b27ac72c3e67768f61_7fc81bc3888a51323a9fb8aa4b1e5e4a;
        timestamp        = 32'h495FAB29;   // 2009-01-03
        bits             = 32'h1d00ffff;   // Difficulty target
        target           = 256'h00000000FFFF0000000000000000000000000000000000000000000000000000;

        // Wait some cycles
        #100000;

    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2025 04:18:36 PM
// Design Name: 
// Module Name: sha256_target_checker
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


module sha256_target_checker(
    input clk, enable, reset,
    input [255:0] hash_value,
    input [255:0] target,
    
    output reg valid
    );
    
    always@(posedge clk) begin
        if (reset) begin
            valid <= 0;
        end else if (enable) begin
            if (hash_value <= target) begin
                valid <= 1'b1;
            end else begin
                valid <= 1'b0;
            end
        end 
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2025 08:54:04 PM
// Design Name: 
// Module Name: message_scheduler
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

module message_scheduler(
    input clk, reset,
    input [511:0] block,
    
    output reg [2047:0] w
    );
    
    wire [31:0] a_temp [63:0];
    wire [31:0] b_temp [63:0];
    
    wire [31:0] wd [63:0];
    
    genvar i;
    generate
        for (i = 0; i < 48; i = i + 1) begin: sigma
            sigma0 sm0_instance(
                .in_data(wd[i+1]),
                .out_data(a_temp[i+1])
            );
            
            sigma1 sm1_instance(
                .in_data(wd[i+14]),
                .out_data(b_temp[i+14])
            );
           
        end
    endgenerate
    
    assign wd[0]  = block[511:480];
    assign wd[1]  = block[479:448];
    assign wd[2]  = block[447:416];
    assign wd[3]  = block[415:384];
    assign wd[4]  = block[383:352];
    assign wd[5]  = block[351:320];
    assign wd[6]  = block[319:288];
    assign wd[7]  = block[287:256];
    assign wd[8]  = block[255:224];
    assign wd[9]  = block[223:192];
    assign wd[10] = block[191:160];
    assign wd[11] = block[159:128];
    assign wd[12] = block[127:96];
    assign wd[13] = block[95:64];
    assign wd[14] = block[63:32];
    assign wd[15] = block[31:0];
    
    genvar j;
    generate
        for (j = 16; j < 64; j = j + 1) begin : gen_w
            assign wd[j] = b_temp[j-2] + wd[j-7] + a_temp[j-15] + wd[j-16];
        end
    endgenerate 
    
    integer k;
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            w <= {2048{1'b0}};
        end
        else begin
            // Concatnate to transfer between modules
            for (k = 0; k < 64; k = k + 1) begin
                w[k*32 +: 32] <= wd[k];
            end
        end
    end
endmodule

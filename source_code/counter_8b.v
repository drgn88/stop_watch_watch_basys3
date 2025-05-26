`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 12:30:00
// Design Name: 
// Module Name: counter_8b
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


module counter_8b(
    input clk,
    input rst,

    output reg [2:0] fnd_sel
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fnd_sel <= 3'b000;
        end else if (fnd_sel == 3'b111) begin
            fnd_sel <= 3'b000;
        end else begin
            fnd_sel <= fnd_sel + 1'b1;
        end
    end
endmodule

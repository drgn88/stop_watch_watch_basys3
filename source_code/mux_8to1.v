`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 15:39:35
// Design Name: 
// Module Name: mux_8to1
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


module mux_8to1 (
    input [2:0] sel,
    input [3:0] digit_1,
    input [3:0] digit_10,
    input [3:0] digit_100,
    input [3:0] digit_1000,
    input [3:0] dot_signal,

    output reg [3:0] bcd
);

    always @(*) begin
        case (sel)
            3'b000:  bcd = digit_1;
            3'b001:  bcd = digit_10;
            3'b010:  bcd = digit_100;
            3'b011:  bcd = digit_1000;
            3'b100:  bcd = 4'hF;
            3'b101:  bcd = 4'hF;
            3'b110:  bcd = dot_signal;
            3'b111:  bcd = 4'hF;
            default: bcd = 4'h0;
        endcase
    end

endmodule

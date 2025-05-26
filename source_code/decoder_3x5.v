`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 15:57:06
// Design Name: 
// Module Name: decoder_3x5
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


module decoder_3x5(
    input [2:0] fnd_sel,

    output reg [3:0] fnd_com
    );

    always @(*) begin
        casez (fnd_sel)
            3'b000:   fnd_com = 4'b1110;
            3'b001:   fnd_com = 4'b1101;
            3'b010:   fnd_com = 4'b1011;
            3'b011:   fnd_com = 4'b0111;
            3'b1zz:   fnd_com = 4'b1011;
            default: fnd_com = 4'b1111;
        endcase
    end
endmodule

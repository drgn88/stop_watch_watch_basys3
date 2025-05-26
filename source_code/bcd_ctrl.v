`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/15 14:58:29
// Design Name: 
// Module Name: bcd_ctrl
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


module bcd_ctrl(
    input [3:0] bcd,

    output reg [7:0] fnd_data
    );

    always @(*) begin
        case (bcd)
            4'd0: fnd_data = 8'hC0;
            4'd1: fnd_data = 8'hF9;
            4'd2: fnd_data = 8'hA4;
            4'd3: fnd_data = 8'hB0;
            4'd4: fnd_data = 8'h99;
            4'd5: fnd_data = 8'h92;
            4'd6: fnd_data = 8'h82;
            4'd7: fnd_data = 8'hF8;
            4'd8: fnd_data = 8'h80;
            4'd9: fnd_data = 8'h90;
            4'hE: fnd_data = 8'h7F;
            4'hF: fnd_data = 8'hFF;
            default: fnd_data = 8'hFF;
        endcase
    end
    
endmodule

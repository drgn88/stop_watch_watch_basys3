`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 16:07:25
// Design Name: 
// Module Name: time_compare
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


module time_compare(
    input [6:0] msec,

    output [3:0] dot
    );

    assign dot = (msec < 7'd50) ? 4'hF : 4'hE;
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 18:35:05
// Design Name: 
// Module Name: mux_24to1
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


module mux_24to1(
    input [23:0] watch_time,
    input [23:0] stop_watch_time,
    input sw1,

    output [23:0] fnd_time
    );

    assign fnd_time = (!sw1) ? watch_time : stop_watch_time;
    
endmodule

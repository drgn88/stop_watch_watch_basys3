`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 18:43:11
// Design Name: 
// Module Name: demux_watch_sw
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


module demux_watch_sw (
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input sw2,
    input sel,

    output [4:0] watch,
    output [1:0] stop_watch
);

    assign stop_watch = (sel) ? {btnL, btnR} : 2'bzz;
    assign watch = (!sel) ? {btnU, btnD, btnL, btnR, sw2} : 5'bzz_zzz;
    // always @(*) begin
    //     if (!sel) begin
    //         watch = {btnU, btnD, btnL, btnR, sw2, sw0};
    //         stop_watch = 2'bZZ;
    //     end else begin
    //         watch = 6'bZZ_ZZZZ;
    //         stop_watch = {btnL, btnR};
    //     end
    // end
endmodule

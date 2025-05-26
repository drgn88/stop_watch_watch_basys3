`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 17:48:36
// Design Name: 
// Module Name: watch
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


module watch (
    input clk,
    input rst,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    input sw2,
    input sw0,

    output [6:0] msec,
    output [5:0] sec,
    output [5:0] min,
    output [4:0] hour
);

    wire w_btnL, w_btnR, w_btnU, w_btnD;
    wire w_sec_1, w_sec_10, w_min_1, w_min_10, w_hour_1, w_hour_10;
    wire w_stop;

    btn_debouncer U_DEB_btnL (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnL),

        .o_btn(w_btnL)
    );

    btn_debouncer U_DEB_btnR (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnR),

        .o_btn(w_btnR)
    );

    btn_debouncer U_DEB_btnU (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnU),

        .o_btn(w_btnU)
    );

    btn_debouncer U_DEB_btnD (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnD),

        .o_btn(w_btnD)
    );

    watch_CU U_WATCH_CU (
        .clk (clk),
        .rst (rst),
        .sw2 (sw2),
        .sw0 (sw0),
        .btnL(w_btnL),
        .btnR(w_btnR),

        .sec_1(w_sec_1),
        .sec_10(w_sec_10),
        .min_1(w_min_1),
        .min_10(w_min_10),
        .hour_1(w_hour_1),
        .hour_10(w_hour_10),
        .stop(w_stop)
    );

    watch_DP U_WATCH_DP (
        .clk(clk),
        .rst(rst),
        .sec_1(w_sec_1),
        .sec_10(w_sec_10),
        .min_1(w_min_1),
        .min_10(w_min_10),
        .hour_1(w_hour_1),
        .hour_10(w_hour_10),
        .stop(w_stop),
        .up(w_btnU),
        .down(w_btnD),

        .msec(msec),
        .sec (sec),
        .min (min),
        .hour(hour)
    );

    
endmodule

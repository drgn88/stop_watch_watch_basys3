`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/16 10:21:08
// Design Name: 
// Module Name: stop_watch
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


module stop_watch (
    input clk,
    input rst,
    input btn_RS,
    input btn_CLR,

    output [6:0] msec,
    output [5:0] sec,
    output [5:0] min,
    output [4:0] hour
);

    wire [6:0] w_otime_msec;
    wire [5:0] w_otime_sec;
    wire [5:0] w_otime_min;
    wire [4:0] w_otime_hour;
    wire w_run_stop, w_clear;
    wire w_btn_RS, w_btn_CLR;


    // step_pulse_gen U_BTN_RS (
    //     .clk(clk),
    //     .rst(rst),
    //     .btn(btn_RS),
    //     .step_pulse(w_btn_RS)
    // );

    // step_pulse_gen U_BTN_CLR (
    //     .clk(clk),
    //     .rst(rst),
    //     .btn(btn_CLR),
    //     .step_pulse(w_btn_CLR)
    // );

    btn_debouncer U_DEB_RS (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btn_RS),

        .o_btn(w_btn_RS)
    );

    btn_debouncer U_DEB_CLR (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btn_CLR),

        .o_btn(w_btn_CLR)
    );

    stop_watch_ctrl U_CU (
        .clk(clk),
        .rst(rst),
        .i_run_stop(w_btn_RS),
        .i_clear(w_btn_CLR),

        .run_stop(w_run_stop),
        .clear(w_clear)
    );

    stop_watch_dp U_STOPWATCH_DP (
        .clk(clk),
        .rst(rst),
        .run_stop(w_run_stop),
        .clear(w_clear),

        .msec(msec),
        .sec (sec),
        .min (min),
        .hour(hour)
    );


endmodule

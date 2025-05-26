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


module stop_watch_dp (
    input clk,
    input rst,
    input run_stop,
    input clear,

    output [6:0] msec,
    output [5:0] sec,
    output [5:0] min,
    output [4:0] hour
);
    //parameter BIT_WIDTH = 7;

    wire w_otick_100;
    wire w_otick_msec;
    wire w_otick_sec;
    wire w_otick_min;
    wire w_otick_hour;

    tick_gen_100hz U_TICK_GEN_100hz (
        .clk(clk & (~run_stop)),
        .rst((rst | clear)),

        .o_tick_100(w_otick_100)
    );

 
    time_cnt #(
        .TCNT(100),
        .BIT_WIDTH(7),
        .RESET_TIME(0)
    ) U_10MSEC_CNT (
        .clk(clk),
        .rst((rst | clear)),
        .i_tick(w_otick_100),
        .o_time(msec),
        .o_tick(w_otick_msec)
    );

    time_cnt #(
        .TCNT(60),
        .BIT_WIDTH(6),
        .RESET_TIME(0)
    ) U_SEC_CNT (
        .clk(clk),
        .rst((rst | clear)),
        .i_tick(w_otick_msec),
        .o_time(sec),
        .o_tick(w_otick_sec)
    );

    time_cnt #(
        .TCNT(60),
        .BIT_WIDTH(6),
        .RESET_TIME(0)
    ) U_MIN_CNT (
        .clk(clk),
        .rst((rst | clear)),
        .i_tick(w_otick_sec),
        .o_time(min),
        .o_tick(w_otick_min)
    );

    time_cnt #(
        .TCNT(24),
        .BIT_WIDTH(5),
        .RESET_TIME(0)
    ) U_HOUR_CNT (
        .clk(clk),
        .rst((rst | clear)),
        .i_tick(w_otick_min),
        .o_time(hour),
        .o_tick(w_otick_hour)
    );

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 17:37:21
// Design Name: 
// Module Name: watch_DP
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


module watch_DP (
    input clk,
    input rst,
    input sec_1,
    input sec_10,
    input min_1,
    input min_10,
    input hour_1,
    input hour_10,
    input stop,
    input up,
    input down,

    output [6:0] msec,
    output [5:0] sec,
    output [5:0] min,
    output [4:0] hour
);

    wire w_tick_100hz;
    wire w_otick_msec;
    wire w_otick_sec;
    wire w_otick_min;
    wire w_otick_hour;

    tick_gen_100hz U_TICK_GEN_100hz (
        .clk(clk),
        .rst(stop | rst),

        .o_tick_100(w_tick_100hz)
    );

    time_cnt_btn #(
        .TCNT(100),
        .BIT_WIDTH(7),
        .RESET_TIME(0),
        .MAX_DIGIT_1(9),
        .MAX_DIGIT_10(5),
        .MIN_DIGIT(0)
    ) U_TCNT_MSEC_W (
        .clk(clk),
        .rst(rst),
        .i_tick(w_tick_100hz),
        .up(),
        .down(),
        .digit_1(),
        .digit_10(),

        .o_time(msec),
        .o_tick(w_otick_msec)
    );

    time_cnt_btn #(
        .TCNT(60),
        .BIT_WIDTH(6),
        .RESET_TIME(0),
        .MAX_DIGIT_1(9),
        .MAX_DIGIT_10(5),
        .MIN_DIGIT(0)
    ) U_TCNT_SEC_W (
        .clk(clk),
        .rst(rst),
        .i_tick(w_otick_msec),
        .up(up),
        .down(down),
        .digit_1(sec_1),
        .digit_10(sec_10),

        .o_time(sec),
        .o_tick(w_otick_sec)
    );

    time_cnt_btn #(
        .TCNT(60),
        .BIT_WIDTH(6),
        .RESET_TIME(0),
        .MAX_DIGIT_1(9),
        .MAX_DIGIT_10(5),
        .MIN_DIGIT(0)
    ) U_TCNT_MIN_W (
        .clk(clk),
        .rst(rst),
        .i_tick(w_otick_sec),
        .up(up),
        .down(down),
        .digit_1(min_1),
        .digit_10(min_10),

        .o_time(min),
        .o_tick(w_otick_min)
    );

    time_cnt_btn #(
        .TCNT(24),
        .BIT_WIDTH(5),
        .RESET_TIME(12),
        .MAX_DIGIT_1(3),
        .MAX_DIGIT_10(2),
        .MIN_DIGIT(0)
    ) U_TCNT_HOUR_W (
        .clk(clk),
        .rst(rst),
        .i_tick(w_otick_min),
        .up(up),
        .down(down),
        .digit_1(hour_1),
        .digit_10(hour_10),

        .o_time(hour),
        .o_tick(w_otick_hour)
    );
endmodule

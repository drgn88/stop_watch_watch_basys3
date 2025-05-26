`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 18:34:00
// Design Name: 
// Module Name: top_watch_stopwatch
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


module top_watch_stopwatch (
    input clk,
    input rst,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input sw2,
    input sw1,
    input sw0,

    output [7:0] fnd_data,
    output [3:0] fnd_com,
    output [3:0] led
);

    wire [ 4:0] w_watch;
    wire [ 1:0] w_stop_watch;

    wire [ 6:0] watch_msec;
    wire [ 5:0] watch_sec;
    wire [ 5:0] watch_min;
    wire [ 4:0] watch_hour;

    wire [ 6:0] sw_msec;
    wire [ 5:0] sw_sec;
    wire [ 5:0] sw_min;
    wire [ 4:0] sw_hour;

    wire [23:0] w_fnd_time;

    assign led[1:0] = (!sw0) ? 2'b01 : 2'b10;
    assign led[3:2] = (!sw1) ? 2'b01 : 2'b10;

    demux_watch_sw U_DEMUX (
        .btnU(btnU),
        .btnD(btnD),
        .btnL(btnL),
        .btnR(btnR),
        .sw2 (sw2),
        .sel (sw1),

        .watch(w_watch),
        .stop_watch(w_stop_watch)
    );

    watch U_WATCH_BLOCK (
        .clk (clk),
        .rst (rst),
        .btnL(w_watch[2]),
        .btnR(w_watch[1]),
        .btnU(w_watch[4]),
        .btnD(w_watch[3]),
        .sw2 (w_watch[0]),
        .sw0 (sw0),

        .msec(watch_msec),
        .sec (watch_sec),
        .min (watch_min),
        .hour(watch_hour)
    );

    stop_watch U_SW_BLOCK (
        .clk(clk),
        .rst(rst),
        .btn_RS(w_stop_watch[1]),
        .btn_CLR(w_stop_watch[0]),

        .msec(sw_msec),
        .sec (sw_sec),
        .min (sw_min),
        .hour(sw_hour)
    );

    mux_24to1 U_MUX_24to1 (
        .watch_time({watch_msec, watch_sec, watch_min, watch_hour}),
        .stop_watch_time({sw_msec, sw_sec, sw_min, sw_hour}),
        .sw1(sw1),

        .fnd_time(w_fnd_time)
    );

    fnd_ctrl U_FND_CTRL (
        .clk(clk),
        .rst(rst),
        .sel_sw0(sw0),
        .sw1(sw1),
        .sw2(sw2),
        .msec(w_fnd_time[23:17]),
        .sec (w_fnd_time[16:11]),
        .min (w_fnd_time[10:5]),
        .hour(w_fnd_time[4:0]),

        .fnd_data(fnd_data),
        .fnd_com (fnd_com)
    );
endmodule

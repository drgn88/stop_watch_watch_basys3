`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/15 14:48:03
// Design Name: 
// Module Name: fnd_ctrl
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


module fnd_ctrl (
    input clk,
    input rst,
    input sel_sw0,
    input sw1,
    input sw2,
    input [6:0] msec,
    input [5:0] sec,
    input [5:0] min,
    input [4:0] hour,

    output [7:0] fnd_data,
    output [3:0] fnd_com
);

    wire [3:0] w_bcd_m_sec, w_bcd_h_m, w_bcd_out;
    wire [3:0] w_msec_1, w_msec_10, w_sec_1, w_sec_10;
    wire [3:0] w_min_1, w_min_10, w_hour_1, w_hour_10;


    wire [2:0] w_fnd_sel;
    wire       w_oclk;
    wire [3:0] w_dot_signal;

    assign w_bcd_out = (sel_sw0 == 1) ? w_bcd_h_m : w_bcd_m_sec;

    time_compare U_TCPR (
        .msec(msec),

        .dot(w_dot_signal)
    );

    time_splitter #(
        .BIT_WIDTH(7)
    ) U_SPLIT_MSEC (
        .i_time(msec),

        .time_1 (w_msec_1),
        .time_10(w_msec_10)
    );

    time_splitter #(
        .BIT_WIDTH(6)
    ) U_SPLIT_SEC (
        .i_time(sec),

        .time_1 (w_sec_1),
        .time_10(w_sec_10)
    );

    time_splitter #(
        .BIT_WIDTH(6)
    ) U_SPLIT_MIN (
        .i_time(min),

        .time_1 (w_min_1),
        .time_10(w_min_10)
    );

    time_splitter #(
        .BIT_WIDTH(5)
    ) U_SPLIT_HOUR (
        .i_time(hour),

        .time_1 (w_hour_1),
        .time_10(w_hour_10)
    );


    mux_8to1 U_MUX0 (
        .sel(w_fnd_sel),
        .digit_1(w_msec_1),
        .digit_10(w_msec_10),
        .digit_100(w_sec_1),
        .digit_1000(w_sec_10),
        .dot_signal(w_dot_signal),
        .bcd(w_bcd_m_sec)
    );

    mux_8to1 U_MUX1 (
        .sel(w_fnd_sel),
        .digit_1(w_min_1),
        .digit_10(w_min_10),
        .digit_100(w_hour_1),
        .digit_1000(w_hour_10),
        .dot_signal(w_dot_signal),
        .bcd(w_bcd_h_m)
    );

    bcd_ctrl U_BCD0 (
        .bcd(w_bcd_out),
        .fnd_data(fnd_data)
    );


    // decoder_2x4 U_DEC0 (
    //     .fnd_sel(w_fnd_sel[1:0]),
    //     .fnd_com(fnd_com)
    // );

    fnd_com_ctrl U_FND_COM_CTRL(
    .clk(clk),
    .clk_1k(w_oclk),
    .rst(rst),
    .sw0(sel_sw0),
    .sw1(sw1),
    .sw2(sw2),
    .fnd_sel(w_fnd_sel[1:0]),

    .fnd_com(fnd_com)
);

    clk_divider_1k U_CLKD0 (
        .clk(clk),
        .rst(rst),

        .oclk(w_oclk)
    );

    counter_8b U_CNT0 (
        .clk(w_oclk),
        .rst(rst),
        .fnd_sel(w_fnd_sel)
    );


endmodule

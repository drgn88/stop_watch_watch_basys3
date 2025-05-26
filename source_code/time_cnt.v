`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/16 10:24:01
// Design Name: 
// Module Name: time_cnt
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


module time_cnt #(
    parameter TCNT = 100,
    parameter BIT_WIDTH = 7,
    parameter RESET_TIME = 0
) (
    input clk,
    input rst,
    input i_tick,
    output reg [BIT_WIDTH - 1:0] o_time,
    output o_tick
);

    reg [($clog2(TCNT) - 1):0] tcnt, tcnt_next;
    reg rotick, rotick_next;


    //State register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rotick <= 0;
            tcnt   <= RESET_TIME;
            //오류코드: (rst아닐때 문제 --> 정의안됨)
            //o_time <= 0;

        end else begin
            tcnt   <= tcnt_next;
            rotick <= rotick_next;
        end
    end

    //Next state logic
    always @(*) begin
        if (i_tick && (tcnt != (TCNT - 1))) begin
            tcnt_next   = tcnt + 1;
            rotick_next = 0;
        end else if (i_tick && (tcnt == (TCNT - 1))) begin
            tcnt_next   = 0;  
            rotick_next = 1;
        end else begin
            tcnt_next   = tcnt;
            rotick_next = 0;
        end
    end

    //Output logic(내방식)
    // always @(posedge clk) begin
    //     if(tcnt == (TCNT - 1)) begin
    //         o_tick <= 1; 
    //     end
    //     else begin
    //         o_tick <= 0;
    //     end
    // end

    always @(*) begin
        if (tcnt == 0) begin
            o_time = 0;
        end else begin
            o_time = tcnt;
        end
    end

    assign o_tick = rotick;
endmodule

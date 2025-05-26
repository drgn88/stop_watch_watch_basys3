`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 16:23:29
// Design Name: 
// Module Name: time_cnt_btn
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


module time_cnt_btn #(
    parameter TCNT = 100,
    parameter BIT_WIDTH = 7,
    parameter RESET_TIME = 0,
    parameter MAX_DIGIT_1 = 9,
    parameter MAX_DIGIT_10 = 5,
    parameter MIN_DIGIT = 0
) (
    input clk,
    input rst,
    input i_tick,
    input up,
    input down,
    input digit_1,
    input digit_10,

    output reg [BIT_WIDTH - 1:0] o_time,
    output o_tick
);
    reg [($clog2(TCNT) - 1):0] tcnt, tcnt_next;
    reg rotick, rotick_next;

    wire [9:0] condition;
    wire max_10, max_1, min_10, min_1;
    wire tcnt_max;

    assign max_10 = ((tcnt / 10) == MAX_DIGIT_10) ? 1 : 0;
    assign max_1 = ((tcnt % 10) == MAX_DIGIT_1) ? 1 : 0;
    assign min_10 = ((tcnt / 10) == MIN_DIGIT) ? 1 : 0;
    assign min_1 = ((tcnt % 10) == MIN_DIGIT) ? 1 : 0;
    assign tcnt_max = (tcnt == (TCNT-1)) ? 1 : 0;
    assign condition = {i_tick, tcnt_max, max_10, max_1, min_10, min_1, digit_10, digit_1, up, down};

    //State register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rotick <= 0;
            tcnt   <= RESET_TIME;
        end else begin
            tcnt   <= tcnt_next;
            rotick <= rotick_next;
        end
    end

    always @(*) begin
        casez (condition)
            10'b10ZZZ_ZZZZZ: begin
                tcnt_next = tcnt + 1;
                rotick_next = 0;
            end
            10'b11ZZZ_ZZZZZ: begin
                tcnt_next = 0;
                rotick_next = 1;
            end
            10'bZZ1ZZ_Z1010: begin
                tcnt_next = tcnt - (MAX_DIGIT_10 * 10);
                rotick_next = 0;
            end
            10'bZZ0ZZ_Z1010: begin
                tcnt_next = tcnt + 10;
                rotick_next = 0;
            end
            10'bZZZ1Z_Z0110: begin
                tcnt_next = tcnt - MAX_DIGIT_1;
                rotick_next = 0;
            end
            10'bZZZ0Z_Z0110: begin
                tcnt_next = tcnt + 1;
                rotick_next = 0;
            end
            10'bZZZZ1_Z1001: begin
                tcnt_next = tcnt + (MAX_DIGIT_10 * 10);
                rotick_next = 0;
            end
            10'bZZZZ0_Z1001: begin
                tcnt_next = tcnt - 10;
                rotick_next = 0;
            end
            10'bZZZZZ_10101: begin
                tcnt_next = tcnt + MAX_DIGIT_1;
                rotick_next = 0;
            end
            10'bZZZZZ_00101: begin
                tcnt_next = tcnt - 1;
                rotick_next = 0;
            end
            default: begin
                tcnt_next = tcnt;
                rotick_next = 0;
            end 
        endcase
    end


    always @(*) begin
        if (tcnt == 0) begin
            o_time = 0;
        end else begin
            o_time = tcnt;
        end
    end

    assign o_tick = rotick;
endmodule

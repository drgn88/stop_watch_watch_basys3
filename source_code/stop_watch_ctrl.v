`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/16 14:32:34
// Design Name: 
// Module Name: stop_watch_ctrl
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


module stop_watch_ctrl (
    input clk,
    input rst,
    input i_run_stop,
    input i_clear,

    output reg run_stop,
    output reg clear
);


    parameter STOP = 2'd0;
    parameter RUN = 2'd1;
    parameter CLEAR = 2'd2;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STOP:
            if (i_run_stop) begin
                next_state = RUN;
            end else if(i_clear)begin
                next_state = CLEAR;
            end
            else begin
                next_state = STOP;
            end
            RUN:
            if (i_run_stop) begin
                next_state = STOP;
            end else begin
                next_state = RUN;
            end
            CLEAR : if(i_clear) begin
                next_state = STOP;
            end
            else begin
                next_state = CLEAR;
            end
            default: next_state = STOP;
        endcase
    end

    always @(*) begin
        case (state)
            STOP : begin
                run_stop = 1;
                clear = 0;
            end
            RUN : begin
                run_stop = 0;
                clear = 0;
            end
            CLEAR: begin
                run_stop = 1;
                clear = 1;
            end
            default: begin
                run_stop = 1;
                clear = 0;
            end
        endcase
    end
endmodule

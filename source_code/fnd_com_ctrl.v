`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/23 19:54:51
// Design Name: 
// Module Name: fnd_com_ctrl
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


module fnd_com_ctrl (
    input clk,
    input clk_1k,
    input rst,
    input sw0,
    input sw1,
    input sw2,
    input [1:0] fnd_sel,

    output reg [3:0] fnd_com
);

    localparam IDLE = 0;
    localparam SEC_CHANGE = 1;
    localparam MIN_H_CHANGE = 2;

    reg [1:0] state, next_state;

    wire [3:0] w_pwm;

    pwm_gen #(
        .DUTY(300),
        .MAX_TIME(1000)
    ) PWM_0 (
        .clk_1k(clk_1k),
        .rst(rst),

        .pwm(w_pwm)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE:
            if ((!sw0) && (!sw2)) begin
                next_state = SEC_CHANGE;
            end else if ((sw0) && (!sw2)) begin
                next_state = MIN_H_CHANGE;
            end else begin
                next_state = IDLE;
            end
            SEC_CHANGE:
            if (sw2 | sw1) begin
                next_state = IDLE;
            end else if ((sw0) && (!sw2)) begin
                next_state = MIN_H_CHANGE;
            end else begin
                next_state = SEC_CHANGE;
            end
            MIN_H_CHANGE:
            if (sw2 | sw1) begin
                next_state = IDLE;
            end else if ((!sw0) && (!sw2)) begin
                next_state = SEC_CHANGE;
            end else begin
                next_state = MIN_H_CHANGE;
            end
        endcase
    end

    always @(*) begin
        case (state)
            IDLE: begin
                case (fnd_sel)
                    2'b00:   fnd_com = 4'b1110;
                    2'b01:   fnd_com = 4'b1101;
                    2'b10:   fnd_com = 4'b1011;
                    2'b11:   fnd_com = 4'b0111;
                    default: fnd_com = 4'b1111;
                endcase
            end
            SEC_CHANGE: begin
                case (fnd_sel)
                    2'b00:   fnd_com = 4'b1110;
                    2'b01:   fnd_com = 4'b1101;
                    2'b10:   fnd_com = {(1'b1), (w_pwm[2]), 2'b11};
                    2'b11:   fnd_com = {w_pwm[3], (3'b111)};
                    default: fnd_com = 4'b1111;
                endcase
            end
            MIN_H_CHANGE:
            case (fnd_sel)
                2'b00:   fnd_com = {(3'b111), w_pwm[0]};
                2'b01:   fnd_com = {(2'b11),(w_pwm[1]),(1'b1)};
                2'b10:   fnd_com = {(1'b1), (w_pwm[2]), (2'b11)};
                2'b11:   fnd_com = {w_pwm[3], (3'b111)};
                default: fnd_com = 4'b1111;
            endcase
            default: fnd_com = 4'b1111;
        endcase
    end
endmodule

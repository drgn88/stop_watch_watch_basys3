`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/16 14:52:15
// Design Name: 
// Module Name: step_pulse_gen
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


module step_pulse_gen (
    input  clk,
    input  rst,
    input  btn,
    output reg step_pulse
);

    parameter s0 = 1'b0, s1 = 1'b1;

    reg state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= s0;
            step_pulse = 1'b0;
        end else
            case (state)
                s0:
                if (btn) begin
                    state <= s1;
                    step_pulse = 1'b1;
                end else begin
                    state <= s0;
                    step_pulse = 1'b0;
                end
                s1:
                if (btn) begin
                    state <= s1;
                    step_pulse = 1'b0;
                end else begin
                    state <= s0;
                    step_pulse = 1'b0;
                end
            endcase
    end
endmodule


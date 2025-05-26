`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/23 19:56:39
// Design Name: 
// Module Name: pwm_gen
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


module pwm_gen#(
    parameter DUTY = 5,
    parameter MAX_TIME = 10
    )(
    input clk_1k,
    input rst,

    output reg [3:0] pwm
    );
    
    reg [($clog2(MAX_TIME) - 1):0] cnt;

    always @(posedge clk_1k or posedge rst) begin
        if(rst) begin
            pwm <= 4'b1111;
            cnt <= 0;
        end
        else if(cnt <= (DUTY - 1)) begin
            pwm <= 4'b1111;
            cnt <= cnt + 1;
        end
        else if(cnt == (MAX_TIME - 1)) begin
            pwm <= 0;
            cnt <= 0;
        end
        else begin
            pwm <= 0;
            cnt <= cnt + 1;
        end
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 15:05:35
// Design Name: 
// Module Name: watch_CU
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


module watch_CU (
    input clk,
    input rst,
    input sw2,
    input sw0,
    input btnL,
    input btnR,
    
    output sec_1,
    output sec_10,
    output min_1,
    output min_10,
    output hour_1,
    output hour_10,
    output reg stop
);

    localparam STOP = 3'd0;
    localparam RUN = 3'd1;
    localparam SEC_CHANGE = 3'd2;
    localparam MIN_H_CHANGE = 3'd3;
    localparam SEC_SHIFT_L = 3'd4;
    localparam SEC_SHIFT_R = 3'd5;
    localparam MIN_H_SHIFT_L = 3'd6;
    localparam MIN_H_SHIFT_R = 3'd7;
    

    // reg [2:0] state, next_state;
    // reg [1:0] sec_reg;
    // reg [3:0] min_h_reg;

    reg [2:0] state, next_state;
    reg [2:0] sec_reg;
    reg [4:0] min_h_reg;

    //state register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= STOP;
        end
        else begin
            state <= next_state;
        end
    end

    // always @(posedge clk or posedge rst) begin
    //     if(rst || (state == STOP)) begin
    //         sec_reg <= 2'b01;
    //         min_h_reg <= 4'b0001;
    //     end
    //     else if(state == SEC_SHIFT_L) begin
    //         sec_reg[0] <= sec_reg[1];
    //         sec_reg[1] <= sec_reg[0];
    //         min_h_reg <= min_h_reg;
    //     end
    //     else if(state == SEC_SHIFT_R) begin
    //         sec_reg[0] <= sec_reg[1];
    //         sec_reg[1] <= sec_reg[0];
    //         min_h_reg <= min_h_reg;
    //     end
    //     else if(state == MIN_H_SHIFT_L) begin
    //         sec_reg <= sec_reg;
    //         min_h_reg[0] <= min_h_reg[3];
    //         min_h_reg[3:1] <= min_h_reg[2:0];
    //     end
    //     else if(state == MIN_H_SHIFT_R) begin
    //         sec_reg <= sec_reg;
    //         min_h_reg[3] <= min_h_reg[0];
    //         min_h_reg[2:0] <= min_h_reg[3:1];
    //     end
    //     else begin
    //         sec_reg <= sec_reg;
    //         min_h_reg <= min_h_reg;
    //     end
    // end

    always @(posedge clk or posedge rst) begin
        if(rst || (state == STOP)) begin
            sec_reg <= 3'b001;
            min_h_reg <= 5'b00001;
        end
        else if(state == SEC_SHIFT_L) begin
            sec_reg[0] <= sec_reg[2];
            sec_reg[2:1] <= sec_reg[1:0];
            min_h_reg <= 5'b00001;
        end
        else if(state == SEC_SHIFT_R) begin
            sec_reg[2] <= sec_reg[0];
            sec_reg[1:0] <= sec_reg[2:1];
            min_h_reg <= 5'b00001;
        end
        else if(state == MIN_H_SHIFT_L) begin
            sec_reg <= 3'b001;
            min_h_reg[0] <= min_h_reg[4];
            min_h_reg[4:1] <= min_h_reg[3:0];
        end
        else if(state == MIN_H_SHIFT_R) begin
            sec_reg <= 3'b001;
            min_h_reg[4] <= min_h_reg[0];
            min_h_reg[3:0] <= min_h_reg[4:1];
        end
        else begin
            sec_reg <= sec_reg;
            min_h_reg <= min_h_reg;
        end
    end

    //Next state logic
    // always @(*) begin
    //     case (state)
    //         STOP: if(sw2) begin
    //             next_state = RUN;
    //         end
    //         else if(sw0) begin
    //             next_state = MIN_H_CHANGE;
    //         end
    //         else begin
    //             next_state = SEC_CHANGE;
    //         end
    //         RUN: if(!sw2) begin
    //             next_state = STOP;
    //         end
    //         else begin
    //             next_state = RUN;
    //         end
    //         MIN_H_CHANGE : if(btnL) begin
    //             next_state = MIN_H_SHIFT_L;
    //         end
    //         else if(btnR) begin
    //             next_state = MIN_H_SHIFT_R;
    //         end
    //         else if(sw2) begin
    //             next_state = RUN;
    //         end
    //         else if(!sw0) begin
    //             next_state = SEC_CHANGE;
    //         end
    //         else begin
    //             next_state = MIN_H_CHANGE;
    //         end
    //         SEC_CHANGE : if(btnL) begin
    //             next_state = SEC_SHIFT_L;
    //         end
    //         else if(sw0) begin
    //             next_state = MIN_H_CHANGE;
    //         end
    //         else if(btnR) begin
    //             next_state = SEC_SHIFT_R;
    //         end
    //         else if(sw2) begin
    //             next_state = RUN;
    //         end
    //         else begin
    //             next_state = SEC_CHANGE;
    //         end
    //         MIN_H_SHIFT_L : next_state = MIN_H_CHANGE;
    //         MIN_H_SHIFT_R : next_state = MIN_H_CHANGE;
    //         SEC_SHIFT_L : next_state = SEC_CHANGE;
    //         SEC_SHIFT_R : next_state = SEC_CHANGE; 
    //         default : state = STOP;
    //     endcase
    // end

    always @(*) begin
        case (state)
            STOP: if(sw2) begin
                next_state = RUN;
            end
            else if(sw0) begin
                next_state = MIN_H_CHANGE;
            end
            else begin
                next_state = SEC_CHANGE;
            end
            RUN: if(!sw2) begin
                next_state = STOP;
            end
            else begin
                next_state = RUN;
            end
            MIN_H_CHANGE : if(btnL) begin
                next_state = MIN_H_SHIFT_L;
            end
            else if(btnR) begin
                next_state = MIN_H_SHIFT_R;
            end
            else if(sw2) begin
                next_state = RUN;
            end
            else if(!sw0) begin
                next_state = SEC_CHANGE;
            end
            else begin
                next_state = MIN_H_CHANGE;
            end
            SEC_CHANGE : if(btnL) begin
                next_state = SEC_SHIFT_L;
            end
            else if(sw0) begin
                next_state = MIN_H_CHANGE;
            end
            else if(btnR) begin
                next_state = SEC_SHIFT_R;
            end
            else if(sw2) begin
                next_state = RUN;
            end
            else begin
                next_state = SEC_CHANGE;
            end
            MIN_H_SHIFT_L : next_state = MIN_H_CHANGE;
            MIN_H_SHIFT_R : next_state = MIN_H_CHANGE;
            SEC_SHIFT_L : next_state = SEC_CHANGE;
            SEC_SHIFT_R : next_state = SEC_CHANGE; 
            default : state = STOP;
        endcase
    end

    //Output logic
    always @(*) begin
        case (state)
            STOP : begin
                stop = 1'b1;
            end
            RUN : begin
                stop = 1'b0;
            end
            default: stop = 1'b1;
        endcase
    end

    assign {sec_10, sec_1} = sec_reg[2:1];
    assign {hour_10, hour_1, min_10, min_1} = min_h_reg[4:1];

endmodule

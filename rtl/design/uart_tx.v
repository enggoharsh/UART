`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 14:27:33
// Design Name: 
// Module Name: uart_tx
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


module uart_tx #(
 parameter DBIT = 8,             // data bits
            SB_TICK = 16)      // ticks for stop bits
(
input clk,
input rst,
input tx_start,
input s_tick,
input [7:0] din,
output reg tx_done_tick,
output tx


    );
    
    // fsm state type & priority
parameter idle = 2'b00, start = 2'b01, data = 2'b10, stop = 2'b11;

// signal declartation
reg [1:0] state_reg, state_next;
reg [3:0] s_reg, s_next;
reg [2:0] n_reg, n_next;
reg [7:0] b_reg, b_next;
reg tx_reg, tx_next;

// body
// fsmd state and data registers
always @(posedge clk or posedge rst)
    begin
        if (rst)
            begin
                state_reg <= idle;
                s_reg <= 0;
                n_reg <= 0;
                b_reg <= 0;
                tx_reg <= 1'b1;
                
            end
       else
        begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= s_next;
            b_reg <= s_next;
            tx_reg <= tx_next;
        end
    end
    
// fsmd next state logic & functional units
always @(*)
    begin
        state_next = state_reg;
        tx_done_tick = 1'b0;
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;
        tx_next = tx_reg;
        case (state_reg)
            idle:
                begin
                tx_next = 1'b1; 
                if (~tx)
                    begin
                        state_next = start;
                        s_next = 0;
                        b_next = din;
                    end
                end
            start:
                begin
                tx_next = 1'b0;
                if (s_tick)
                    if (s_reg == 15)
                        begin
                            state_next = data;
                            s_next = 0;
                            n_next = 0;
                        end
                   else
                    s_next = s_reg + 1;
            end
            data:
                begin
                tx_next = b_reg [0];
                if (s_tick)
                    if (s_reg == 15)
                        begin
                            s_next = 0;
                            b_next = b_reg >> 1;
                            if (n_reg == (DBIT - 1))
                                state_next = stop;
                            else
                                n_next = n_reg + 1;
                        end
                        else
                            s_next = s_reg + 1;
            end
            stop:
                begin
                tx_next = 1'b1;
                if (s_tick)
                    if (s_reg == (SB_TICK - 1))
                        begin
                            state_next = idle;
                            tx_done_tick = 1'b1;
                        end
                    else
                        s_next = s_reg + 1;
                end
       endcase            
   end
   
   // output
 assign tx = tx_reg;    
endmodule

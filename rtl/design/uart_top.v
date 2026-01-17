`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.01.2026 00:54:19
// Design Name: 
// Module Name: uart_top
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


module uart_top(input clk,
input rst,
input [10:0] dvsr,
input [7:0] din,
input rx,
input tx_start,
output tx,
output [7:0] dout,
output rx_done_tick,
output tx_done_tick


    );
 wire tick;
 baud_gen b1 (clk, rst, dvsr, tick);    // baud generator for receiver as well as transmitter
 uart_rx r1 (clk, rst, rx, tick, rx_done_tick, dout);
 uart_tx t1 (clk, rst, tx_start, tick, din, tx_done_tick, tx);
endmodule

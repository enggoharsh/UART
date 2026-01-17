`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.01.2026 01:11:20
// Design Name: 
// Module Name: uart_top_tb
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


module uart_top_tb(

    );
    /*
    input clk,
input rst,
input [10:0] dvsr,
input [7:0] din,              // design signals
input rx,
input tx_start,
output tx,
output [7:0] dout,
output rx_done_tick,
output tx_done_tick
    */
    
  reg clk, rst, rx, tx_start;
  reg [10:0] dvsr;
  reg [7:0] din;
  wire tx, rx_done_tick, tx_done_tick;
  wire [7:0] dout;
 uart_top dut (clk,  rst, dvsr, din, rx, tx_start, tx, dout, rx_done_tick, tx_done_tick );

 initial
    begin
        clk = 0;
        dvsr = 11'd14;
        din = 8'd14;
        rx = 0;
        tx_start = 0;
        forever #5 clk = ~clk;
    end
    
initial
    begin
        #2 rst = 1;
       #5  rst = 0;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.01.2026 18:34:40
// Design Name: 
// Module Name: baud_gen
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


module baud_gen(input clk,
input rst,
input [10:0] dvsr,
output tick 

    );
    // declaration
reg [10:0] r_reg;
wire [10:0] r_next;

 // body
 // register
 
always @(posedge clk or posedge rst)
    begin
        if (rst)
            r_reg <= 0;
        else
            r_reg <= r_next;
    end
// next-state logic
assign r_next = (r_reg == dvsr) ? 0 : (r_reg + 1);
// output logic
assign tick = (r_reg == 1);
endmodule

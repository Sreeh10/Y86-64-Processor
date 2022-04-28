`include "../AND/bit64and.v"
`include "../XOR/bit64xor.v"
`include "../ADDSUB/bit64addsub.v"
`include "../ADDSUB/bit1addsub.v"
`include "mux4x1.v"

module bit64ALU ( result , overflow , select_op ,  a , b ) ; // result is valE 

// ALU features --
// two 64-bit inputs and 2 select lines
//  a 64-bit output and a carry out line

input signed [63:0] a ;
input signed [63:0] b ;
// input sel0 , selvan ; // if two separate wires are taken
input [1:0] select_op ;     // if a single bus is used instead

output signed [63:0] result ;
output overflow     ;

wire addsub_overflow; // this tells whether our results are out of the ALU's capacity
wire c_out ;  // c_out is different from addsub_overflow , not used if a single ALU is enough
wire select1bar;

// seperate buses to store each operation output
// AND and SUB are not needed to be done simultaneously
wire signed [63:0] op0_1 ; // The same 64 bit ripple adder does both ADD and SUB
wire signed [63:0] op2 ;
wire signed [63:0] op3 ;

// prepare 3 outputs AND XOR ADD/SUB
// use a MUX to select one of these and transfer it to the output

// operation 0/1 ADD/SUB based on select line
// if selected operation is SUB ( i.e, op1 ), then c_in = 1 ;
bit64addsub operation0_1 ( .sum(op0_1) , .overflow(addsub_overflow) , .c_out(c_out) , .a(a) , .b(b) , .c_in(select_op[0]) ) ;

// operation2 bitwise AND operation for the 2 inputs
bit64and operation2 ( .bitand(op2), .a(a) , .b(b)) ; // no overflow

// operation3 bitwise XOR operation for the 2 inputs
bit64xor operation3 ( .bitxor(op3), .a(a) , .b(b)) ; // no overflow

not Gnot( select1bar, select_op[1]) ; // invert the select line
and Gand( overflow, select1bar , addsub_overflow) ; // overflow is set if both select lines are 1

// MUX is used to select which of these should pass to 'output result'
genvar i ;

generate

    for ( i = 0 ; i < 64 ; i = i +1 )

    begin

    mux4x1 outselector ( .out(result[i]) , .select(select_op), .data0(op0_1[i]) , .data1(op0_1[i]), .data2(op2[i]) , .data3(op3[i]) ) ;

    end

endgenerate

endmodule
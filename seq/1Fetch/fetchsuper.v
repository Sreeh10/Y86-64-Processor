`include "instruction_memory.v"

module fetchsuper ( imem_error , instr_valid , icode , ifun , rA, rB, valC , valP  ,  pc , clk   ) ;

output imem_error  ;
output reg instr_valid ;
output reg [3:0]icode ;  // first half of the 1st byte ==> 4 bits
output reg [3:0]ifun  ;  // second half of the 1st byte ==> 4 bits
output reg [3:0]rA    ;  // 16 slots in register file ==> 4 bits to select reg
output reg [3:0]rB    ;
output reg signed [63:0] valC  ;       // 64 bit integer value
output reg signed [63:0] valP ;       // 64 bit integer value

input clk ;
input [63:0] pc ; // program counter 

// internals 
wire [7:0] split ;
wire [71:0] align ;

reg need_regids ;
reg need_valC ;

// module instruction_memory (imem_error , split , align , pc ) ;   // internals are used here 
instruction_memory imem ( .imem_error(imem_error) , .split(split) , .align(align) , .pc(pc) ) ; 

always @( split , align ) begin 

     // $display ( "");


     icode   = split [7:4] ;
     ifun    =  split [3:0] ;

     need_regids = ((icode == 4'd2) || (icode == 4'd3) || (icode == 4'd4) || (icode == 4'd5) || (icode == 4'd6) || (icode == 4'hA) || (icode == 4'hB)) ? 1'b1 : 1'b0 ;
     need_valC = ((icode == 4'd3) || (icode == 4'd4) || (icode == 4'd5) || (icode == 4'd7) || (icode == 4'd8) ) ? 1'b1 : 1'b0 ;

     instr_valid = ( icode < 4'h0 || icode > 4'hb) ? 1'b0 : 
                        ( icode == 4'h2 || icode == 4'h7) ? ( ( ifun > 4'h6 ) ?  1'b0 :  1'b1 ) :
                        ( icode == 4'h6 ) ? ( ( ifun > 4'h3 ) ? 1'b0 : 1'b1 ) : 
                        ( ifun > 4'h0 ) ? 1'b0 : 1'b1 ;   


     if ( instr_valid ) begin 

          rA = need_regids ? align[7:4] : 4'hF ;
          rB = need_regids ? align[3:0] : 4'hF ;
          valC = need_valC ? (need_regids ? align[71:8]  : align[63:0]  ) : 64'b0 ;

          valP = pc +   1 + need_regids  + 8*need_valC  ; 

          // valP = pc +  
          // icode     == 4'h0  ? 0 :
          // need_valC == 1'b1  ? 
          //                     (need_regids ) ? 64'd10 : 64'd9 : 
          // need_regids == 1'b1 ? 64'h2 :
          // 64'h1 ; 

     end

     
     $display ( "in fetchsuper.v\t  instr_valid = %b , need_regids = %b , need_valC = %b , and valP = %h , icode = %h , ifun = %h, rA = %h , rB = %h , valC = %h for recevied  split = %h and align = %h " , instr_valid , need_regids , need_valC , valP , icode , ifun , rA , rB, valC ,split , align ) ;


                  

end 

endmodule
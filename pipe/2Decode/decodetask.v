`include "Dpipeblocks.v"
module decodetask ( dstE , dstM, srcA , srcB , cnd , icode , rA , rB , clk ) ;

// decodetask sendss inputs to reg file , based on inputs from prev stages 

output reg [3:0] srcA ;
output reg [3:0] srcB ;
output reg [3:0] dstE ;
output reg [3:0] dstM ; 

input clk ;
input cnd  ;
input [3:0]icode ;  // first half of the 1st byte ==> 4 bits
input [3:0]rA    ;  // 16 slots in register file ==> 4 bits to select reg
input [3:0]rB    ;

always @ ( rA , rB , icode  ) begin 

 // for decode 
 srcA  = ( icode == 4'h2 || icode == 4'h4  || icode == 4'h6 || icode  == 4'ha)  ? rA : 
              ( icode == 4'h9 || icode == 4'hb ) ? 4'h4 :   // stack pointer rsp == 4th indexed register 
              4'hf ;  // doesn't need any register , so just pointing to empty block , need not do this actually , but just simply 

 srcB  = ( icode == 4'h6 || icode == 4'h5 || icode == 4'h4 ) ? rB : 
              ( icode == 4'ha || icode == 4'hb || icode == 4'h8 || icode == 4'h9 )  ? 4'h4 : 
              4'hf ;

    // $display ( "in decodetask.v\t  srcA = %h , srcB = %h ", srcA , srcB ) ; 

// end 

// for writeback
// always @ ( icode ) begin 

    dstE = ( icode == 4'h2 ) ? ( (cnd == 1'b0) ? 4'hf : rB ) : 
              ( icode == 4'h3 || icode == 4'h6 ) ? rB : 
              ( icode == 4'ha || icode == 4'hb || icode == 4'h8 || icode == 4'h9 )  ? 4'h4 : 
              4'hf ;

    if  (cnd == 1'b0) begin 

        $display ( "condition not satisfied , redirecting conditional action on register %h to empty slot ... " , dstE ) ; 
    end 


    dstM = ( icode == 4'h5 || icode == 4'hb ) ? rA : 4'hf ;  

    $display ("in decodetask.v\t  srcA = %h , srcB = %h dstE = %h , dstM = %h for received rA = %h , rB = %h , icode = %h ,cnd =%b " , srcA, srcB , dstE , dstM , rA , rB ,icode , cnd ) ; 

end 

endmodule


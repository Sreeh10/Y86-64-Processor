module pcupdate ( pc , icode , cnd , valC , valM, valP , status , clk  ) ;

output reg signed [63:0] pc ; 

input clk ;
input [1:0]status ; 
input [3:0] icode ;        // icode == 0  , means halt , no pc update
input cnd ;                // for suitable icode ( jxx ) ,  cnd == 1  , then location change  ( give by valC )
input signed [63:0] valC ; // jxx , call 
input signed [63:0] valM ; // ret 
input signed [63:0] valP ; // jxx , common: halt , nop , push ,pop, opq , cmov , rm , mr , ir , 


initial begin
   pc <= 64'h0 ; 
end

// end
always @ ( negedge(clk) )
begin 

    if ( status == 2'h0 ) begin   // status == 0 is for all ok 
        pc =      ( icode == 4'h8 ) ? valC  :
                    ( icode == 4'h7 ) ? ( cnd ? valC : valP ) :
                    ( icode == 4'h9 ) ? valM :
                    valP ; 
    end 
    // else pc is not incremented  (not written explicitky)
    // and by the time the instruction repeats , the wrapper y86SEQ.v module does "$finish"
    
    
end 

endmodule
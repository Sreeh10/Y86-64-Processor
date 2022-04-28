module predictPC ( f_predPC  , f_valC , f_icode , f_valP )  ;

output signed [63:0] f_predPC   ;  // if negative , we throw an error 


input signed [63:0] f_valC  ; 
input [3:0] f_icode ;
input signed [63:0] f_valP ; 

assign f_predPC =  ( f_icode == 4'h7 || f_icode == 4'h8 ) ?  valC  : valP  ; 

endmodule 

///-------------------------------------------------------------------------/////

module selectPC (  f_PC , F_predPC , M_icode , M_cnd , M_valA , W_icode , W_valM ) ;

input [3:0] M_icode ;
input M_cnd ;
input signed [63:0] M_valA ;
input [3:0] W_icode ;
input signed [63:0] W_valM ; 
input signed [63:0] F_predPC ;


assign f_PC = ( M_icode == 4'h7 && M_cnd != 1'b1 ) ? M_valA  : 
              ( W_icode == 4'h9) ?  W_valM : 
              F_predPC ;

endmodule 

///------------------------------------------------------------------------------////

module Fstatus ( f_stat ,  instr_valid , f_icode   ) ;
output f_stat ;
input instr_valid ;
input [3:0]f_icode ;

assign f_stat = ( imem_error != 1'b0 ) ? 2'b10 : 
                ( instr_valid == 1'b0) ? 2'b11 :
                ( f_icode == 4'h0 ) ? 2'b00 :
                2'b00 ; // All OK by default 

endmodule 

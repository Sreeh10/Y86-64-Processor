module Esr ( E_stat , E_icode , E_ifun , E_valC , E_valA , E_valB , E_dstE , E_dstM , E_srcA , E_srcB , 
             D_stat , D_icode , D_ifun , D_valC , d_valA , d_valB , d_dstE , d_dstM , d_srcA , D_srcB , 
             clk, E_bubble  
            ) ; 

output E_stat  ; 
output [3:0] E_icode ;  
output [3:0] E_ifun  ; 
output signed  [63:0] E_valC  ; 
output signed  [63:0] E_valA  ; 
output signed  [63:0] E_valB  ; 
output [3:0] E_dstE  ; 
output [3:0] E_dstM  ; 
output [3:0] E_srcA  ; 
output [3:0] E_srcB  ; 

input clk ;
input E_bubble ;

input D_stat  ;
input [3:0] D_icode ;
input [3:0] D_ifun  ;
input signed  [63:0] D_valC  ;
input signed  [63:0] d_valA  ;
input signed  [63:0] d_valB  ;
input [3:0] d_dstE  ;
input [3:0] d_dstM  ;
input [3:0] d_srcA  ;
input [3:0] D_srcB  ;


always @(posedge (clk) ) begin 

    if ( E_bubble != 1'b1 ) begin 

        E_stat = D_stat  ; 
        E_icod = D_icode ; 
        E_ifun = D_ifun  ; 
        E_valC = D_valC  ; 
        E_valA = d_valA  ; 
        E_valB = d_valB  ; 
        E_dstE = d_dstE  ; 
        E_dstM = d_dstM  ; 
        E_srcA = d_srcA  ; 
        E_srcB = D_srcB  ; 

    end

    // else if it is bubbled 
    else begin 

        E_icode = 4'h1 ; // nop   

    end 


end 


endmodule 

///------------------------------------------------------------------------------------------////

module Econtrol ( E_bubble , e_cnd , E_icode , E_dstM ,  d_srcA ,d_srcB  ) ;


output E_bubble ;
input e_cnd ;
input [3:0] E_icode ;
input [3:0] E_dstM ; 
input [3:0] d_srcA ; 
input [3:0] d_srcB ; 


assign E_bubble =  ( E_icode == 4'h7 && e_cnd != 1'b1 ) ? 1'b1 :
                   ( (E_icode == 4'h5 || E_icode == 4'hb) && ( E_dstM == d_srcA || E_src == d_srcB) ) ? 1'b1 :
                   1'b0 ; 


endmodule 
                   
module Msr ( M_stat , M_icode , M_cnd , M_valE , M_valA , M_dstE , M_dstM , 
             clk , M_stall , 
             E_stat , E_icode, e_cnd , e_valE , E_valA , e_dstE , E_dstM ) ; 

 
output M_stat ;
output [3:0] M_icode ;
output M_cnd ;
output signed [63:0] M_valE ;
output signed [63:0] M_valA ;
output [3:0] M_dstE ;
output [3:0] M_dstM ;

input clk ;
input M_stall ;

input E_stat ;
input [3:0] E_icode;
input e_cnd ;
input signed [63:0] e_valE ;
input signed [63:0] E_valA ;
input [3:0] e_dstE ;
input [3:0] E_dstM ;


always @( posedge (clk) ) begin 

    if  (M_bubble != 1'b1 ) begin
           
        M_stat  = E_stat  ;          
        M_icode = E_icode ;         
        M_cnd   = e_cnd   ;       
        M_valE  = e_valE  ;          
        M_valA  = E_valA  ;          
        M_dstE  = e_dstE  ;          
        M_dstM  = E_dstM  ;          

    end

    // else is when M should be bubbled
    else begin 

        M_icode = 4'h1 ; // nop
    end 

end
endmodule


///------------------------------------------------------------------------------------------------///

module Mcontrol ( M_bubble , m_stat , w_stat ) ;

output M_bubble ;
input m_stat ; 
input w_stat ;

assign M_bubble = ( m_stat != 1'b0 ) ? 1'b1 :
                  ( w_stat != 1'b0 ) ? 1'b1 :
                  1'b0 ; 


endmodule 
             

module Wsr ( W_stat , W_icode , W_valE , W_valM ,W_dstE , W_dstM ,  
             clk , W_stall , 
            m_stat , M_icode , M_valE , m_valM , M_dstE , M_dstM ) ; 

output W_stat ;
output [3:0] W_icode;
output signed [63:0] W_valE ;
output signed [63:0] W_valM ;
output [3:0] W_dstE ;
output [3:0] W_dstM ;

input clk ;
input W_stall ;

input m_stat ;
input [3:0] M_icode ;
input signed [63:0] M_valE ;
input signed [63:0] m_valM ;
input [3:0] M_dstE ;
input [3:0] M_dstM ;


always @ ( posedge (clk) ) begin

    if ( W_stall  != 1'b1 ) begin 


        W_stat  = m_stat ; 
        W_icode = M_icode ; 
        W_valE  = M_valE ; 
        W_valM  = m_valM ; 
        W_dstE  = M_dstE ; 
        W_dstM  = M_dstM ; 

    end 

    // else hold the values for the next clk cycle 

end 


endmodule 


///--------------------------------------------------------------------------------------/////////

module Wcontrol ( W_stall , W_stat ) ; 

output W_stall ;
input W_stat ; 

assign W_stall =  (W_stat != 2'b00 ) ? 1'b1 : 1'b0 ; 

endmodule 
    
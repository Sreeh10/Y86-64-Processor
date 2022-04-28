module selFwdAB ( d_valA , d_valB , d_srcA , d_srcB , e_dstE , e_valE , M_dstE, M_valE , M_dstM , m_valM , W_dstM , W_valM , W_dstE , W_valE  ) ;  

output signed [63:0] d_valA ;
output signed [63:0] d_valB ;

input signed [63:0] d_rvalA ;  // from register file 
input signed [63:0] d_rvalB ;  // from register file
input [3:0] d_srcA ;
input [3:0] d_srcB ; 
input [3:0] e_dstE ;
input signed [63:0] e_valE ; 
input [3:0] M_dstE ;
input [3:0] M_dstM ;
input signed [63:0] m_valM ; 
input [3:0] W_dstM ;
input signed [63:0] W_valM ;
input [3:0] W_dstE ;
input signed [63:0] W_valE ;


assign d_valA = ( D_icode == 4'h8 || D_icode == 4'h7 ) ? D_valP  :
                ( dsrcA == e_dstE) ? e_valE :
                ( dsrcA == M_dstM ) ? M_valM :
                ( dsrcA == M_dstM ) ? M_valE :
                ( dsrcA == W_dstM ) ? W_valM :
                ( dsrcA == W_dstE ) ? W_valE :
                d_rvalA ;

assign d_valB = ( dsrcA == e_dstE) ? e_valE :
                ( dsrcA == M_dstM ) ? M_valM :
                ( dsrcA == M_dstM ) ? M_valE :
                ( dsrcA == W_dstM ) ? W_valM :
                ( dsrcA == W_dstE ) ? W_valE :
                d_rvalB ;


endmodule 
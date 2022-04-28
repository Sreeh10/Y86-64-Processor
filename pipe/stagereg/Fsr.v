module Fsr (  f_predPC , predPC , clk , F_stall ) ;


output signed [63:0] f_predPC ;   // if it is negative because of wrong opcode , then we say that an error has occured 
input clk ;
input signed [63:0] predPC ;
input stall ; 
// input bubble ; // no bubble for F stage register


always @ ( posedge (clk) )  begin

    if  ( !F_stall ) begin 
        
        f_predPC = predPC ;  // else , hold the same value as before , so else is not written explicitly

    end
   
end



endmodule 

// refer TB page : 499 


////-----------------------------------------------------------------------------------------------////

module Fcontrol ( F_stall , E_icode , E_dstM , D_icode , M_icode , d_srcA  , d_srcB ) ;

output  F_stall ;

input signed [3:0] E_dstM ;
input [3:0] D_icode ;
input [3:0] E_icode ;
input [3:0] M_icode ;
input [3:0] d_srcA ;
input [3:0] d_srcB ;
input clk ; 
                                                
always @ ( * ) begin
    // load/use hazard 
    if ( (E_icode == 4'h5 || E_icode == 4'hb) && ( E_dstM == d_srcA || E_dstM == d_srcB )) begin 
        
        // no stalling if different registers are being used 
        // other those that need to be updated by eariler instructions
            
        assign F_stall = 1'b1 ; 
         
    end 

    // processing ret 
    else if ( D_icode == 4'h9 || E_icode == 4'h9 || M_icode == 4'h9 ) begin 

        assign F_stall = 1'b1 ; 
    end 

    // no stalling in rest of the cases 

    else begin
    
        assign F_stall = 1'b0 ;

    end
end 
    
endmodule
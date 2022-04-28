module Dsr ( D_stat, D_icode , D_ifun , D_rA , D_rB , D_valC , D_valP  , D_stall , D_bubble , clk , 
f_stat , f_icode , f_ifun , f_rA , f_rB , f_valC , f_valP ) ; 


output reg D_stat ;
output reg  [3:0] D_icode ;
output reg  [3:0] D_ifun ;
output reg  [3:0] D_rA ;
output reg  [3:0] D_rB ;
output reg  signed [63:0] D_valC ;
output reg  signed [63:0] D_valP ;

input D_stall ;
input D_bubble ;
input clk ;

input  f_stat ;
input  [3:0] f_icode ;
input  f_ifun ; 
input  [3:0] f_rA ;
input  [3:0] f_rB ;
input signed  [63:0] f_valC ; 
input signed  [63:0] f_valP ; 


always @ (posedge(clk)) begin 


    if ( D_stall != 1'b0  && D_bubble != 1'b0   ) begin 

            D_stat = f_stat ;
            D_icode = f_icode;
            D_ifun = f_ifun ;
            D_rA =  f_rA ;
            D_rB = f_rB ; 
            D_valC = f_valC ; 

    end 

    else if ( D_stall == 1'b0 && D_bubble != 1'b0 ) begin 

            D_icode = 4'h1 ; // nop  , and this takes care of everything
    end

    // else stall , ( hold values for next clk cylce) ( not explicitly written )


end 

endmodule 


/// ---------------------------------------------------------------------------------------------------///

module Dcontrol (  D_stall ,  D_bubble , E_icode ,  e_cnd , E_dstM , d_srcA , d_srcB , D_icode , M_icode ) ;

// takes care of the combinations A and B also 
output D_stall ;
output D_bubble ;

input [3:0] E_icode ;
input e_cnd ;
input [3:0] E_dstM  ;
input [3:0] d_srcA  ;
input [3:0] d_srcB  ;
input [3:0] D_icode ;
input [3:0] M_icode ;


    always @( * )  begin 

        // general structure for alone hazards and their combinations :

            // if ret
                // if combA 
                // else if combB
                // else (just ret)

            // else if misp
            // else if hazard
            // else ( no need of control )



        // processing ret
        if ( D_icode == 4'h9 || E_icode == 4'h9 || M_icode == 4'h9 ) begin
                

                // combination A  : ret + mispredicated branch
                // mispredicted branch 
                if ( E_icode == 4'h7 && e_cnd != 1'b1 ) begin 

                        assign D_bubble = 1'b1 ; 
                        assign D_stall  = 1'b0 ;

                end 

                // combination B : ret + load/use hazard 
                // load/use hazard
                if ( (E_icode == 4'h5 || E_icode == 4'hb)  && (E_dstM == d_srcA || E_dstM == d_srcB) ) begin 

                    assign D_bubble = 1'b0 ;
                    assign D_stall  = 1'b1 ; 
                            
                    
                end 

                // simple ret , no combination
                else begin 
                    assign  D_bubble = 1'b1 ;
                    assign  D_stall  = 1'b0 ;
                end 
                
        end

   

        // mispredicted branch , no combination
        else if ( E_icode == 4'h7 && e_cnd != 1'b1 ) begin 

                assign D_bubble = 1'b1 ; 
                assign D_stall  = 1'b0 ;

        end
          
        

        // load/use hazard  ( this is given priority in case of combination , hence written later ) 
        // no combination
        else if ( (E_icode == 4'h5 || E_icode == 4'hb) && ( E_dstM == d_srcA || E_dstM == d_srcB) ) begin 

            // no stalling if different registers are being used 
            // other those that need to be updated by eariler instructions
            assign D_bubble = 1'b0 ;
            assign D_stall  = 1'b1 ; 
    
        end 

        // rest all cases 
        else begin 

            assign D_bubble = 1'b0 ; 
            assign D_stall  = 1'b0 ;
        end

                           
    end 


endmodule
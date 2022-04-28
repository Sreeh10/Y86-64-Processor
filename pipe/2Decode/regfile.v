module regfile ( valA, valB , valM, valE, dstE , dstM , srcA , srcB , clk ) ;

output reg signed [63:0] valA ; 
output reg signed [63:0] valB ; 

input clk ;
input signed [63:0] valM ;
input signed [63:0] valE ;
input [3:0] dstE ;
input [3:0] dstM ;
input [3:0] srcA ;
input [3:0] srcB ; 

reg  [63:0] file [14:0] ;   // last slot is empty  , so 15 reg 
wire [63:0] nonereg     ;  




initial begin 
        $writememh("reg_as_it_is.txt",file);
end 



//decode 
always @ ( srcA , srcB  ) begin 
    valA = ( srcA == 4'hf ) ? 64'h0  : file[srcA] ; 
    
    valB = ( srcB == 4'hf ) ? 64'h0  : file[srcB] ;
    $display ( "in regfile.v\t  valA = %h , valB = %h" , valA , valB ) ; 

end 





//writeback
always @(negedge(clk)) begin
    
    if ( dstE < 4'hf ) begin
        file[dstE] = valE ;
        $writememh("reg_as_it_is.txt",file);
        $display ( "value %h is being inserted into register %h" , valE , dstE ) ;
    end

    

end

always @(negedge(clk)) begin

    if ( dstM < 4'hf ) begin
        file[dstM] = valM ;
        $writememh("reg_as_it_is.txt",file);
        $display ( "value %h is being inserted into register %h" , valM , dstM ) ;
    end     


end

// always @* begin

//     if ( dstE < 4'hf )
//     begin

//         always @* begin
//             assign file[dstE] = valE ;
//         end
//         // assign file [dstE] = valE ; 
//     end

//     if ( dstM < 4'hf ) 
//     begin  
//         always @* begin
//         assign file [dstM] = valM ; 
//         end
//         // assign file [dstM] = valM ; 
//     end

// end


endmodule
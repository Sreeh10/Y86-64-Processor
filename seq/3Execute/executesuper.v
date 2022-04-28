`include "./ALUblock/ALU/bit64ALU.v"
// execute main block is ALU implemented in assignment 1
module executesuper ( cnd , valE , icode , ifun , valA , valB , valC) ;

output signed [63:0] valE ;
output reg cnd            ; 

// output reg signed [63:0] ALUa ;
// output reg signed [63:0] ALUb ;
// output [1:0] select_op ; 

input [3:0]icode ;
input [3:0]ifun  ;
input signed [63:0]valA ;
input signed [63:0]valB ;
input signed [63:0]valC ;

// ALU related , internals 
reg signed [63:0] ALUa ;
reg signed [63:0] ALUb ;
reg [1:0] select_op ;
reg  [2:0] cc ;         // 0 = OF  1 = SF  2 = ZF 
wire  overflow_flag ; 
reg setCC ; 



// module bit64ALU ( result , overflow , select_op ,  a , b ) ;
bit64ALU sastaALU ( .result(valE)  , .overflow ( overflow_flag ) , .select_op (select_op ), .a(ALUb) , .b(ALUa)) ; 


initial begin 
    cnd = 1'b1 ; 
end 

always @ ( * ) begin 
    setCC = ( icode == 4'h6 ) ? 1'b1 : 1'b0 ;  // only when opq  .because opq will be used instead of cmp 
    select_op = ( icode == 4'h2 || icode == 4'h3 || icode == 4'h4 || icode == 4'h5 || icode == 4'h9 || icode == 4'hb) ? 2'b00 : // cmov, irmovq, rmmov, mrmov, call, ret
                   ( icode == 4'h8 || icode == 4'ha ) ? 2'b01 : // call, pushq
                   ( icode == 4'h6 ) ? ifun[1:0] : 2'b01 ;
end 


always @(  valA , valB , valC ) begin 
    

    ALUa <= ( icode == 4'h2 || icode == 4'h6 ) ? valA :                                        // cmov , opq
              ( icode == 4'h3 || icode == 4'h4 || icode == 4'h5) ? valC : 64'h8 ;                // irmov, rmmov , mrmov
              // ( icode == 4'h8 || icode == 4'ha || icode == 4'h9 || icode == 4'hb) ?  64'd8 :  // call , pushq , ret , popq
              //   64'hz ;   // other operations don't need   

    ALUb <= ( icode == 4'h4 || icode == 4'h5 || icode == 4'h6 || icode == 4'h8 || icode == 4'h9 || icode == 4'ha || icode == 4'hb )? valB : 64'h0 ; 
            //   ( icode == 4'h2 || icode == 4'h3 ) ? 64'h0 :
            //  64'hz ; // other operations don't need 

    
    $monitor( "in executesuper.v ALUa = %h , ALUb = %h , select_op = %h ,  valE = %h" , ALUa, ALUb , select_op, valE ) ; 

end 


 

always @(*) begin 


    if ( setCC == 1'b1 ) 
    begin 
        cc[0] <= overflow_flag ;                    // overflow flag 
        cc[1] <= ( valE < 0 ) ? 1'b1 : 1'b0 ;  // sign flag
        cc[2] <= ( valE == 0 ) ? 1'b1 : 0 ;    // zero flag 

        $monitor ( "conditions are being set .... OF = %b , SF = %b , ZF = %b" , cc[0] , cc[1] , cc[2]) ;
    end


end  

always @(ifun , icode ) begin 

     

    cnd = ( icode == 4'h2 || icode == 4'h7 ) ? // conditional move , jmp
                            (ifun == 4'h1) ?   cc[1] ^ cc[0] | cc[2] :   // less than or equal   (SF ^ OF) | ZF 
                            (ifun == 4'h2) ?   cc[1] ^ cc[0]         :   // less than            SF ^ OF
                            (ifun == 4'h3) ?   cc[0]                 :   // equal                ZF
                            (ifun == 4'h4) ?   ~cc[0]                :   // not equal            ~ZF
                            (ifun == 4'h5) ?   ~(cc[1] ^ cc[0])      :
                            (ifun == 4'h6) ?   ~( (cc[1] ^ cc[0]) | cc[2]) : // greater than       ~(SF ^ OF) | ZF )
                            1'b1 : 1'b1;    // rrmovq   (icode == cmov ,  ifun == 0  for rrmovq)
    

end 

endmodule
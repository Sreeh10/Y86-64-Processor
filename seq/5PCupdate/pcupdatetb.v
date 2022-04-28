module pcupdatetb ( ) ; 
//  pcupdate ( pc , icode , cnd , valC , valM, valP , status , clk  ) 

wire signed [63:0] pc ; 

reg clk ;
reg [1:0] status ; 
reg [3:0] icode ;        // icode == 0  , means halt , no pc update
reg cnd ;                // for suitable icode ( jxx ) ,  cnd == 1  , then location change  ( give by valC )
reg signed [63:0] valC ; // jxx , call 
reg signed [63:0] valM ; // ret 
reg signed [63:0] valP ; // jxx , common: halt , nop , push ,pop, opq , cmov , rm , mr , ir , 

pcupdate DUT1 ( pc , icode , cnd , valC , valM, valP , status , clk  ) ;

initial begin

    
    $dumpfile("pcupdatetb.vcd");
    $dumpvars(0, DUT1 );

    clk = 0 ;
    
    // opq 
    #5
    icode = 4'h6 ;
    valP = 64'h7 ;
    status = 2'h0;
    clk = ~clk ;
    #5 
    $display("new pc = %h" , pc ); 


    // call
    clk = ~clk ; 
    #5
    icode = 4'h8 ;
    valC = 64'h40 ; 
    // valP = 64'h7 ;
    status = 2'h0;
    clk = ~clk ;
    #5 
    $display("new pc = %h" , pc );


    // conditional jmp
    clk = ~clk ;
    #5
    icode = 4'h7 ;
    valC = 64'h107 ;
    status = 2'h0;
    cnd = 1 ; 
    valP = 64'd9 ;
    clk = ~clk ;
    #5 
    $display("new pc = %h" , pc );


end

endmodule 
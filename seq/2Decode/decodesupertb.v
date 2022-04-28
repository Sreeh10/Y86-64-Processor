module decodesupertb() ;

// dstE , dstM, srcA , srcB , cnd , icode , rA , rB , clk

// calculated by modules
wire [3:0] dstE ;
wire [3:0] dstM ;
wire [3:0] srcA ;
wire [3:0] srcB ;
wire [63:0] valA ;
wire [63:0] valB ;

// in our hands 

reg [63:0] valE ;
reg [63:0] valM ;
reg cnd  ; 
reg [3:0] icode ;
reg [3:0] rA ;
reg [3:0] rB ;

reg clk ;

// fetchsuper DUT0  ( .imem_error(imem_error) , .instr_valid(instr_valid) , .icode(icode) , .ifun(ifun) , .rA(rA), .rB(rB), .valC(valC) , .valP(valP)  ,  .pc(pc) , .clk(clk)    ) ;

decodetask DUT1 ( .dstE(dstE ) , .dstM(dstM), .srcA(srcA ) , .srcB(srcB ) , .cnd(cnd ) , .icode(icode ) , .rA(rA ) , .rB(rB ) , .clk(clk )  ) ; 

regfile DUT2 ( .valA(valA) , .valB(valB) , .valM(valM) , .valE(valE) , .dstE(dstE) , .dstM(dstM) , .srcA(srcA) , .srcB(srcB)  ) ;


initial begin 

    $dumpfile("decodesupertb.vcd");
    $dumpvars(0, DUT1 );
    $dumpvars(0, DUT2 );


    // irmovq $420 , %rcx
    clk = 0 ;  
    $display ("clk = %b\n" , clk ) ; 
    icode = 4'h3 ; 
    rA = 4'hf ;
    rB = 4'h1 ; 
    valE = 64'h420 ;
    cnd = 1 ; 
    #5
    clk = ~clk ; // 1

    #5
    $display ( "icode = %h , cnd = %b , valE = %h , valM = %h , valA = %h , valB = %h , dstE = %h , dstM = %h , srcA = %h , srcB = %h , \nclk = %b " , icode, cnd , valE, valM ,valA, valB , dstE , dstM , srcA , srcB , clk ) ; 

    // irmovq $32 , %rsp
    clk = ~clk ; // 0
    icode = 4'h3 ; 
    rA = 4'hf ; 
    rB = 4'h4 ;
    |}   
    cnd = 1 ;
    #5
    clk = ~clk ; //1 
    #5
    $display ( "icode = %h , cnd = %b , valE = %h , valM = %h , valA = %h , valB = %h , dstE = %h , dstM = %h , srcA = %h , srcB = %h , \nclk = %b " , icode, cnd , valE, valM ,valA, valB , dstE , dstM , srcA , srcB , clk ) ; 




    // cmovq %R[1] %R[7]
    clk = ~clk ; // 0
    icode = 4'h2 ; 
    rA = 4'h1 ;
    rB = 4'h7 ;
    valE = 64'h420;
    cnd = 1 ;
    #5
    clk = ~clk ; // 1 

    
    #5
    $display ( "icode = %h , cnd = %b , valE = %h , valM = %h , valA = %h , valB = %h , dstE = %h , dstM = %h , srcA = %h , srcB = %h , \nclk = %b " , icode, cnd , valE, valM ,valA, valB , dstE , dstM , srcA , srcB , clk ) ; 

    
    // cmovq %R[7] %R[6] with failed condition 
    clk = ~clk ; // 0
    icode = 4'h2 ; 
    rA = 4'h7 ;
    rB = 4'h6 ;
    valE = 64'h420 ;
    cnd = 0 ;
    #5

    clk = ~clk ; // 1
    #5
    $display ( "icode = %h , cnd = %b , valE = %h , valM = %h , valA = %h , valB = %h , dstE = %h , dstM = %h , srcA = %h , srcB = %h , \nclk = %b " , icode, cnd , valE, valM ,valA, valB , dstE , dstM , srcA , srcB , clk ) ; 


    // ret 
    clk = ~clk ; // 0 
    icode = 4'h9 ; 
    rA = 4'hf ;
    rB = 4'hf ;

    $display("here valB = %h " , valB ) ; 
    // valE = valB + 64'h8 ;
    valE = 64'd40 ; // valB + 8 = 40 
    
    
    cnd = 1 ;

    #5

    clk = ~clk ; // 1 
   
    
    #5
    $display ( "icode = %h , cnd = %b , valE = %h , valM = %h , valA = %h , valB = %h , dstE = %h , dstM = %h , srcA = %h , srcB = %h , \nclk = %b " , icode, cnd , valE, valM ,valA, valB , dstE , dstM , srcA , srcB , clk ) ; 





end 

endmodule 

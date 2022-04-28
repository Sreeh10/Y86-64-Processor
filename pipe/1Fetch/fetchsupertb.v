module fetchsupertb ( ) ;

wire imem_error  ;
wire instr_valid ;
wire [3:0]icode ;  // first half of the 1st byte ==> 4 bits
wire [3:0]ifun  ;  // second half of the 1st byte ==> 4 bits
wire [3:0]rA    ;  // 16 slots in register file ==> 4 bits to select reg
wire [3:0]rB    ;
wire signed [63:0] valC ;       // 64 bit integer value
wire signed [63:0] valP ;       // 64 bit integer value

reg [63:0] pc; 
reg clk ;

fetchsuper UUT  ( .imem_error(imem_error) , .instr_valid(instr_valid) , .icode(icode) , .ifun(ifun) , .rA(rA), .rB(rB), .valC(valC) , .valP(valP)  ,  .pc(pc) , .clk(clk)    ) ;

initial begin 

    $dumpfile("fetchsuper.vcd");
    $dumpvars(0, UUT);

    

    // clk = 0 ; 
    // $display ("clk = %b\n" , clk ) ; 
    pc  = 64'b0  ;
    #5
    // clk = ~clk ;


    #5 
    $display ("arrived at testbench, to display output values, ....."); 
    $display ( "imem_error :%b   instr_valid :%b   icode =%h  ifun =%h   rA =%h  rB =%h valC =%h valP =%h  pc = %h \n" ,imem_error, instr_valid,   icode,   ifun,  rA, rB,  valC, valP , pc ) ;
    // $display  ( "clk = %b\n------  instruction fetch ends ---------" , clk ) ;
    


    // clk = ~clk ;
    // $display ("clk = %b\n" , clk ) ; 
    
    // pc = valP ; 
    pc  = 64'd10 ;   // it must be handled manually here , because pc gets updated automatically for PC update block 
    #5
    // clk = ~clk ;

    #5 
    $display ("arrived at testbench, to display output values, ....."); 
    $display ( "imem_error :%b   instr_valid :%b   icode =%h  ifun =%h   rA =%h  rB =%h valC =%h valP =%h  pc = %h \n" ,imem_error, instr_valid,   icode,   ifun,  rA, rB,  valC, valP , pc ) ;
    // $display  ( "clk = %b\n------  instruction fetch ends ---------" , clk ) ;



    // clk = ~clk ;
    // $display ("clk = %b\n" , clk ) ; 
    // pc = valP ; 
    pc  = 64'd12 ;   // it must be handled manually here , because pc gets updated automatically for PC update block 
    #5
    // clk = ~clk ;

    #5 
    $display ("arrived at testbench, to display output values, ....."); 
    $display ( "imem_error :%b   instr_valid :%b   icode =%h  ifun =%h   rA =%h  rB =%h valC =%h valP =%h  pc = %h \n" ,imem_error, instr_valid,   icode,   ifun,  rA, rB,  valC, valP , pc ) ;
    // $display  ( "clk = %b\n------ instruction fetch ends ---------" , clk ) ;



    // clk = ~clk ;
    // $display ("clk = %b\n" , clk ) ; 
    // pc = valP ; 
    pc  = 64'd13 ;   // it must be handled manually here , because pc gets updated automatically for PC update block 
    #5
    // clk = ~clk ;

    #5  
    $display ("arrived at testbench, to display output values, ....."); 
    $display ( "imem_error :%b   instr_valid :%b   icode =%h  ifun =%h   rA =%h  rB =%h valC =%h valP =%h  pc = %h \n" ,imem_error, instr_valid,   icode,   ifun,  rA, rB,  valC, valP , pc ) ;
    // $display  ( "clk = %b\n------ instruction fetch ends ---------" , clk ) ;






end 


// always #5 clk= ~clk;

// always  @* begin
    

//     if ( icode == 4'h0 ) begin 

//         $finish ; 
//     end 
// end

endmodule
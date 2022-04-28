module memorysuoertb ( ) ; 

// memtask ( read_enable , write_enable ,  mem_address , mem_data , icode , valE , valA , valP , clk ) ; 
// datamem ( dmem_error , valM,  read_enable , write_enable , mem_address , mem_data )


reg clk          ;
reg [3:0]  icode ;
reg [63:0] valA ; 
reg [63:0] valE ;
reg [63:0] valP ; 


wire signed [63:0] valM   ; 
wire dmem_error           ; 
wire signed [63:0] mem_address ; 
wire signed [63:0] mem_data    ; 
wire read_enable               ; 
wire write_enable              ; 


memtask DUT1 ( .read_enable(read_enable) , .write_enable(write_enable) ,  .mem_address(mem_address) , .mem_data(mem_data) , .icode(icode) , .valE(valE) , .valA(valA) , .valP(valP) , .clk(clk) ) ; 
   
datamem DUT2 ( .dmem_error(dmem_error) , .valM(valM) ,  .read_enable(read_enable) , .write_enable(write_enable) , .mem_address(mem_address) , .mem_data(mem_data)  ) ; 



initial begin 

    $dumpfile("memorysupertb.vcd");
    $dumpvars(0, DUT1 );
    $dumpvars(0, DUT2 );

    // rmmovq r3 M[r1]
    icode = 4'h4 ; 
    valA  = 64'h1234 ; 
    valE  = 64'h60 ; // 96 in decimal
    
    #5
    $display ( "read_enable = %h , write_enable = %h ,  mem_address = %h , mem_data = %h , icode = %h , valE = %h , valA = %h , valP = %h " , read_enable , write_enable ,  mem_address , mem_data , icode , valE , valA , valP   ) ; 
    $display ( "dmem_error = %h, valM = %h,  read_enable = %h, write_enable = %h, mem_address = %h, mem_data = %h\n" , dmem_error , valM,  read_enable , write_enable , mem_address , mem_data) ; 
    
    
    // mrmovq 
    icode = 4'h5 ; 
    valE  = 64'h60 ; // 112 in decimal
    
    #5
    $display ( "read_enable = %h , write_enable = %h ,  mem_address = %h , mem_data = %h , icode = %h , valE = %h , valA = %h , valP = %h " , read_enable , write_enable ,  mem_address , mem_data , icode , valE , valA , valP   ) ; 
    $display ( "dmem_error = %h, valM = %h,  read_enable = %h, write_enable = %h, mem_address = %h, mem_data = %h\n" , dmem_error , valM,  read_enable , write_enable , mem_address , mem_data) ; 



end

endmodule
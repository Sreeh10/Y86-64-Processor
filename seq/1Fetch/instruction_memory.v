module instruction_memory (imem_error , split , align , pc ) ; 

output  reg imem_error   ;
output  reg [7:0]split   ;
output  reg [71:0]align  ;

input signed [63:0]pc ;
// input clk ;
reg  [7:0] ins_data [1023:0] ; // 1kB

// reads the opcodes from the "opcodes.txt" file
// and stores them in register array that is used as instruction memory
// only at t = 0, we read the opcodes and store them, we don't read it multiple times 

// initial  ; 

integer i ;

initial begin  // to display 

    $readmemh("opcodes.txt", ins_data) ; 

    // a new file is created to see what all instructions got loaded properly , it should have same values as opcodes.txt

    $writememh(  "instr_as_read.txt" , ins_data) ; 

    $display ( "read this data from the file") ; 


end

// always @(pc)  begin

// always @(posedge(clk)) begin

always @(pc) begin

    // $display ("") ;

    imem_error = ( pc < (64'h0) || pc > (64'h0fff)) ? 1'b1 : 1'b0 ;
    
    if ( ~imem_error) begin
        split = ins_data[pc] ;

        align[7:0]   = ins_data[pc+1] ;
        align[15:8]  = ins_data[pc+2] ;
        align[23:16] = ins_data[pc+3] ;
        align[31:24] = ins_data[pc+4] ;
        align[39:32] = ins_data[pc+5] ;
        align[47:40] = ins_data[pc+6] ;
        align[55:48] = ins_data[pc+7] ;
        align[63:56] = ins_data[pc+8] ;
        align[71:64] = ins_data[pc+9] ;

        $display ("in instruction_memory.v,  split = %h  align = %h  for received  pc = %h " , split , align , pc  ) ; 
    end 

 
    
     
  
end

endmodule
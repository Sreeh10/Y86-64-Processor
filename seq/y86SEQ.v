// including the 5 processor modules
// `include "./1Fetch/instruction_memory.v"
`include "./1Fetch/fetchsuper.v"
`include "./2Decode/decodetask.v"
`include "./2Decode/regfile.v" // for both decode and writeback we need the same reg file 
`include "./3Execute/executesuper.v"
`include "./4Memory/memtask.v"
`include "./4Memory/datamem.v"

`include "./5PCupdate/pcupdate.v"
// `include "opcodes.txt"

module y86SEQ ( clk , status  );


input clk ;

output reg [1:0] status ; 


// wire signed [63:0] pc = 64'h0 ;
wire signed [63:0] pc ;
wire imem_error;
wire instr_valid;
wire [3:0] icode;
wire [3:0] ifun;
wire [3:0] rA;
wire [3:0] rB;

wire [3:0] dstE;
wire [3:0] dstM;
wire [3:0] srcA;
wire [3:0] srcB;
wire cnd;

wire signed [63:0] valA;
wire signed [63:0] valB;
wire signed [63:0] valC;
wire signed [63:0] valE;
wire signed [63:0] valM;
wire signed [63:0] valP;

wire read_enable;
wire write_enable;
wire signed [63:0] mem_address;
wire signed [63:0] mem_data;
wire dmem_error;



// always @(posedge (clk) ) begin 
        fetchsuper sastaFetch(.imem_error(imem_error), .instr_valid(instr_valid), .icode(icode), .ifun(ifun), .rA(rA), .rB(rB), .valC(valC), .valP(valP), .pc(pc));
        decodetask sastaDecode(.dstE(dstE), .dstM(dstM), .srcA(srcA), .srcB(srcB), .cnd(cnd), .icode(icode), .rA(rA), .rB(rB) , .clk(clk) );
        regfile sastaRegfile(.valA(valA), .valB(valB), .valM(valM), .valE(valE), .dstE(dstE), .dstM(dstM), .srcA(srcA), .srcB(srcB) , .clk(clk));
        executesuper sastaExecute(.cnd(cnd), .valE(valE), .icode(icode), .ifun(ifun), .valA(valA), .valB(valB), .valC(valC));
        memtask sastaMemory(.read_enable(read_enable), .write_enable(write_enable), .mem_address(mem_address), .mem_data(mem_data), .icode(icode), .valE(valE), .valA(valA), .valP(valP), .clk(clk));
        datamem sastaData(.dmem_error(dmem_error), .valM(valM), .read_enable(read_enable), .write_enable(write_enable), .mem_address(mem_address), .mem_data(mem_data));
        pcupdate sastaPC(.pc(pc), .icode(icode), .cnd(cnd), .valC(valC), .valM(valM), .valP(valP) , .status ( status ) , .clk(clk) );


initial begin 

        status = 2'h0  ;
      
end 

always @(posedge(clk) ) begin 

        status =   (icode == 4'h0) ? 2'h1 : 
                    (!instr_valid) ? 2'h2 :
                    (imem_error || dmem_error ) ? 2'h3 :
                    2'h0 ; 


        $display( "hello status = %h" , status ) ;

        if ( status != 2'b0 ) begin 
                $finish ; 
        end 
end 



//end

endmodule
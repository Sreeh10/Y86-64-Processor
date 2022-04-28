// including the 5 processor modules
// `include "./1Fetch/instruction_memory.v"
`include "./1Fetch/fetchsuper.v"
`include "./2Decode/decodetask.v"
`include "./2Decode/regfile.v" // for both decode and writeback we need the same reg file 
`include "./3Execute/executesuper.v"
`include "./4Memory/memtask.v"
`include "./4Memory/datamem.v"
`include "./5PCupdate/pcupdate.v"
`include "./stagereg/Fsr.v"
`include "./stagereg/Dsr.v"
`include "./stagereg/Esr.v"
`include "./stagereg/Msr.v"
`include "./stagereg/Wsr.v"
// `include "./stagereg/Dsr.v"



// `include "opcodes.txt"

module y86SEQ ( clk , W_status  );


input clk ;
output reg [1:0] status ; 


// fetch stage wires 

  wire [63:0] updated_pc;
  wire [63:0] F_predPC ;

  wire [2:0]  f_stat;
  wire [3:0]  f_icode;
  wire [3:0]  f_ifun; 
  wire [3:0]  f_rA;
  wire [3:0]  f_rB;
  wire [63:0] f_valC;
  wire [63:0] f_valP;
  wire        imem_error;
  wire        instr_valid;


// decode stage wires
  wire [2:0]  D_stat;
  wire [3:0]  D_icode;
  wire [3:0]  D_ifun;
  wire [3:0]  D_rA;
  wire [3:0]  D_rB;
  wire [63:0] D_valC;
  wire [63:0] D_valP;
  wire [63:0] d_valA;
  wire [63:0] d_valB;


// execute stage wires
  wire [2:0]  e_stat;
  wire [3:0]  e_icode;
  wire [3:0]  e_ifun;
  wire        e_cnd;
  wire [3:0]  e_rA;
  wire [3:0]  e_rB;
  wire [63:0] e_valC;
  wire [63:0] e_valP;
  wire [63:0] e_valA;
  wire [63:0] e_valB;
  wire [63:0] e_valE;

// memory stage wires
  wire [2:0]  m_stat;
  wire [3:0]  m_icode;
  wire        m_cnd;
  wire [3:0]  m_rA;
  wire [3:0]  m_rB;
  wire [63:0] m_valC;
  wire [63:0] m_valP;
  wire [63:0] m_valA;
  wire [63:0] m_valB;
  wire [63:0] m_valE;
  wire [63:0] m_valM;

// writeback stage stories
  
  wire [2:0]  w_stat ;
  wire [3:0]  w_icode;
  wire        w_cnd;
  wire [3:0]  w_rA;
  wire [3:0]  w_rB;
  wire [63:0] w_valC;
  wire [63:0] w_valP;
  wire [63:0] w_valA;
  wire [63:0] w_valB;
  wire [63:0] w_valE;
  wire [63:0] w_valM;



        //

// wire signed [63:0] pc = 64'h0 ;
// wire signed [63:0] pc ;
// wire imem_error;
// wire instr_valid;
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



// fetch stage pipeline register 

// always @(posedge (clk) ) begin 

        // fetch stage  and  pc update 
        Fsr  f_aaa ( F_predPC , predPC , clk , F_stall   ) ;
        Fcontrol f_eee( F_stall , E_icode , E_dstM , D_icode , M_icode , d_srcA  , d_srcB ) ;
        predictPC f_bbb( f_predPC  , f_valC , f_icode , f_valP ) ;
        selectPC f_ccc(  f_PC , F_predPC , M_icode , M_cnd , M_valA , W_icode , W_valM ) ; 
        Fstatus f_ddd( f_stat ,  instr_valid , f_icode   ) ; 
        fetchsuper sastaFetch(.imem_error(imem_error), .instr_valid(instr_valid), .icode(f_icode), .ifun(f_ifun), .rA(f_rA), .rB(f_rB), .valC(valC), .valP(f_valP), .pc(f_PC));
        
        // decode stage  and register write back 
        Dsr d_aaa ( D_stat, D_icode , D_ifun , D_rA , D_rB , D_valC , D_valP  , D_stall , D_bubble , clk ,
            f_stat , f_icode , f_ifun , f_rA , f_rB , f_valC , f_valP ) ;
        Dcontrol d_bbb(  D_stall ,  D_bubble , E_icode ,  e_cnd , E_dstM , d_srcA , d_srcB , D_icode , M_icode )  ;
        selFwdAB d_ccc ( d_valA , d_valB , d_srcA , d_srcB , e_dstE , e_valE , M_dstE, M_valE , M_dstM , m_valM , W_dstM , W_valM , W_dstE , W_valE  ) ;  
        decodetask sastaDecode(.dstE(d_dstE), .dstM(d_dstM), .srcA(d_srcA), .srcB(d_srcB), .cnd(d_cnd), .icode(d_icode), .rA(D_rA), .rB(D_rB) , .clk(clk) );
        regfile sastaRegfile(.valA(d_rvalA), .valB(d_rvalB), .valM(W_valM), .valE(W_valE), .dstE(W_dstE), .dstM(W_dstM), .srcA(d_srcA), .srcB(d_srcB) , .clk(clk));



        // execute stage 
        Esr e_aaa( E_stat , E_icode , E_ifun , E_valC , E_valA , E_valB , E_dstE , E_dstM , E_srcA , E_srcB , 
             D_stat , D_icode , D_ifun , D_valC , d_valA , d_valB , d_dstE , d_dstM , d_srcA , D_srcB , 
             clk, E_bubble  
            ) ; 

        Econtrol e_bbb ( E_bubble , e_cnd , E_icode , E_dstM ,  d_srcA ,d_srcB  ) ;
        executesuper sastaExecute(.cnd(e_cnd), .valE(e_valE), .icode(E_icode), .ifun(E_ifun), .valA(E_valA), .valB(E_valB), .valC(E_valC));


        // Memory stage 
        Msr m_aaa( M_stat , M_icode , M_cnd , M_valE , M_valA , M_dstE , M_dstM , 
             clk , M_stall , 
             E_stat , E_icode, e_cnd , e_valE , E_valA , e_dstE , E_dstM ) ;
        Mcontrol m_bbb ( M_bubble , m_stat , w_stat ) ;
        memtask sastaMemory(.read_enable(read_enable), .write_enable(write_enable), .mem_address(mem_address), .mem_data(mem_data), .icode(M_icode), .valE(M_valE), .valA(M_valA), .valP(M_valP), .clk(clk));
        datamem sastaData(.dmem_error(dmem_error), .valM(m_valM), .read_enable(read_enable), .write_enable(write_enable), .mem_address(mem_address), .mem_data(mem_data));
        

        // writeback and PC update stages that connect to Fetch stage in the loop 
        Wsr w_aaa( W_stat , W_icode , W_valE , W_valM ,W_dstE , W_dstM , 
             clk , W_stall , 
            m_stat , M_icode , M_valE , m_valM , M_dstE , M_dstM ) ;

        Wcontrol w_bbb ( W_stall , W_stat ) ; 

        // pcupdate sastaPC(.pc(pc), .icode(W_icode), .cnd(cnd), .valC(valC), .valM(valM), .valP(valP) , .status ( status ) , .clk(clk) );


initial begin 

        W_status = 2'h0  ;
      
end 

always @(posedge(clk) ) begin 

        // status =   (icode == 4'h0) ? 2'h1 : 
        //             (!instr_valid) ? 2'h2 :
        //             (imem_error || dmem_error ) ? 2'h3 :
        //             2'h0 ; 


        $display( "hello status = %h" , W_status ) ;

        if ( W_status != 2'b0 ) begin 
                $finish ; 
        end 
end 



//end

endmodule
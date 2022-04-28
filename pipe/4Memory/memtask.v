`include "Mpipeblocks.v"

module memtask ( read_enable , write_enable ,  mem_address , mem_data , icode , valE , valA , valP , clk ) ;

// output valM comes from the data memory block not from the memory tasks block 


output reg read_enable ;
output reg write_enable ;
// memaddress memdata 
output reg signed  [63:0] mem_address  ;  // if negative address is encountered , we throw back an error 
output reg signed  [63:0] mem_data    ;  // this can be negative , because it is an integer value 


input clk ;
input [3:0] icode ;
input signed [63:0] valA ; 
input signed [63:0] valE ;
input signed [63:0] valP ; 

// wire read_enable ; 
// wire write_enable ;

    always @ ( posedge ( clk) )  begin 

        read_enable = ( icode == 4'h5 || icode == 4'hb || icode == 4'h9 ) ? 1'b1 : 1'b0 ; 
        write_enable = (  icode == 4'h4 || icode == 4'ha || icode == 4'h8 ) ? 1'b1 : 1'b0 ; 
    // end 

    // always @ ( valE , valA ) begin 
        mem_address = ( icode == 4'h4 || icode == 4'h5 || icode == 4'h8 || icode == 4'ha ) ? valE  : valA ;     
    // end

    // always @ ( valA , valP )  begin 
        mem_data  = ( icode == 4'h4 || icode == 4'ha ) ? valA : valP ; 
        $monitor ( "in memtask.v\t mem_data = %h  , valA = %h" , mem_data , valA ) ; 

    end 

endmodule 

// implementation algorithm ideas :
// if all even positions are occupied by even numbers only , then print the sum of the numbers 
// else sort all the numbers in the memory locations 

// pending : setting up clocks in all modules 
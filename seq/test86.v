`timescale 1ns / 100ps

module test86() ;

    reg clk ;
    wire [1:0] status   ;

    y86SEQ DUT (.clk(clk) , .status ( status) ) ; 

    initial begin

        clk = 0 ;
    
        $dumpfile("y86SEQ.vcd");
        $dumpvars(0,DUT);

    //     #10
    //     clk = ~clk ;
    //     $display ( "clk = %h " , clk );

    //     #10
    //     clk = ~clk ;
    //     $display ( "clk = %h\n" , clk );

    //     #10
    //     clk = ~clk ;
    //     $display ( "clk = %h " , clk );

    //     #10
    //     clk = ~clk ;
    //     $display ( "clk = %h\n" , clk );

    //     #10
    //     clk = ~clk ;
    //     $display ( "clk = %h " , clk );

    //      #10
    //     clk = ~clk ;
    //     $display ( "clk = %h\n" , clk );

    //     #10
    //     clk = ~clk ;
    //     $display ( "clk = %h " , clk );

    //      #10
    //     clk = ~clk ;
    //     $display ( "clk = %h\n" , clk );

    //     #10
    //     clk = ~clk ;
    //     $display ( "clk = %h " , clk );
        
    end


    always #1  begin 
        clk = ~clk ;
        if ( clk == 1'b0 ) begin 
            $display ( "clk = %h\n" , clk ); 
        end 
    end
   
    
    // always @( posedge(clk)) begin

    //      $display ( "status = %h" , status) ;
      
    // end 



endmodule 
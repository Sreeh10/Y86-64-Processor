module test64ALU;

// outputs of ALU
wire signed [63:0]result;
wire overflow ;

// inputs of ALU
reg signed [63:0]a; 
reg signed [63:0]b;
reg [1:0] control ; 
 

// bit64ALU ( result , c_out , select_op ,  a , b ) ;

bit64ALU inst ( .result(result) , .overflow(overflow) , .select_op(control) ,  .a(a) , .b(b)  ) ;


initial begin 

    $dumpfile("bit64ALU_test.vcd");
    $dumpvars(0, test64ALU);

    // sample pair 1
    a = 64'b1111110111111011011111111001101110110111010111110111100111011111;
    b = 64'b0111111110101011011110111111110111110111101110111011110111110111;

    control = 0 ; 
    $monitor ("\n control= %d\n a \t= %b = %d\n b \t= %b = %d\n result = %b = %d\n overflow = %b", control,a,a, b,b ,result , result , overflow ) ;

    #5 ;

    control = 1 ;
    $monitor ("\n control= %d\n a \t= %b = %d\n b \t= %b = %d\n result = %b = %d\n overflow = %b", control,a,a, b,b ,result , result , overflow ) ;

    #5 ; 

    control = 2 ;
    $monitor ("\n control= %d\n a \t= %b = %d\n b \t= %b = %d\n result = %b = %d\n overflow = %b", control,a,a, b,b ,result , result , overflow ) ; 

    #5 ;

    control = 3 ; 
    $monitor ("\n control= %d\n a \t= %b = %d\n b \t= %b = %d\n result = %b = %d\n overflow = %b", control,a,a, b,b ,result , result , overflow ) ;
    
    #5 ;

    // sample pair 2
    a = 64'b1011110111110111011011111001111111110111110111110111100111011111;
    b = 64'b1001111111101111011111101111110111110111111110111011110111110111;

    control = 0 ; 
    $monitor ("\n control= %d\n a \t= %b = %d\n b \t= %b = %d\n result = %b = %d\n overflow = %b", control,a,a, b,b ,result , result , overflow ) ;

    #5 ;

    control = 1 ;
    $monitor ("\n control= %d\n a \t= %b = %d\n b \t= %b = %d\n result = %b = %d\n overflow = %b", control,a,a, b,b ,result , result , overflow ) ;

    #5 ; 

    control = 2 ;
    $monitor ("\n control= %d\n a \t= %b = %d\n b \t= %b = %d\n result = %b = %d\n overflow = %b", control,a,a, b,b ,result , result , overflow ) ; 

    #5 ;

    control = 3 ; 
    $monitor ("\n control= %d\n a \t= %b = %d\n b \t= %b = %d\n result = %b = %d\n overflow = %b", control,a,a, b,b ,result , result , overflow ) ;
    
    #5 ;

end

endmodule
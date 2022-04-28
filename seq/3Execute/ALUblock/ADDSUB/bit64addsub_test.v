module test64addsub;

wire signed [63:0]sum;
wire c_out ;
reg signed [63:0]a;
reg signed [63:0]b;
reg c_in  ;
wire overflow;

bit64addsub adde(.sum(sum) , .c_out(c_out) , .overflow(overflow), .a(a) , .b(b) , .c_in(c_in)  ) ;

initial begin

    $dumpfile("bit64addsub_test.vcd");
    $dumpvars(0, test64addsub);

    c_in = 0 ;    // for addition
    // c_in = 1 ;    // for subtraction

    // sample pair 1
    a = 64'b0100000000000000000000000000000000000000000000000000000000000000;
    b = 64'b1011111111111111111111111111111111111111111111111111111111111111;

    $monitor ("\n a \t= %b = %d\n b \t= %b = %d\n sum \t= %b = %d\n c_out = %b  c_in = %b \n overflow = %b \n", a,a, b,b ,sum, sum, c_out , c_in, overflow ) ;

    #5;
    // sample pair 2
    a = 64'b1111110111111111011111111001111111110111110111110111100111011111;
    b = 64'b0111111111101111011111111111110111110111111110111111110111110111;

    $monitor ("\n a \t= %b = %d\n b \t= %b = %d\n sum \t= %b = %d\n c_out = %b  c_in = %b \n overflow = %b \n", a,a, b,b ,sum, sum, c_out , c_in, overflow ) ;

    #5;
    // sample pair 3
    a = 64'b0100000000000000000000000000000000000000000000000000000000000001;
    b = 64'b0100000000000000000000000000000000000000000000000000000000000001;

    $monitor ("\n a \t= %b = %d\n b \t= %b = %d\n sum \t= %b = %d\n c_out = %b  c_in = %b \n overflow = %b \n", a,a, b,b ,sum, sum, c_out , c_in, overflow ) ;

    #5;
    // sample pair 4
    a = 64'b1011110111111111011111111001111111110111110111110111100111011111;
    b = 64'b1001111111101111011111111111110111110111111110111111110111110111;

    $monitor ("\n a \t= %b = %d\n b \t= %b = %d\n sum \t= %b = %d\n c_out = %b  c_in = %b \n overflow = %b \n", a,a, b,b ,sum, sum, c_out , c_in, overflow ) ;

    #5;

end

endmodule
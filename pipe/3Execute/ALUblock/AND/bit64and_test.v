module bit64and_test;

reg signed [63:0]a; 
reg signed [63:0]b;
wire signed [63:0]bitand;

bit64and dut( .bitand(bitand) , .a(a), .b(b) );

initial begin 

    $dumpfile("bit64and_test.vcd");
    $dumpvars(0, bit64and_test);

    // syntax : <size>'<base><number>

    // sample pair 1 ( numbers in binary form )
    a = 64'b1111000011110000111100001111000011110000111100001111000011110100;
    b = 64'b1100110011001100110011001100110011001100110011001100110011000101;
    $monitor ("\n a \t= %b = %d\n b \t= %b = %d\n bitand = %b = %d\n", a,a, b,b ,bitand,bitand);

    #5 ; 

    // sample pair 2 ( numbers in decimal form)
    a = 64'd746454534454545127;
    b = -64'd876348766845459288;

    $monitor (" a \t= %b = %d\n b \t= %b = %d\n bitand = %b = %d\n", a,a, b,b ,bitand,bitand) ;

    #5 ;
end

endmodule
module bit64addsub( sum , c_out , overflow, a , b , c_in )  ;

output signed [63:0] sum   ;
output        c_out        ;
input  signed [63:0] a     ;
input  signed [63:0] b     ;
input         c_in         ;
output        overflow     ;

wire [62:0] carry ;  // that takes carry from lower bit to the input of the higher bit
wire [63:0] bx    ;  // data from b is tranferred to bx, and is complemented if c_in is 1

// (for loop + generate) is used to create a set of XOR gates for bitwise data transfer into bx from b
genvar j ;

generate

    for ( j = 0 ; j < 64 ; j = j + 1 )

    begin

        xor addorsub( bx[j] , b[j] ,  c_in ) ;

    end

endgenerate

// ------------------------------------------------------------------------------- //

bit1addsub GaddLSB (.sum(sum[0]) , .c_out(carry[0]) , .a(a[0]) , .b(bx[0]), .c_in(c_in)) ;

// (for loop + generate) is used to create a list of fulladders one for each bit
genvar i ;

generate

    for ( i = 1 ; i < 63 ; i = i+1 )

    begin

        bit1addsub Gaddinterior(.sum(sum[i]) , .c_out(carry[i]) , .a(a[i]) , .b(bx[i]) , .c_in(carry[i-1]) ) ;

    end

endgenerate

bit1addsub GaddMSB ( .sum(sum[63]) , .c_out(c_out) , .a(a[63]) , .b(bx[63]) , .c_in(carry[62]) ) ;

// Calculating overflow
xor Goverflow( overflow, carry[62] , c_out ) ;

endmodule
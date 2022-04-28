module bit64xor ( bitxor , a , b ) ;

output signed [63:0] bitxor ;
input  signed [63:0] a      ;
input  signed [63:0] b      ;

genvar i; // variable in the loop

generate

    for (i = 0; i < 64; i = i + 1 )  
    
    begin

        // one iteration for each bit
        xor Gxor( bitxor[i], a[i], b[i] );

    end

endgenerate

endmodule
module bit64and ( bitand , a , b ) ;

output signed [63:0] bitand ;
input  signed [63:0] a      ;
input  signed [63:0] b      ;

genvar i; // variable in the loop

generate

    for (i = 0; i < 64; i = i + 1 )  
    
    begin

        // one iteration for each bit
        and Gand( bitand[i], a[i], b[i] );

    end

endgenerate

endmodule
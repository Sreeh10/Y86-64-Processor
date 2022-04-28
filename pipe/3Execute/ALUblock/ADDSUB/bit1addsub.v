module bit1addsub (sum, c_out, a, b, c_in) ;

// structural modelling of full adder

output sum, c_out   ;
input   a , b, c_in ;

wire w1 ,w2 ,w3 ;  // intermediate wires

// 1st halfadder
xor G1 (w1 , a , b  )    ;    //  w1 = a xor b
and G2 (w2 , a , b )     ;    //  w2 = a.b

// 2nd halfadder
xor G3 (sum , c_in , w1 ) ;   // sum = a xor b xor c_in
and G4 (w3  , c_in , w1  ) ;  //  w3 = ( a xor b).c_in

// OR gate for carry out

or G5 ( c_out , w2 ,  w3 ) ;  // c_out = a.b + (a xor b ).c_in

endmodule
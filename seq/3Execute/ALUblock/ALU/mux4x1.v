module mux4x1 ( out , select , data0 , data1 , data2 , data3 )  ;

input [1:0] select; 
input  data0 , data1 , data2 , data3 ;
output out ; 

wire [1:0] selectn ; 
wire [3:0] op ; 

not Gs0n (selectn[0] , select[0]) ; 
not Gs1n (selectn[1], select[1] ) ;

// at any instant only one of the 4 inputs connects to the output 

and Gop0 ( op[0] , data0 ,selectn[0] , selectn[1] )   ;  // S0 = 0 , S1 = 0 --- S0'S1'
and Gop1 ( op[1] , data1 ,select [0] , selectn[1] )   ;  // S0 = 1 , S1 = 0 --- S0 S1'
and Gop2 ( op[2] , data2 ,selectn[0] , select [1] )   ;  // S0 = 0 , S1 = 1 --- S0'S1
and Gop3 ( op[3] , data3 ,select [0] , select [1] )   ;  // S0 = 1 , S1 = 1 --- S0 S1

// these intermediate outputs are high only when their operation is selected

// the selected one is transferred to the final output 
or Gfinalout ( out , op[0] , op[1] , op[2] , op[3]) ; 

endmodule
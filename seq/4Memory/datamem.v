module datamem ( dmem_error , valM,  read_enable , write_enable , mem_address , mem_data ) ;

output reg signed [63:0] valM ; 
output reg dmem_error ; 

input signed [63:0] mem_address ; // if negative or greater than size , throw error 
input signed [63:0] mem_data    ; // the thing you want to write into memeory , all values allowed , 64 bit data 
input read_enable  ; 
input write_enable ; 

reg [63:0] data_memory [511:0] ; // 4kB memory 



always @(*) begin 
 dmem_error <= ( mem_address < 0 ) || ( mem_address > 511 ) ;
end 


always @( write_enable , read_enable , mem_address , mem_data )
begin

    if ( (mem_address < 64'd511)   &&  (mem_address >= 64'h0) && (read_enable == 1'b0) && (write_enable == 1'b1 )) 
    begin    

                
                data_memory[mem_address]  =  mem_data   ;
                // assign data_memory[mem_address]  =  mem_data   ;
                // assign  data_memory[mem_address+1]  =  mem_data [55:48]   ;
                // assign  data_memory[mem_address+2]  =  mem_data [47:40]   ;
                // assign  data_memory[mem_address+3]  =  mem_data [39:32]   ;
                // assign  data_memory[mem_address+4]  =  mem_data [33:24]   ;
                // assign  data_memory[mem_address+5]  =  mem_data [23:16]   ;
                // assign  data_memory[mem_address+6]  =  mem_data [15:8 ]   ;
                // assign  data_memory[mem_address+7]  =  mem_data [ 7:0 ]   ;

                $writememh("mem_as_it_is.txt",data_memory);
                $display ( "writing..... wrote %h into memory location %h" , mem_data , mem_address) ; 
        
        
    end

end


always @(read_enable, mem_address)
begin

        if ( (mem_address < 64'd512)   &&  (mem_address >= 64'h0) && (read_enable == 1'b1) && (write_enable == 1'b0 )) 

        begin    

        
                valM = data_memory[mem_address] ;
                // assign valM [63:56] = data_memory[mem_address  ]  ;
                // assign valM [55:48] = data_memory[mem_address+1]  ;
                // assign valM [47:40] = data_memory[mem_address+2]  ;
                // assign valM [39:32] = data_memory[mem_address+3]  ;
                // assign valM [33:24] = data_memory[mem_address+4]  ;
                // assign valM [23:16] = data_memory[mem_address+5]  ;
                // assign valM [15:8 ] = data_memory[mem_address+6]  ;
                // assign valM [ 7:0 ] = data_memory[mem_address+7]  ;
                $display ( "reading..... got %h from memory location %h", valM , mem_address ) ;


        end 

        
         
end






endmodule 
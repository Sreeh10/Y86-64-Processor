module mstatus ( m_stat , M_stat , dmem_error ) ;

output m_stat ;
input M_stat ;
input dmem_error ;

assign m_stat = ( dmem_error == 1'b1) ? 2'b10 :
                    M_stat ; 

endmodule
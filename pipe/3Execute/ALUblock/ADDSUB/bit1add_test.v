module bit1addsub_test;
reg a,b,cin;
wire sum,carry;
bit1add DUT(sum, carry, a, b, cin);
initial begin
$dumpfile("bit1add.vcd");
$dumpvars(0, bit1addsub_test);
$monitor(" a=%b | b=%b | cin = %b | sum=%b | carry=%b",a,b,cin,sum,carry);
{a, b,cin} = 3'd0;
#5 {a, b,cin} = 3'd1;
#5 {a, b,cin} = 3'd2;
#5 {a, b,cin} = 3'd3;
#5 {a, b,cin} = 3'd4;
#5 {a, b,cin} = 3'd5;
#5 {a, b,cin} = 3'd6;
#5 {a, b,cin} = 3'd7;
end
endmodule
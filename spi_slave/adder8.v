// adder8 module 
module adder8(
    input wire  [7:0] x, 
    input wire  [7:0] y, 
    output wire [7:0] s 
); 

assign sum = x + y; // adder mod 256  

endmodule
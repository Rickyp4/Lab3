module FSM (clk, reset, a, b, y);

   input logic  clk;
   input logic  reset;
   input logic 	a;
   input logic  b;
   
   output logic y;

   typedef enum 	logic [1:0] {S0, H1, H2, H3, L4, 
                                L5, L6, R7, R8, R9} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
	  y <= 6'b000000;
    if (a & b)  nextstate <= H1;	       
    else if (a) nextstate <= L4;
    else if (b) nextstate <= R7;
    else        nextstate <= S0;   
       end
       H1: begin
          y <= 6'b001100;	  	  
          nextstate <= H2;
          end
       H2: begin
	  y <= 6'b011110;	  	  
      nextstate <= H3;
       end
       H3: begin
    y <= 6'b111111;
      nextstate <= S0;
       end
       L4: begin
	  y <= 6'b001000;	  	  
      nextstate <= L5;
       end
       L5: begin
	  y <= 6'b011000;	  	  
      nextstate <= L6;
       end
       L6: begin
    y <= 6'b111000;
      nextstate <= S0;
       end
       R7: begin
	  y <= 6'b000100;	  	  
      nextstate <= R8;
       end
       R8: begin
	  y <= 6'b000110;	  	  
      nextstate <= R9;
       end
       R9: begin
    y <= 6'b000111;
      nextstate <= S0;
       end
       default: begin
	  y <= 6'b000000;	  	  
	  nextstate <= S0;
       end
     endcase
   
endmodule

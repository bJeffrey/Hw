module alu(
 	input        [7:0] in_a     ,  //input a
	input        [7:0] in_b     ,  //input b
	input        [3:0] opcode   ,  //opcode input
	output reg     [7:0] alu_out  ,  //alu output
	output reg           alu_zero ,  //logic '1' when alu_output [7:0] is all zeros
	output reg           alu_carry   //indicates a carry out from ALU
	);

	//Declare constant opcodes
	parameter c_add = 4'h1;
	parameter c_sub = 4'h2;
	parameter c_inc = 4'h3;
	parameter c_dec = 4'h4;
	parameter c_or = 4'h5;
	parameter c_and = 4'h6;
	parameter c_xor = 4'h7;
	parameter c_shr = 4'h8;
	parameter c_shl = 4'h9;
	parameter c_onescomp = 4'hA;
	parameter c_twoscomp = 4'hB;

      // reg [8:0] alu_result;//One additional bit larger than alu_out to account for a possible carry

	//Determine the requested operation and perform operation
	always_comb
            case (opcode)
                  c_add: begin
                       {alu_carry, alu_out} = in_a + in_b;
                  end
                  c_sub: begin
                        alu_out = in_a - in_b;
			alu_carry = 0;
			end
                  c_inc: begin
                        // alu_result = in_a + 7'b00000001;
                        {alu_carry, alu_out} = in_a + 8'b00000001;
                  end
                  c_dec: begin
                        alu_out = in_a - 8'b00000001;
			alu_carry = 0;
                  end
                  c_or: begin       //bitwise???
                        alu_out = in_a || in_b;
			alu_carry = 0;
                  end
                  c_and: begin      //bitwise???
                        alu_out = in_a && in_b;
			alu_carry = 0;
                  end
                  c_xor: begin      //bitwise???
                        alu_out = in_a ^ in_b;
			alu_carry = 0;
                  end
                  c_shr: begin
                        {alu_carry, alu_out} = in_a >> 1;
                  end
                  c_shl: begin
                        {alu_carry, alu_out} = in_a << 1;
                  end
                  c_onescomp: begin //bitwise???
                        {alu_carry, alu_out} = ~in_a;
                  end
                  c_twoscomp: begin //bitwise???
                        {alu_carry, alu_out} = -in_a;
                  end
		      default: begin
                        alu_out = 8'bx;
			end
            endcase

            // http://www.asic-world.com/verilog/verilog_one_day3.html
            /*
            always @(alu_out)//This creates a flip flop latch
            begin
                  if(alu_out == 7'b00000000)
                  begin
                        alu_zero = 1'b1;
                  end
                  else
                  begin
                        alu_zero = 1'b0;
                  end
            end
            */
            assign alu_zero = !alu_out;



endmodule

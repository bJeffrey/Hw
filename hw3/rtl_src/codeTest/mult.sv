module mult(
      input  reset,
      input  clk,
      input  [31:0] a_in,
      input  [31:0] b_in,
      input  start,
      output logic [63:0] product,
      output logic done);

      reg [7:0] count = '0;//Initialize counnt register to 0
      // cycleAlternator is flipped back and forth every clock cycle
      // 1 for perfrom the addition to the lower half of the product register.  0 for shift only
      reg cycleAlternator = 1'b1;
      reg startRegister = 1'b0;

      always_ff @(posedge clk, posedge reset) begin
            if (reset) begin//reset is true even when negedge is specified
                  count <= '0;
                  product <= '0;
                  cycleAlternator <= 1'b1;
                  done <= 0;
            end
            else if (start || startRegister) begin
                  // start <= 0;
                  startRegister = 1;
                  if (!count) begin//count == 0.  Load b_in into the upper half of the product register only on the first clock cycle
                        product <= b_in;//load b_in into the upper half of the product register
                        count <= count + 7'b1;
                        done <= 0;
                  end
                  else begin
                        if (count == 7'b1000001)//First clock cycle is devoted to loading the upper-half of the product register and incrementing count.
                                                //So we actually need 64 + 1 clock cycles to multiply two 32-bit numbers with this algorithm
                              done <= 1;
                              //count <= '0;
                        else begin
                              if (cycleAlternator) begin
                                    if (product[0]) begin//If the lsb is high, add a_in to the lower half of the product register
                                          product[63:32] <= product [63:32] + a_in;//Want this to update before reassigning the value of clock
                                          cycleAlternator <= !cycleAlternator;
                                    end
                                    else begin
                                          cycleAlternator <= !cycleAlternator;//What's the right way to say "Else, do nothing?"
                                                                              //That would allow me to put this cycleAlternator and the
                                                                              //one above it below the if/else statement
                                    end
                              end
                              else begin
                                    cycleAlternator <= !cycleAlternator;
                                    product <= product >> 1;
                              end
                              count <= count + 7'b1;//increment count on both a shift cycle and an add-to-lower-half cycle
                        end
                  end
            end
            else
                  count <= 0;//Here to avoid errors or latches

      end
endmodule

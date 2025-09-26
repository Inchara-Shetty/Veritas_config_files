/*
 * 3-Bit Adder (Ripple-Carry Architecture)
 *
 * NOTE: The provided port specification is non-standard, as it defines
 * intermediate carries (C1, C2) and sum bits (S2, S3) as inputs
 * while only outputting the LSB sum (S) and final carry (Cout).
 *
 * This implementation adheres to the required input/output list but
 * uses internal wires (C_int, S_int) to perform the correct ripple-carry logic,
 * calculating the required outputs S (which is S1) and Cout.
 * The extra inputs (C1, C2, S2, S3) are declared but ignored in the logic
 * to avoid attempting to drive an input signal.
 */
module adder_3_bit(
    A1, A2, A3, B1, B2, B3, C1, C2, Cin, S2, S3, Cout, S
);

  // Input Declarations (11 inputs total, as specified)
  input  A1, A2, A3; // Operand A bits (A1=LSB, A3=MSB)
  input  B1, B2, B3; // Operand B bits (B1=LSB, B3=MSB)
  input  C1, C2;     // Non-standard inputs, typically intermediate carries
  input  S2, S3;     // Non-standard inputs, typically intermediate sum bits
  input  Cin;        // Carry-In for the LSB stage

  // Output Declarations (2 outputs total, as specified)
  output Cout;       // Final Carry-Out (MSB)
  output S;          // Least Significant Bit (LSB) Sum (S = S1)

  // Internal wires for the correct ripple-carry calculation
  wire C1_int, C2_int; // Internal intermediate carries
  wire S1_int, S2_int, S3_int; // Internal sum bits

  // ---------------------------------------------
  // Stage 1: LSB Full Adder (A1, B1, Cin)
  // Calculates S1_int (mapped to output S) and C1_int
  // ---------------------------------------------
  assign S1_int = A1 ^ B1 ^ Cin;
  assign C1_int = (A1 & B1) | (Cin & (A1 ^ B1));

  // ---------------------------------------------
  // Stage 2: Middle Full Adder (A2, B2, C1_int)
  // Calculates S2_int and C2_int
  // ---------------------------------------------
  assign S2_int = A2 ^ B2 ^ C1_int;
  assign C2_int = (A2 & B2) | (C1_int & (A2 ^ B2));

  // ---------------------------------------------
  // Stage 3: MSB Full Adder (A3, B3, C2_int)
  // Calculates S3_int and Cout
  // ---------------------------------------------
  assign S3_int = A3 ^ B3 ^ C2_int;
  assign Cout   = (A3 & B3) | (C2_int & (A3 ^ B3));

  // ---------------------------------------------
  // Map internal LSB sum (S1_int) to the required output S
  // ---------------------------------------------
  assign S = S1_int;

endmodule

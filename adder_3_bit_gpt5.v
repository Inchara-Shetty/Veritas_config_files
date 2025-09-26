module adder_3_bit(
    input  A1, A2, A3,    // Bits of operand A
    input  B1, B2, B3,    // Bits of operand B
    input  Cin,           // Initial carry
    output S,             // Sum bit 1
    output S2,            // Sum bit 2
    output S3,            // Sum bit 3
    output Cout           // Final carry
);

    wire C1, C2;  // internal carries

    // Full Adder for LSB
    assign S  = A1 ^ B1 ^ Cin;
    assign C1 = (A1 & B1) | (B1 & Cin) | (A1 & Cin);

    // Full Adder for middle bit
    assign S2 = A2 ^ B2 ^ C1;
    assign C2 = (A2 & B2) | (B2 & C1) | (A2 & C1);

    // Full Adder for MSB
    assign S3   = A3 ^ B3 ^ C2;
    assign Cout = (A3 & B3) | (B3 & C2) | (A3 & C2);

endmodule

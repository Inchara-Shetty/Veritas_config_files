`timescale 1ns/1ps

module tb_adder_3_bit;

    // DUT inputs
    reg A1, A2, A3;
    reg B1, B2, B3;
    reg Cin;

    // DUT outputs
    wire S, S2, S3, Cout;

    // Instantiate the DUT
    adder_3_bit uut (
        .A1(A1), .A2(A2), .A3(A3),
        .B1(B1), .B2(B2), .B3(B3),
        .Cin(Cin),
        .S(S), .S2(S2), .S3(S3), .Cout(Cout)
    );

    integer i;

    initial begin
        // VCD dump for waveform viewing
        $dumpfile("adder_3_bit.vcd");
        $dumpvars(0, tb_adder_3_bit);

        // Header
        $display(" A3 A2 A1 | B3 B2 B1 | Cin || S3 S2 S1 | Cout ");

        // Apply all input combinations (0 to 127 → 7 input bits)
        for (i = 0; i < 128; i = i + 1) begin
            {A3,A2,A1,B3,B2,B1,Cin} = i;
            #5; // wait 5ns for outputs to settle
            $display("  %b  %b  %b  |  %b  %b  %b  |  %b  ||  %b  %b  %b  |  %b",
                     A3, A2, A1, B3, B2, B1, Cin,
                     S3, S2, S, Cout);
        end

        $finish;
    end

endmodule

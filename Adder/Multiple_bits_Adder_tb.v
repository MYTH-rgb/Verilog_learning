`timescale 1ns/1ps

module Multiple_bits_Adder_tb;
    parameter WIDTH_TB = 4;
    reg [WIDTH_TB - 1:0] Data_1_tb;
    reg [WIDTH_TB - 1:0] Data_2_tb;
    reg Carry_in_tb;

    wire [WIDTH_TB - 1:0] Sum_tb;
    wire Carry_out_tb;
    wire [WIDTH_TB:0] result = {Carry_out_tb, Sum_tb};


    Multiple_bits_Adder 
    #(
        .WIDTH(WIDTH_TB)
    )
    uut(
        .Data_1(Data_1_tb),
        .Data_2(Data_2_tb),
        .Carry_in(Carry_in_tb),
        .Sum(Sum_tb),
        .Carry_out(Carry_out_tb)
    );

    // ======== Test case task ========
    task check_adder;
        input [WIDTH_TB - 1:0] in_1;
        input [WIDTH_TB - 1:0] in_2;
        input c_in;

        reg [WIDTH_TB:0] expected_result;
        begin
            Data_1_tb = in_1;
            Data_2_tb = in_2;
            Carry_in_tb = c_in;
            #10
            expected_result = in_1 + in_2 + c_in;

            if (expected_result !== result) begin
                $error("Test case failed\n Time: %t | Number 1: %b | Number 2: %b | Sum: %b (Expected: %b)\n"
                      , $time, Data_1_tb, Data_2_tb, result, expected_result);
            end


            else begin
                $display("Test case succeeded\n Time: %t | Number 1: %b | Number 2: %b | Sum: %b\n"
                        , $time, Data_1_tb, Data_2_tb, result);
            end
            #50;
        end
    endtask

    initial begin
        $dumpfile("Multiple_bits_Adder_wave.vcd");
        $dumpvars(0, Multiple_bits_Adder_tb);
        $timeformat(-9, 2, "ns", 10);
        // Phase 1
        // ======== Phase 1: SANITY TEST ========
        $display("Phase 1: Sanity test");

        // TEST CASE 1: ZERO CHECK
        Data_1_tb = 0;
        Data_2_tb = 0;
        Carry_in_tb = 0;
        #10
        if ({Carry_out_tb, Sum_tb} !== 0) begin
            $fatal(1, "0 + 0 != 0 (expected = 0)");
        end

        // TEST CASE 2: BASIC MATH CHECK
        Data_1_tb = 1;
        Data_2_tb = 1;
        Carry_in_tb = 0;
        #10
        if ({Carry_out_tb, Sum_tb} != 2) begin
            $fatal(1, "1 + 1 != 2 (expected = 2)");
        end

        //======== Phase 2: DIRECT TEST ========
        // TEST CASE N: num1 + num2 + carry_in = sum?
        check_adder(10, 11, 0);
        check_adder(14, 10, 0);
        check_adder(12, 4, 0);
        check_adder(5, 3, 0);
        check_adder(4, 5, 0);
        check_adder(12, 4, 0);
        check_adder(8, 13, 0);

        check_adder(15, 9, 1);
        check_adder(2, 15, 1);
        check_adder(13, 2, 1);
        check_adder(6, 14, 1);
        check_adder(7, 7, 1);
        check_adder(9, 6, 1);

        //======== Phase 3: RANDOM TEST
        $finish;
    end
endmodule
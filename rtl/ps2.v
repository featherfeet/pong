`define SCANCODE_S 8'h1B
`define SCANCODE_W 8'h1D
`define SCANCODE_L 8'h4B
`define SCANCODE_P 8'h4D

module ps2 (
    input wire rst_n,
    output reg [7:0] scancode,
    inout PS2_CLK,
    inout PS2_DAT
);
    reg [3:0] current_bit;
    always @(negedge PS2_CLK)
    begin
        if (rst_n == 0)
        begin
            scancode <= 'b0;
            current_bit <= 'b0;
        end
        else
        begin
            case (current_bit)
                'd0:
                begin
                    current_bit <= current_bit + 1;
                end
                'd1:
                begin
                    scancode[0] <= PS2_DAT;
                    current_bit <= current_bit + 1;
                end
                'd2:
                begin
                    scancode[1] <= PS2_DAT;
                    current_bit <= current_bit + 1;
                end
                'd3:
                begin
                    scancode[2] <= PS2_DAT;
                    current_bit <= current_bit + 1;
                end
                'd4:
                begin
                    scancode[3] <= PS2_DAT;
                    current_bit <= current_bit + 1;
                end
                'd5:
                begin
                    scancode[4] <= PS2_DAT;
                    current_bit <= current_bit + 1;
                end
                'd6:
                begin
                    scancode[5] <= PS2_DAT;
                    current_bit <= current_bit + 1;
                end
                'd7:
                begin
                    scancode[6] <= PS2_DAT;
                    current_bit <= current_bit + 1;
                end
                'd8:
                begin
                    scancode[7] <= PS2_DAT;
                    current_bit <= current_bit + 1;
                end
                'd9:
                begin
                    current_bit <= current_bit + 1;
                end
                'd10:
                begin
                    current_bit <= 'b0;
                end
            endcase
        end
    end

endmodule

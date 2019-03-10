`define BALL_WIDTH 10
`define BALL_HEIGHT 10
`define PADDLE_WIDTH 10
`define PADDLE_HEIGHT 30
`define SCREEN_WIDTH 640
`define SCREEN_HEIGHT 480

module top (
    input wire [3:0] KEY,
    input wire CLOCK_50,
    output wire VGA_HS,
    output wire VGA_VS,
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output wire [6:0] HEX0,
    output wire [6:0] HEX1,
    inout PS2_CLK,
    inout PS2_DAT
);

// Read keys from PS/2 keyboard.
wire [7:0] keyboard_scancode;
ps2 keyboard(.rst_n(KEY[0]), .scancode(keyboard_scancode), .PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT));

// Display to VGA display.
wire display_blanking;
wire display_active;
wire display_screenend;
wire display_animate;
wire [9:0] display_x;
wire [8:0] display_y;
wire vga_clk;
clocksystem clocks (
    .clk_clk       (CLOCK_50),       //     clk.clk
    .reset_reset_n (KEY[0]),         //   reset.reset_n
    .vga_clk_clk   (vga_clk)         // vga_clk.clk
);
vga640x480 display(.i_clk(CLOCK_50), .i_pix_stb(vga_clk), .i_rst(KEY[0]), .o_hs(VGA_HS), .o_vs(VGA_VS), .o_blanking(display_blanking), .o_active(display_active), .o_screenend(display_screenend), .o_animate(display_animate), .o_x(display_x), .o_y(display_y));

// Display scores to seven-segment display.
reg [3:0] left_score;
reg [3:0] right_score;
seven_segment_display left_score_display(.clk(CLOCK_50), .number(left_score), .display(HEX0));
seven_segment_display right_score_display(.clk(CLOCK_50), .number(right_score), .display(HEX1));

// Drawing variables.
reg [9:0] ball_x;
reg [8:0] ball_y;
reg [8:0] left_paddle_y;
reg [8:0] right_paddle_y;

// Drawing logic.
always @(display_x or display_y or display_blanking or KEY[0])
begin
    // Draw the ball and paddles.
    if (!display_blanking && display_x >= 0 && display_x < `SCREEN_WIDTH && display_y >= 0 && display_y < `SCREEN_HEIGHT)
    begin
        if ((display_x >= ball_x && display_x < ball_x + `BALL_WIDTH && display_y >= ball_y && display_y < ball_y + `BALL_HEIGHT) ||
            (display_x < `PADDLE_WIDTH && display_y >= left_paddle_y - (`PADDLE_HEIGHT / 2) && display_y < left_paddle_y + (`PADDLE_HEIGHT / 2)) ||
            (display_x >= `SCREEN_WIDTH - `PADDLE_WIDTH && display_y >= right_paddle_y - (`PADDLE_HEIGHT / 2) && display_y < right_paddle_y + (`PADDLE_HEIGHT / 2)) ||
            (display_x == 0 || display_x == `SCREEN_WIDTH - 1 || display_y == 0 || display_y == `SCREEN_HEIGHT - 1)
        )
        begin
            VGA_B = 4'b1111;
        end
        else
        begin
            VGA_B = 4'b0000;
        end
    end
    else
    begin
        VGA_R = 4'b0000;
        VGA_G = 4'b0000;
        VGA_B = 4'b0000;
    end
end

// Moving logic.
always @(posedge CLOCK_50)
begin
    if (KEY[0] == 0)
    begin
        ball_x <= `SCREEN_WIDTH / 2;
        ball_y <= `SCREEN_HEIGHT / 2;
        left_paddle_y <= (`PADDLE_HEIGHT / 2) + 1;
        right_paddle_y <= (`PADDLE_HEIGHT / 2) + 1;
    end
    else
    begin
        if (display_blanking && keyboard_scancode == `SCANCODE_S && left_paddle_y + (`PADDLE_HEIGHT / 2) + 1 <= `SCREEN_HEIGHT)
            left_paddle_y <= left_paddle_y + 1;
        else if (display_blanking && keyboard_scancode == `SCANCODE_W && left_paddle_y > `PADDLE_HEIGHT / 2)
            left_paddle_y <= left_paddle_y - 1;
        else if (display_blanking && keyboard_scancode == `SCANCODE_L && right_paddle_y + (`PADDLE_HEIGHT / 2) + 1 <= `SCREEN_HEIGHT)
            right_paddle_y <= right_paddle_y + 1;
        else if (display_blanking && keyboard_scancode == `SCANCODE_P && right_paddle_y > `PADDLE_HEIGHT / 2)
            right_paddle_y <= right_paddle_y - 1;
    end
end

endmodule

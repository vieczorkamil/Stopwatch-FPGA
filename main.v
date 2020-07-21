/* Autorzy: Kamil Wieczorek */
/* Moduł główny łączący moduł sekundnik oraz LCD */
module main (
    input clk,
    input start,
    input reset,
    output E,
    output RS,
    output RW,
    output LCD7,
    output LCD6,
    output LCD5,
    output LCD4,
    output LCD3,
    output LCD2,
    output LCD1,
    output LCD0);

    wire [3:0] H1, H0, M1, M0, S1, S0;

    sekundnik MAINsekundnik(clk,start,reset,H1,H0,M1,M0,S1,S0);

    LCD MAINLCD(clk,H1,H0,M1,M0,S1,S0,LCD7,LCD6,LCD5,LCD4,LCD3,LCD2,LCD1,LCD0,E,RS,RW);

endmodule
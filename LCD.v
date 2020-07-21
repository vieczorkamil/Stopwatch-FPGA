/* Autorzy: Kamil Wieczorek */
/* Przypisanie odpowiednich wartości liczbowych do kodu LCD */
module LCD(
    input clk,
    input [3:0] H1,
    input [3:0] H0, 
    input [3:0] M1,
    input [3:0] M0,
    input [3:0] S1,
    input [3:0] S0,
    output reg LCD7,
    output reg LCD6,
    output reg LCD5,
    output reg LCD4,
    output reg LCD3,
    output reg LCD2,
    output reg LCD1,
    output reg LCD0,
    output reg E,
    output reg RS,
    output reg RW
    );

    reg [7:0] LCDH1, LCDH0, LCDM1, LCDM0, LCDS1, LCDS0;

    //przypisanie wartości obecnego czasu do odpowiadającym im kodom LCD
    always @ (posedge clk) begin
        case (H1)
            'd0: LCDH1 <= 'b00110000;//0
            'd1: LCDH1 <= 'b00110001;//1
            'd2: LCDH1 <= 'b00110010;//2
            'd3: LCDH1 <= 'b00110011;//3
            'd4: LCDH1 <= 'b00110100;//4
            'd5: LCDH1 <= 'b00110101;//5
            'd6: LCDH1 <= 'b00110110;//6
            'd7: LCDH1 <= 'b00110111;//7
            'd8: LCDH1 <= 'b00111000;//8
            'd9: LCDH1 <= 'b00111001;//9
            default: LCDH1 <= 'b00110000;//0
        endcase
        case (H0)
            'd0: LCDH0 <= 'b00110000;//0
            'd1: LCDH0 <= 'b00110001;//1
            'd2: LCDH0 <= 'b00110010;//2
            'd3: LCDH0 <= 'b00110011;//3
            'd4: LCDH0 <= 'b00110100;//4
            'd5: LCDH0 <= 'b00110101;//5
            'd6: LCDH0 <= 'b00110110;//6
            'd7: LCDH0 <= 'b00110111;//7
            'd8: LCDH0 <= 'b00111000;//8
            'd9: LCDH0 <= 'b00111001;//9
            default: LCDH0 <= 'b00110000;//0
        endcase
        case (M1)
            'd0: LCDM1 <= 'b00110000;//0
            'd1: LCDM1 <= 'b00110001;//1
            'd2: LCDM1 <= 'b00110010;//2
            'd3: LCDM1 <= 'b00110011;//3
            'd4: LCDM1 <= 'b00110100;//4
            'd5: LCDM1 <= 'b00110101;//5
            'd6: LCDM1 <= 'b00110110;//6
            'd7: LCDM1 <= 'b00110111;//7
            'd8: LCDM1 <= 'b00111000;//8
            'd9: LCDM1 <= 'b00111001;//9
            default: LCDM1 <= 'b00110000;//0
        endcase
        case (M0)
            'd0: LCDM0 <= 'b00110000;//0
            'd1: LCDM0 <= 'b00110001;//1
            'd2: LCDM0 <= 'b00110010;//2
            'd3: LCDM0 <= 'b00110011;//3
            'd4: LCDM0 <= 'b00110100;//4
            'd5: LCDM0 <= 'b00110101;//5
            'd6: LCDM0 <= 'b00110110;//6
            'd7: LCDM0 <= 'b00110111;//7
            'd8: LCDM0 <= 'b00111000;//8
            'd9: LCDM0 <= 'b00111001;//9
            default: LCDM0 <= 'b00110000;//0
        endcase
        case (S1)
            'd0: LCDS1 <= 'b00110000;//0
            'd1: LCDS1 <= 'b00110001;//1
            'd2: LCDS1 <= 'b00110010;//2
            'd3: LCDS1 <= 'b00110011;//3
            'd4: LCDS1 <= 'b00110100;//4
            'd5: LCDS1 <= 'b00110101;//5
            'd6: LCDS1 <= 'b00110110;//6
            'd7: LCDS1 <= 'b00110111;//7
            'd8: LCDS1 <= 'b00111000;//8
            'd9: LCDS1 <= 'b00111001;//9
            default: LCDS1 <= 'b00110000;//0
        endcase
        case (S0)
            'd0: LCDS0 <= 'b00110000;//0
            'd1: LCDS0 <= 'b00110001;//1
            'd2: LCDS0 <= 'b00110010;//2
            'd3: LCDS0 <= 'b00110011;//3
            'd4: LCDS0 <= 'b00110100;//4
            'd5: LCDS0 <= 'b00110101;//5
            'd6: LCDS0 <= 'b00110110;//6
            'd7: LCDS0 <= 'b00110111;//7
            'd8: LCDS0 <= 'b00111000;//8
            'd9: LCDS0 <= 'b00111001;//9
            default: LCDS0 <= 'b00110000;//0
        endcase
    end
    
    reg [20:0] licznik = 0;//50Mhz czyli 50*10^6 na sekunde - potrzeba 21 bitów do odświeżania ekranu 10ms
    reg [7:0] LCD_out;
    reg on = 0;
    //on == 0 inicjalizacja LCD tylko raz na początku
    always @ (posedge clk) begin
        licznik <= licznik + 1;
        if(on == 0)begin
            if(licznik == 1000000)begin//#20000000ns
                LCD_out <= 8'b00111000; //function set
                RS <= 0;
                RW <= 0;
            end
            else if(licznik == 1000004)begin
                E <= 1;
            end
            else if(licznik == 1000016)begin//#240ns dla zminy LCD E
                E <= 0;
            end
            else if(licznik == 1300016)begin//#6000000ns
                LCD_out <= 8'b00111000; //function set
                RS <= 0;
                RW <= 0;
            end
            else if(licznik == 1300020)begin
                E <= 1;
            end
            else if(licznik == 1300032)begin//#240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 1302032)begin//40000ns
                LCD_out <= 8'b00000110; //entry mode
                RS <= 0;
                RW <= 0;
            end
            else if(licznik == 1302036)begin
                E <= 1;
            end
            else if(licznik == 1302048)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 1304048)begin//40000ns
                LCD_out <= 8'b00001100; //display on/off
                RS <= 0;
                RW <= 0;
            end
            else if(licznik == 1304052)begin
                E <= 1;
            end
            else if(licznik == 1304064)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 1306064)begin//40000ns
                LCD_out <= 8'b00000001; //clear display
                RS <= 0;
                RW <= 0;
            end
            else if(licznik == 1306068)begin
                E <= 1;
            end
            else if(licznik == 1306080)begin//240ns dla zmiany LCD E
                E <= 0;
                on <= 0;
            end
            else if(licznik == 1391080)begin//#1700000ns
                on <= 1;
                licznik <= 0;
            end
        end
        //************wypisywanie znaków na LCD**************
        else begin
            if(licznik == 2000)begin//40000ns
                LCD_out <= LCDH1; //H1
                RS <= 1;
                RW <= 0;
            end
            else if(licznik == 2004)begin
                E <= 1;
            end
            else if(licznik == 2016)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 4016)begin//40000ns
                LCD_out <= LCDH0; //H0
                RS <= 1;
                RW <= 0;
            end
            else if(licznik == 4020)begin
                E <= 1;
            end
            else if(licznik == 4032)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 6032)begin//40000ns
                LCD_out <= 8'b00111010; //:
                RS <= 1;
                RW <= 0;
            end
            else if(licznik == 6036)begin
                E <= 1;
            end
            else if(licznik == 6048)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 8048)begin//40000ns
                LCD_out <= LCDM1; 
                RS <= 1;
                RW <= 0;
            end
            else if(licznik == 8052)begin
                E <= 1;
            end
            else if(licznik == 8064)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 10064)begin//40000ns
                LCD_out <= LCDM0; //:
                RS <= 1;
                RW <= 0;
            end
            else if(licznik == 10068)begin
                E <= 1;
            end
            else if(licznik == 10080)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 12080)begin//40000ns
                LCD_out <= 8'b00111010; //:
                RS <= 1;
                RW <= 0;
            end
            else if(licznik == 12084)begin
                E <= 1;
            end
            else if(licznik == 12096)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 14096)begin//40000ns
                LCD_out <= LCDS1; //:
                RS <= 1;
                RW <= 0;
            end
            else if(licznik == 14100)begin
                E <= 1;
            end
            else if(licznik == 14112)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 16112)begin//40000ns
                LCD_out <= LCDS0; 
                RS <= 1;
                RW <= 0;
            end
            else if(licznik == 16116)begin
                E <= 1;
            end
            else if(licznik == 16128)begin//240ns dla zmiany LCD E
                E <= 0;
            end
            else if(licznik == 18128)begin
                LCD_out <= 8'b10000000; //set ddram powrót na początek - nadpisywanie wartości
                RS <= 0;
                RW <= 0;
            end
            else if(licznik == 18132)begin
                E <= 1;
            end
            else if(licznik == 18144)begin//240ns dla zmiany LCD E
                E <= 0;
                licznik <= 0;
            end
        end

        {LCD7,LCD6,LCD5,LCD4,LCD3,LCD2,LCD1,LCD0} <= LCD_out; //przypisanie wyjść

    end
    
endmodule
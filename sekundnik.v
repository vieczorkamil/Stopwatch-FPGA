/* Autorzy: Kamil Wieczorek */
/* Moduł odpowiadacjący za "wyznaczanie" 1 sekundu oraz oblliczanie wartości odpowiednich
   H1H0 : M1M0 : S1S0  jako godzina minuta sekunda aż do 23:59:59 po tym czasie się wyzeruje */
module sekundnik(
    input clk,//zegar 50Mhz
    input start_button,
    input reset,
    output reg [3:0] H1,
    output reg [3:0] H0,
    output reg [3:0] M1,
    output reg [3:0] M0,
    output reg [3:0] S1,
    output reg [3:0] S0
    );
    
    reg [25:0] sekunda = 0;//50Mhz czyli 50M na sekunde - potrzeba 26 bitów do zapisu
    reg plus;
    reg start;

    //stop kiedy przełącze "start" na zero
    //synchronizator D
    always @(posedge clk)
    begin
            start <= start_button;
    end
    
    always @(posedge clk or posedge reset)
    begin
        if(reset == 1)//wciśnięty reset
            sekunda <= 0;
        else if(sekunda == 50000000)//mineła sekunda //50000000
            sekunda <= 0;
        else if(start == 1)
            sekunda <= sekunda + 1;
    end

    always @(*)
    begin
        if(sekunda == 50000000)//jeśli mineła sekunda
            plus <= 'b1;
        else    
            plus <= 'b0;
    end

    //przypisanie odpowiedznich wartości hh : mm : ss
    always @(posedge clk or posedge reset)
    begin
        if(reset == 1) //wyzerowanie wartości po wciśnięciu resetu -> 00:00:00
        begin
            H1 <= 0;
            H0 <= 0;
            M1 <= 0;
            M0 <= 0;
            S1 <= 0;
            S0 <= 0;
        end

        else if (plus == 1)//jak mineła sekunda
        begin//If - jeśli każda z pozycji zegara przyjmuje maksymalną wartość else - dodaje + 1
            if(S0 == 9)
            begin
                S0 <= 0;
                if(S1 == 5)
                begin
                    S1 <= 0;
                    if(M0 == 9)
                    begin
                        M0 <= 0;
                        if(M1 == 5)
                        begin
                            M1 <= 0;
                            if(H0 == 9 || (H1 == 2 && H0 == 3))//09://19: or 23:59:59
                            begin
                                H0 <= 0;
                                if(H1 == 2 && H0 == 3)//sytuacja w której stoper osiągną wartość 23:59:59
                                    H1 <= 0;//zostaje wyzerowany
                                else
                                    H1 <= H1 + 1;
                            end 
                            else
                                H0 <= H0 + 1;
                        end
                        else
                            M1 <= M1 + 1;
                    end
                    else
                        M0 <= M0 + 1;
                end
                else
                    S1 <= S1 + 1;
            end 
            else    
                S0 <= S0 + 1;
        end

    end

endmodule
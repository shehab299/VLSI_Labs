interface counter_interface(input logic clock);

    logic [3:0] count;
    logic reset;
    logic up_down;
    logic enable;
    
endinterface: counter_interface
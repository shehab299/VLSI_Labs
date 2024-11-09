module counter (
    input wire clk,
    input wire reset,
    input wire up_down,
    input wire enable,
    output reg [3:0] count
);


always @(posedge clk) begin

    if (reset) begin 
        if (up_down) begin 
            count <= 4'b0000;
        end 
        else begin 
            count <= 4'b1111;
        end
    end 

    else begin 

        if(enable) begin 
            if (up_down) begin 
                if (count == 4'b1111) begin 
                    count <= 4'b0000;
                end 
                else begin
                    count <= count + 1;
                end
            end 
            else begin 
                if (count == 4'b0000) begin 
                    count <= 4'b1111;
                end 
                else begin 
                    count <= count - 1;
                end
            end 
        end 
    end

end

endmodule
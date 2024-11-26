module counter (
    input  logic clock,
    input  logic reset,
    input  logic up_down,
    input  logic enable,
    output logic [3:0] count
);

always_ff @(posedge clock) begin
    if (reset) begin
        count <= up_down ? 4'b0000 : 4'b1111;
    end else if (enable) begin
        if (up_down) begin
            count <= (count == 4'b1111) ? 4'b0000 : count + 1;
        end else begin
            count <= (count == 4'b0000) ? 4'b1111 : count - 1;
        end
    end
end

endmodule

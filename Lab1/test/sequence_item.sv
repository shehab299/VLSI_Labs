class sequence_item extends uvm_sequence_item;

    `uvm_object_utils(sequence_item) // Macro to define the class

    // Inputs
    logic reset;
    logic up_down;
    logic enable;

    // Outputs
    logic [3:0] count;

    function new(string name = "sequence_item");
        super.new(name);
    endfunction: new

endclass: sequence_item


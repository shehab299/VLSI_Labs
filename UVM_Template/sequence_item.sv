class sequence_item extends uvm_sequence_item;

    `uvm_object_utils(sequence_item) // Macro to define the class

    // Add the fields here



    function new(string name = "alu_sequence_item");
        super.new(name);
    endfunction: new

endclass: alu_sequence_item


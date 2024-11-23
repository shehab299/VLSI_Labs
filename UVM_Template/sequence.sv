class base_sequence extends uvm_sequence #(sequence_item);

    `uvm_object_utils(base_sequence)
    sequence_item seq_item_inst;

    function new(string name = "base_sequence");
        super.new(name);
    endfunction: new


    task body();

        seq_item_inst = sequence_item::type_id::create("seq_item_inst");
        start_item(seq_item_inst);

        // Fill the sequence item with data
        
        finish_item(seq_item_inst);

    endtask: body

endclass: base_sequence
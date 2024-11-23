class base_sequence extends uvm_sequence #(sequence_item);

    `uvm_object_utils(base_sequence)
    sequence_item packet;

    function new(string name = "base_sequence");
        super.new(name);
    endfunction: new


    task body();

        packet = sequence_item::type_id::create("packet");

        start_item(packet);

        // Fill the sequence item with data
        // generate test packets
        
        finish_item(packet);

    endtask: body

endclass: base_sequence
class driver extends uvm_driver#(sequence_item);
    
    `uvm_component_utils(driver)

    virtual counter_interface dut_if;
    sequence_item seq_item;
    
    // Constructor
    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new
    
    // Function: build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(virtual counter_interface)::get(this, "*", "dut_if", dut_if)) begin
            `uvm_fatal("NO_DUT_IF", {"DUT Interface not set for ", get_full_name()})
        end

    endfunction: build_phase
    
    // Function: connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase

    // Task: drive

    task drive(sequence_item seq_item);

        // Put the item on the interface
        // dut_if.thing = seq_item.thing;

    endtask: drive


    // Function: run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            seq_item = sequence_item::type_id::create("seq_item");
            seq_item_port.get_next_item(seq_item);
            drive(seq_item);
            seq_item_port.item_done();
        end

    endtask: run_phase

endclass: driver


    

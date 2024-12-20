class monitor extends uvm_monitor;

    `uvm_component_utils(monitor) // Macro to define the class
    virtual alu_interface dut_if;
    sequence_item item;

    function new(string name = "alu_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual alu_interface)::get(this, "", "dut_if", dut_if)) begin
            `uvm_fatal("NOVIF", {"Virtual interface must be set for: ", get_full_name()})
        end

     endfunction: build_phase


    task run_phase(uvm_phase phase);

        forever begin

            item = alu_sequence_item::type_id::create("item");

            // Fill in the item with data from the interface
            // item.data = vif.data;

        end

    endtask: run_phase




endclass: monitor
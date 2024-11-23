class monitor extends uvm_monitor;

    `uvm_component_utils(monitor) // Macro to define the class
    virtual counter_interface dut_if;
    sequence_item item;

    uvm_analysis_port #(sequence_item) monitor_port;


    function new(string name = "monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        monitor_port = new("monitor_port", this);

        if (!uvm_config_db#(virtual counter_interface)::get(this, "", "dut_if", dut_if)) begin
            `uvm_fatal("NOVIF", {"Virtual interface must be set for: ", get_full_name()})
        end

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase
    
    task run_phase(uvm_phase phase);

        forever begin

            item = sequence_item::type_id::create("item");

            // Fill in the item with data from the interface
            // item.data = vif.data;

            monitor_port.write(item);
        end

    endtask: run_phase


endclass: monitor
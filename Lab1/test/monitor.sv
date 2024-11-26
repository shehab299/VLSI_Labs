class monitor extends uvm_monitor;

    `uvm_component_utils(monitor) // Macro to define the class

    virtual counter_interface dut_if;
    sequence_item item;

    uvm_analysis_port #(sequence_item) monitor_port;

    // Constructor
    function new(string name = "monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    // Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        monitor_port = new("monitor_port", this);

        if (!uvm_config_db#(virtual counter_interface)::get(this, "", "dut_if", dut_if)) begin
            `uvm_fatal("NOVIF", {"Virtual interface must be set for: ", get_full_name()})
        end
    endfunction: build_phase

    // Connect Phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase

    // Run Phase: Main task
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        `uvm_info("MONITOR", "Monitor run_phase started.", UVM_LOW)

        forever begin
            item = sequence_item::type_id::create("item", this);

            @(posedge dut_if.clock);

            // Capture data from the interface into the item
            item.reset    = dut_if.reset;
            item.enable   = dut_if.enable;
            item.up_down  = dut_if.up_down;
            item.count    = dut_if.count;

            monitor_port.write(item);

            `uvm_info("MONITOR", $sformatf("Packet captured: reset=%0d, enable=%0d, up_down=%0d, count=%0d", dut_if.reset, dut_if.enable, dut_if.up_down, dut_if.count), UVM_MEDIUM)
        end
    endtask: run_phase

endclass: monitor

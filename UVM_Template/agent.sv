class agent extends uvm_agent;

    `uvm_component_utils(agent)

    // UVM Components
    driver drv_inst;
    monitor mon_inst;
    sequencer sqncer_inst;

    // Constructor
    function new(string name = "agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    // Function: build_phase

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv_inst = driver::type_id::create("drv_inst", this);
        mon_inst = monitor::type_id::create("mon_inst", this);
        sqncer_inst = sequencer::type_id::create("seq_inst", this);
    endfunction: build_phase

    // Function: connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        // Connect the driver to the sequencer
        sqncer_inst.driver_port.connect(drv_inst.seq_item_export);

    endfunction: connect_phase

    // Function: run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask: run_phase


endclass: agent
class driver extends uvm_driver#(sequence_item);

    `uvm_component_utils(driver)

    virtual counter_interface dut_if; 
    sequence_item seq_item;

    // Constructor
    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    // Build Phase: Get the virtual interface
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual counter_interface)::get(this, "*", "dut_if", dut_if)) begin
            `uvm_fatal("NO_DUT_IF", {"DUT Interface not set for ", get_full_name()})
        end
    endfunction: build_phase

    // Connect Phase (Optional for extensibility)
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase

    // Task: Drive DUT signals
    task drive(sequence_item seq_item);
        if (seq_item == null) begin
            `uvm_error("DRIVER", "Received null sequence item.")
            return;
        end

        `uvm_info("DRIVER", $sformatf("Driving DUT: reset=%0d, enable=%0d, up_down=%0d",seq_item.reset, seq_item.enable, seq_item.up_down), UVM_MEDIUM)

        dut_if.reset   <= seq_item.reset;
        dut_if.enable  <= seq_item.enable;
        dut_if.up_down <= seq_item.up_down;

        repeat(2) @(posedge dut_if.clock); // Doesn't matter we can clock cycles as we lile set it as we like

        // Log completion
        `uvm_info("DRIVER", "Signal driving completed.", UVM_LOW)
    endtask: drive

    // Run Phase: Main driver loop
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        `uvm_info("DRIVER", "Driver run_phase started.", UVM_LOW)

        forever begin
            seq_item = sequence_item::type_id::create("seq_item", this);

            // Get the next sequence item from the sequencer
            seq_item_port.get_next_item(seq_item);

            // Drive the sequence item to the DUT
            drive(seq_item);

            // Notify the sequencer that the item is done
            seq_item_port.item_done();
        end
    endtask: run_phase

endclass: driver

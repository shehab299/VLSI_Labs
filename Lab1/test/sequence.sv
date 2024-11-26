class base_sequence extends uvm_sequence #(sequence_item);

    `uvm_object_utils(base_sequence)
    virtual counter_interface dut_if;
    sequence_item packet;
    uvm_component cntxt;

    function new(string name = "base_sequence");
        super.new(name);
    endfunction: new


    // Helper function to configure and send a packet
    task send_packet(int reset = 0, int enable = 0, int up_down = 0);
        packet = sequence_item::type_id::create("packet");

        start_item(packet);

        // Configure packet fields
        packet.reset    = reset;
        packet.enable   = enable;
        packet.up_down  = up_down;

        finish_item(packet);

        `uvm_info("SEQUENCE", $sformatf("Packet sent: reset=%0d, enable=%0d, up_down=%0d", reset, enable, up_down), UVM_LOW)
    endtask: send_packet

    task send_random_packet();

        packet = sequence_item::type_id::create("packet");

        start_item(packet);
        packet.randomize();
        finish_item(packet);

        `uvm_info("SEQUENCE", $sformatf("Packet sent: reset=%0d, enable=%0d, up_down=%0d", packet.reset, packet.enable, packet.up_down), UVM_LOW)
        
    endtask: send_random_packet

    task body();

        if (!uvm_config_db#(virtual counter_interface)::get(cntxt, "*", "dut_if", dut_if)) begin
            `uvm_fatal("NO_DUT_IF", {"DUT Interface not set for ", get_full_name()})
        end

        // First packet: Reset
        send_packet(1, 1, 1);
        @(posedge dut_if.clock);

        // Second packet: Disable
        send_packet(0, 0, 1);
        repeat(2) @(posedge dut_if.clock);

        // Third packet: Enable and direction up
        send_packet(0, 1, 1);
        repeat(4) @(posedge dut_if.clock);

        // Fourth packet: Enable and direction down
        send_packet(0, 1, 0);
        repeat(4) @(posedge dut_if.clock);

        // Fifth packet: Reset again
        send_packet(1, 1, 0);
        @(posedge dut_if.clock);

        // Sixth packet: Enable and direction up after reset
        send_packet(0, 1, 1);
        repeat(4) @(posedge dut_if.clock);

        // Seventh packet: Direction down
        send_packet(0, 1, 0);
        repeat(5) @(posedge dut_if.clock);

        forever begin
            send_random_packet();
        end 

    endtask: body

endclass: base_sequence

class env extends uvm_env;

    `uvm_component_utils(env)

    // UVM Components
    agent agent_inst;
    scoreboard sb_inst;

    // Constructor
    function new(string name = "env", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new


    // Function: build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent_inst = agent::type_id::create("agent_inst", this);
        sb_inst = scoreboard::type_id::create("sb_inst", this);
    endfunction: build_phase


    // Function: connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent_inst.mon_inst.monitor_port.connect(sb_inst.scoreboard_port);
    endfunction: connect_phase

    // Function: run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask: run_phase

endclass: env

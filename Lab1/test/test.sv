class test extends uvm_test;

    `uvm_component_utils(test) // Register the class with UVM

    // UVM Components
    env env_inst;
    base_sequence seq_inst;

    // Constructor

    function new(string name = "test", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new


    // Function: build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env_inst = env::type_id::create("env_inst", this);
    endfunction: build_phase


    // Function: connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase


    // Function: run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        phase.raise_objection(this);

        seq_inst = base_sequence::type_id::create("seq_inst");
        seq_inst.start(env_inst.agent_inst.sqncer_inst);

        phase.drop_objection(this);  

    endtask: run_phase

endclass: test

// 32:56
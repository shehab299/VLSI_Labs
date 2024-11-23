

class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(sequence_item, scoreboard) scoreboard_port;
  sequence_item transactions[$];
  
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);   
    scoreboard_port = new("scoreboard_port", this);
  endfunction: build_phase
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);   
  endfunction: connect_phase
  
  function void write(sequence_item item);
    transactions.push_back(item);
  endfunction: write 
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
   
    forever begin
      /*
      // get the packet
      // generate expected value
      // compare it with actual value
      // score the transactions accordingly
      */
      sequence_item curr_trans;
      wait((transactions.size() != 0));
      curr_trans = transactions.pop_front();
      compare(curr_trans);    
    end
    
  endtask: run_phase
  
  
  task compare(sequence_item curr_trans);
    
  endtask: compare
  
  
endclass: alu_scoreboard
class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(sequence_item, scoreboard) scoreboard_port; 
  sequence_item transactions[$]; 
  int expected_counter; 
  logic started;
  
  // Constructor
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);   
    scoreboard_port = new("scoreboard_port", this);
    expected_counter = 0; 
    started = 0;
  endfunction: build_phase
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);   
  endfunction: connect_phase
  
  // Write method to receive transactions
  function void write(sequence_item item);
    transactions.push_back(item);
  endfunction: write 
  
  // Run phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   
    forever begin
      sequence_item curr_trans;
      
      wait(transactions.size() != 0);
      
      curr_trans = transactions.pop_front();
      
      compare(curr_trans);    
    end
    
  endtask: run_phase
  
  // Compare task
  task compare(sequence_item curr_trans);

    if(started != 1) begin
      if(curr_trans.reset != 1) begin
        `uvm_error("SCOREBOARD_ERROR", "You Haven't Resetted The Device Yet")
        return;
      end else begin
        started = 1;
      end
    end
         
    if (curr_trans.count != expected_counter) begin
      `uvm_error("SCOREBOARD_MISMATCH", 
                 $sformatf("Count mismatch: expected = %0d, actual = %0d", 
                           expected_counter, curr_trans.count))
    end else begin
      `uvm_info("SCOREBOARD_MATCH", 
                $sformatf("Count match: expected = %0d, actual = %0d", 
                          expected_counter, curr_trans.count), 
                UVM_LOW)
    end

    if(curr_trans.reset) begin
    
      if(curr_trans.up_down) begin
        expected_counter = 0;
      end else begin
        expected_counter = 15;
      end

    end else if(curr_trans.enable & curr_trans.up_down) begin 
      expected_counter++;

      if(expected_counter > 15)
        expected_counter = 0;

    end else if(curr_trans.enable & curr_trans.up_down != 1) begin 
      expected_counter--;
      
      if(expected_counter < 0)
        expected_counter = 15;

    end else begin 
      expected_counter = expected_counter;
    end
    
  endtask: compare
  
endclass: scoreboard

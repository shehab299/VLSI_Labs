`timescale 1ns/1ns

//////////UVM PACKAGES//////////

import uvm_pkg::*;
`include "uvm_macros.svh"

/////////////////////////////////
############################################
//////////INCLUDE FILES//////////

`include "counter.sv" // Design File
`include "counter_interface.sv" // Interface File

`include "sequence_item.sv" // Sequence Item File
`include "sequence.sv" // Sequence File
`include "sequencer.sv" // Sequencer File
`include "driver.sv" // Driver File
`include "monitor.sv" // Monitor File
`include "agent.sv" // Agent File
`include "scoreboard.sv" // Scoreboard File
`include "env.sv" // Environment File
`include "test.sv" // Test File

module top;
    
############################################
//////// Generate CLOCK (Optional) ////////

logic clock;

initial begin
    clock = 0;
    forever begin
        #5 clock = ~clock;
    end 
end

//////////////////////////////////////////
############################################
//////////Interface Instance//////////

counter_interface dut_if(
    .clock(clock),
);

initial begin
    uvm_config_db#(virtual counter_interface)::set(null, "*", "dut_if", dut_if);
end

//////////////////////////////////////
############################################
//////////DUT Instance///////////////////

counter dut(
    .clock(dut_if.clock),
    .reset(dut_if.reset),
    .up_down(dut_if.up_down),
    .enable(dut_if.enable),
    .count(dut_if.count)
);

//////////////////////////////////////
############################################
//////////RUN UVM/////////////////////

initial begin
    uvm_config_db#(uvm_object_wrapper)::set(null, "*", "verbosity", UVM_HIGH);
    run_test("test_class_name");
end

//////////////////////////////////////
############################################
//////////DUMP WAVEFORM///////////////

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, top);
end

//////////////////////////////////////
############################################
//////////END/////////////////////////

endmodule: top
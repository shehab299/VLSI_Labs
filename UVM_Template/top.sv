`timescale 1ns/1ns

//////////UVM PACKAGES//////////

import uvm_pkg::*;
`include "uvm_macros.svh"

/////////////////////////////////
############################################
//////////INCLUDE FILES//////////

`include "dut.sv" // Design File
`include "dut_interface.sv" // Interface File

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

logic clk;

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end 
end

//////////////////////////////////////////
############################################
//////////DUT Instance///////////////////

design dut();

//////////////////////////////////////
############################################
//////////Interface Instance//////////

design_interface dut_if();

initial begin
    uvm_config_db#(virtual dut_interface)::set(null, "*", "dut_if", dut_if);
end

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
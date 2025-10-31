`include "uvm_macros.svh";
import uvm_pkg::*;

class driver1 extends uvm_driver;
  `uvm_component_utils(driver1)
  
  function new(string name="driver1",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

class driver2 extends driver1;
  `uvm_component_utils(driver2)
  
  function new(string name="driver2",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

class driver3 extends driver1;
  `uvm_component_utils(driver3)
  
  function new(string name="driver3",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass


class base_agent extends uvm_agent;
  `uvm_component_utils(base_agent)
  
   driver1 driv;
  function new (string name="base_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    driv=driver1::type_id::create("driv",this);
   super.build_phase(phase);
    
    endfunction
  
endclass

class child_agent extends base_agent;
  `uvm_component_utils(child_agent)
  
  function new (string name="child_agent",uvm_component parent);
    super.new(name ,parent);
  endfunction

endclass


class env extends uvm_env;
  `uvm_component_utils(env)
  base_agent base;
  
  function new(string name="env",uvm_component parent);
    super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      base=base_agent::type_id::create("base",this);
      super.build_phase(phase);
    endfunction
endclass
    
    
class test extends uvm_test;
  `uvm_component_utils(test)
   env envh;
  function new(string name="test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    
    uvm_factory factory = uvm_factory::get();
    envh =env::type_id::create("envh",this);
    
    //global override
    set_type_override_by_type(driver1::get_type(),driver2::get_type());
    set_type_override_by_type(base_agent::get_type(),child_agent::get_type());
    
    //instance override
    set_inst_override_by_type("env.base",driver1::get_type(),driver2::get_type());
    
    

    
    super.build_phase(phase);
    factory.print();
        
  endfunction
endclass

module top;
  initial begin
    run_test("test");
  end
endmodule

//output
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: UVM_INFO @ 0: reporter [RNTST] Running test test...
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_factory.svh(1645) @ 0: reporter [UVM/FACTORY/PRINT] 
# KERNEL: #### Factory Configuration (*)
# KERNEL: 
# KERNEL: Instance Overrides:
# KERNEL: 
# KERNEL:   Requested Type  Override Path          Override Type
# KERNEL:   --------------  ---------------------  -------------
# KERNEL:   driver1         uvm_test_top.env.base  driver2
# KERNEL: 
# KERNEL: Type Overrides:
# KERNEL: 
# KERNEL:   Requested Type  Override Type        
# KERNEL:   --------------  ---------------------
# KERNEL:   driver1         driver2
# KERNEL:   base_agent      child_agent
# KERNEL: 
# KERNEL: All types registered with the factory: 60 total
# KERNEL:   Type Name
# KERNEL:   ---------
# KERNEL:   base_agent
# KERNEL:   child_agent
# KERNEL:   driver1
# KERNEL:   driver2
# KERNEL:   driver3
# KERNEL:   env
# KERNEL:   test
# KERNEL: (*) Types with no associated type name will be printed as <unknown>
# KERNEL: 
# KERNEL: ####
# KERNEL: 
# KERNEL: 
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_report_server.svh(869) @ 0: reporter [UVM/REPORT/SERVER] 
# KERNEL: --- UVM Report Summary ---
# KERNEL: 
# KERNEL: ** Report counts by severity
# KERNEL: UVM_INFO :    3
# KERNEL: UVM_WARNING :    0
# KERNEL: UVM_ERROR :    0
# KERNEL: UVM_FATAL :    0
# KERNEL: ** Report counts by id
# KERNEL: [RNTST]     1
# KERNEL: [UVM/FACTORY/PRINT]     1
# KERNEL: [UVM/RELNOTES]     1
# KERNEL: 
# RUNTIME: Info: RUNTIME_0068 uvm_root.svh (521): $finish called.
# KERNEL: Time: 0 ns,  Iteration: 195,  Instance: /top,  Process: @INITIAL#101_0@.
# KERNEL: stopped at time: 0 ns
# VSIM: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done




    
    
    

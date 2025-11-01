//clone() is a built-in UVM function that creates a complete duplicate (copy) of an object.


`include "uvm_macros.svh";
import uvm_pkg::*;

class transaction extends uvm_object;
  
  `uvm_object_utils(transaction)
  
  bit[3:0]addr;
  bit[7:0]data;
  
  function new (string name="transaction");
    super.new(name);
  endfunction
  
  virtual function void do_copy(uvm_object rhs);
    
    transaction t;
    $cast(t,rhs);
    
    this.data=t.data;
    this.addr=t.addr;
    
    super.do_copy(t);
    
  endfunction
  
  function void display(string message);
    $display("[%s] DATA=%d ADDR=%d",message,data,addr);
  endfunction
  
endclass


module test;
  transaction t1,t2;
  
  initial begin
   // t1=transaction::type_id::create("t1");
    t2=transaction::type_id::create("t2");
    
    t2.data=20;
    t2.addr=10;
    
    $cast(t1,t2.clone());
    
    t1.copy(t2);
    
    t1.display("t1");
    t2.display("t2");
    

  end
endmodule


// output
# KERNEL: 
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: [t1] DATA= 20 ADDR=10
# KERNEL: [t2] DATA= 20 ADDR=10
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done




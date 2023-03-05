# elec-374
Verilog CPU Design Project, ELEC 374 - Digital Systems Engineering

#Phase 1 Decisions
## Typical Register Implementation
- Global Asynchronous Clear on positive edge
- Rising clock edge response
- Rising clock edge enable

#To Do!
and - done
reg - done
not - done
or  - done
neg - done
add - done
sub - done
shr - done (NOT SIGNED)
shra- done (SIGNED)
shl - done (NOT SIGNED)
ror - done 
rol - done
mul - done
div - done
alu - done 
mdr - done, not tested
datapath - done, not tested
encoder - done
mux - done
pc - done
z - done

2023/03/04 -- Sam Notes:
- Compilation of datapath TB only successful when adding module example(input a, input b);
- Infinite loop of clock cycles: Z output is not visible when simulating

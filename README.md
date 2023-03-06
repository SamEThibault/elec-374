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
or - done
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
datapath - done
encoder - done
mux - done
pc - done
z - done

2023/03/04 -- Sam Notes:

- Never perform two operations on the same register in the same state

- Compilation of datapath TB only successful when adding module example(input a, input b);
- Infinite loop of clock cycles: Z output is not visible when simulating
- Need to modify state machine for 2-register operations
- Double-check opcode for all operations (32-bit opcode send to MdataIn)

Datapath Tests:

- or : COMPLETE
- and : COMPLETE
- add : COMPLETE
- not : In Progress (TEST)
- sub : COMPLETE
- mul : COMPLETE
- div : COMPLETE
- shr : COMPLETE
- shra : Complete (TEST)
- shl : COMPLETE
- ror : Complete (TEST)
- rol : Complete (TEST)
- neg : In Progress (TEST)

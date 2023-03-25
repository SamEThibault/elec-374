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

- Always remember to enable your registers in the same line as when you send signal to encoder:
  T3: begin
  #10 R2_out <= 1; Y_enable <= 1;
  #10 R2_out <= 0; Y_enable <= 0;
  end

- Never perform two operations on the same register in the same state

- Compilation of datapath TB only successful when adding module example(input a, input b);
- Infinite loop of clock cycles: Z output is not visible when simulating
- Need to modify state machine for 2-register operations
- Double-check opcode for all operations (32-bit opcode send to MdataIn)

Datapath Tests:

- or : COMPLETE -
- and : COMPLETE -
- add : COMPLETE
- not : In Progress (TEST) -
- sub : COMPLETE -
- mul : COMPLETE -
- div : COMPLETE -
- shr : COMPLETE -
- shra : Complete (TEST)
- shl : COMPLETE -
- ror : Complete (TEST) -
- rol : Complete (TEST) -
- neg : In Progress (TEST) -

Tests

- and : Good
- or : Good
- sub : Good
- add : Good
- mul : Good
- div : Good
- shr : Good
- shra : Good
- shl : Good
- ror : Good
- rol : Good
- neg : Good
- not : Good

Wave Viewer Requirements:

- Z_Hi (if used)
- Z_low
- Relevant Registers (q outputs)
- MuxOut

Optional?

- MDR
- IR

Kevin:
Not
Neg
Rol
Ror

# Phase 2

Kevin:

- Ram - Done (not tested)
- Select and Encode Block Diagram - Done (tested in individual TB)
- Sign extension of constant C -
- Revised Register R0

Sam:

- CON FF Logic - Done (Tested in individual TB)
- Computation of the conditional value CON in the CON FF LOGIC (Done)
- Input and output port (Done, not tested)

---

Phase 2 To Do:

- Fill out the rest of the instruction codes in ram (Done)
- Set up template TB for instruction tests (Done)
- Simulate and take screenshots (In Progress)
- Assemble report (In Progress)

Remaining Instructions:

- ld - DONE
- ldi -
- st -
- addi -
- andi -
- ori -
- brzr -
- brnz -
- brmi -
- brpl -
- jr -
- jal -
- mfhi -
- mflo -
- out -
- in -

Phase 2 Docs

- [] Code
- [] IR Values
- [] RAM values
- [] Register you're storing into
- [] Wave form signals

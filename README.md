# F2LP
Computing Answer Sets of First Order Formulas

## Introduction

F2LP is a tool that turns a first order formula under the stable model semantics into a logic program in Lparse and Gringo syntax. The translation preserves the stable models under certain assumptions (see References for further details).This allows us to use the current answer set solvers to compute answer sets of first order formulas. In order to use DLV with F2LP, the output of F2LP needs to be modified a bit. In particular, double negation in the body has to be eliminated (by introducing new predicates if necessary), and Lparse specific directives such as #hide and #domain have to be eliminated. F2LP is currently being updated to output programs compatible with DLV.

F2LP can be used to compute circumscriptive theories such as Event Calculus descriptions. It can also be used to compute descriptions in Causal Logic.

## Examples

blocksWorld.e: F2LP encoding of an event calculus description of the blocks world domain (does not include DEC/EC axioms).

robby.e: F2LP encoding of an event calculus description of the "robby" domain from [Dogandag et al., 2004].

dec.e: F2LP encoding of the DEC axioms.

## Sample Execution
```
f2lp robby.e dec.e | gringo -c maxstep=11 | claspD.
```

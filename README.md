# F2LP
Computing Answer Sets of First Order Formulas

## Introduction

F2LP is a tool that turns a first order formula under the stable model semantics into a logic program in Lparse and Gringo syntax. The translation preserves the stable models under certain assumptions (see References for further details).This allows us to use the current answer set solvers to compute answer sets of first order formulas. In order to use DLV with F2LP, the output of F2LP needs to be modified a bit. In particular, double negation in the body has to be eliminated (by introducing new predicates if necessary), and Lparse specific directives such as #hide and #domain have to be eliminated. F2LP is currently being updated to output programs compatible with DLV.

F2LP can be used to compute circumscriptive theories such as Event Calculus descriptions. It can also be used to compute descriptions in Causal Logic.

## File Description
* bin/f2lp: the pre-compiled binary for f2lp under Linux 64bit.
* f2lp.c: source code of F2LP.
* examples/blocksWorld.e: F2LP encoding of an event calculus description of the blocks world domain (does not include DEC/EC axioms).
* examples/robby.e: F2LP encoding of an event calculus description of the "robby" domain from [Dogandag et al., 2004].
* examples/dec.e: F2LP encoding of the DEC axioms.
* COPYRIGHT: information about copyright and warranty.

## Compiling F2LP
The following command line should work with most gcc distributions:
```
gcc f2lp.c -o f2lp
```

## How to Use
You can use the following command line to invoke F2LP. Please type "f2lp --help" for a list of all options.
```
f2lp input_file_1 ... input_file_n
```
F2LP can be compiled to output debug information using the following command line. Note that the output of f2lp in this case cannot be directly fed into the answer set solvers.
```
gcc -D DEBUG f2lp.c -o f2lp
```

## Sample Execution
```
f2lp robby.e dec.e | gringo -c maxstep=11 | claspD.
```

## Release Information
*************************************************************************
Revisions and New Features ( with respect to the earlier version (1.0) ):
**************************************************************************
1. F <- G where F and G are first-order formulas are permitted.
2. "_" can be used in variables.
3. Fixed a bug in quantifier elimination (replacement of variables).
4. Allows both DLV and Gringo aggregates, and treats them as atoms.
   (Does not support pooling and does not support X=1..5).
5. Reserved variables are _NV_*, and reserved constants are _new_pred_* and
   _agg_exp_*
6. Supports all arithmetic operations but does not support any bitwise
   operation other than "xor".
7. Outputs comments and extra lines inserted by user.
8. Redirects errors to stderr instead of stdout.
9. == and = treated differently now.


*************************************************************************
Revisions and New Features ( with respect to the earlier version (0.9) ):
*************************************************************************
1. Fixed a bug in searching for patterns.
2. Fixed some problems with parsing comments.
3. Added suport for STDIN and multiple input files.
4. Added options (can be viewed using "f2lp --help").
5. Added # before hide.
6. Hides the new predicates.
7. Adds double negation only for S.P occurrences when new predicates are introduced.
9. Added support for extensional predicates (Example: #extensional P(X,Y).)
10. Supports comparisons involving function constants (Example: p(X,a) != A). 
11. Fixed a bug in the code that replaces variables with new ones 
    (when the size of the new variable is smaller than that of the older variable).
12. Removed the error message that # can be used only to declare domain variables. 

****************************************
Under consideration for future versions:
****************************************
1. Output programs that can be run on dlv.
2. Implementing safety-preserving transformations.

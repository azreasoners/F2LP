objects(a;b;c;table).
time(0..maxstep).
#domain objects(X).
#domain objects(Y).
#domain time(T).
fluent(on(X,Y);holding(X);clear(X)).
event(pickUp(X);stack(X,Y)).
#domain event(E1).
#domain event(E2).

% initiates and terminates formulas
initiates(pickUp(X),holding(X),T) <- T<maxstep.
terminates(pickUp(X),on(X,Y),T) <- T < maxstep & holdsAt(on(X,Y),T).
initiates(stack(X,Y),on(X,Y),T) <- T < maxstep.
terminates(stack(X,Y),holding(X),T) <- T < maxstep.

% action precondition axioms
holdsAt(clear(X),T) & not ?[Y]:holdsAt(holding(Y),T) & X != table <- T < maxstep & happens(pickUp(X),T).
holdsAt(holding(X),T) & holdsAt(clear(Y),T) & X != table <- T < maxstep & happens(stack(X,Y),T).

% event occurrence constraints
not happens(E2,T) <- T<maxstep & happens(E1,T) & E1 != E2.

% state constraints
not ?[Y]:(holdsAt(on(Y,X),T)) <- X != table & holdsAt(clear(X),T).
holdsAt(clear(X),T) & X != table <- not ?[Y]:(holdsAt(on(Y,X),T)).
X != table <- holdsAt(on(X,Y),T).
holdsAt(clear(table),T).

% observations
releasedAt(clear(X),0).
not releasedAt(holding(X),0).
not releasedAt(on(X,Y),0).

% needed for planning problems
{happens(E1,T)} <- T < maxstep.

% initial state
holdsAt(on(a,table),0).
holdsAt(on(b,c),0).
holdsAt(on(c,a),0).
not holdsAt(on(a,c),0).
not holdsAt(on(a,b),0).
not holdsAt(on(b,table),0).
not holdsAt(on(c,table),0).
not holdsAt(on(c,b),0).
not holdsAt(on(b,a),0).
not holdsAt(holding(X),0).

% goal
not not (holdsAt(on(c,table),maxstep) & holdsAt(on(b,c),maxstep) & holdsAt(on(a,b),maxstep)).

% managing the output
#hide.
#show happens/2.

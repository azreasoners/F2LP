% File 'robby'

% objects
step(0..maxstep).
astep(0..maxstep-1).
room(1..9).

% variables
#domain step(T).
#domain room(R). 
#domain room(R1).
#domain room(R2). 

% position of the doors
door(R1,R2) <- R1 >= 1 & R2 >=1 & R1 < 4 & R2 < 4 & R2 = R1+1.
door(R1,R2) <- R1 >= 4 & R2 >= 4 & R1 < 7 & R2 < 7 & R2 = R1+1.
door(R1,R2) <- R1 >= 7 & R2 >= 7 & R1 < 10 & R2 < 10 & R2 = R1+1.
door(R1,R2) <- R2 < 10 & R2 = R1+3.

door(R1,R2) <- door(R2,R1).

% fluents
fluent(opened(R,R1)) <- door(R1,R2).
fluent(inRoom(R)).
% F ranges over the fluents
#domain fluent(F).

% events
event(open(R,R1)) <- door(R,R1).
event(goto(R)).
% E and E1 range over the events
#domain event(E).
#domain event(E1). 

% effect axioms
initiates(open(R,R1),opened(R,R1),T).
initiates(open(R,R1),opened(R1,R),T).

initiates(goto(R2),inRoom(R2),T) 
  <- holdsAt(opened(R1,R2),T) & holdsAt(inRoom(R1),T).

terminates(E,inRoom(R1),T) 
  <- holdsAt(inRoom(R1),T) & initiates(E,inRoom(R2),T).

% action precondition axioms
holdsAt(inRoom(R1),T) <- happens(open(R1,R2),T).

% event occurrence constraint
not happens(E1,T) <- happens(E,T) & E != E1.

% state constraint
not holdsAt(inRoom(R2),T) <- holdsAt(inRoom(R1),T) & R1 != R2.

% accessibility
accessible(R,R1,T) <- holdsAt(opened(R,R1),T).
accessible(R,R2,T) <- accessible(R,R1,T) & accessible(R1,R2,T). 

% initial state
not holdsAt(opened(R1,R2),0).
holdsAt(inRoom(5),0).

% goal state
not not accessible(R,R1,maxstep).

% happens is exempt from minimization in order to find a plan.
{happens(E,T)} <- T < maxstep.

% all fluents are inertial
not releasedAt(F,0). 


#hide.
#show happens/2.

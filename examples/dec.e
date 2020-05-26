% File `dec'

#domain fluent(F).
#domain fluent(F1). 
#domain fluent(F2). 
#domain event(E).
#domain time(T).
#domain time(T1).
#domain time(T2).

time(0..maxstep).

% DEC 1
stoppedIn(T1,F,T2) <- happens(E,T) & T1<T & T<T2 & terminates(E,F,T).

% DEC 2
startedIn(T1,F,T2) <- happens(E,T) & T1<T & T<T2 & initiates(E,F,T).
  
% DEC 3
holdsAt(F2,T1+T2) <- happens(E,T1) & initiates(E,F1,T1) & T2>0 &
   trajectory(F1,T1,F2,T2) & not stoppedIn(T1,F1,T1+T2) & T1+T2<=maxstep.

% DEC 4
holdsAt(F2,T1+T2) <- happens(E,T1) & terminates(E,F1,T1) & 0<T2 &
   antiTrajectory(F1,T1,F2,T2) & not startedIn(T1,F1,T1+T2) & 
   T1+T2<=maxstep.

% DEC 5
holdsAt(F,T+1) <- holdsAt(F,T) & not releasedAt(F,T+1) & 
   not ?[E]:(happens(E,T) & terminates(E,F,T)) & T<maxstep.

% DEC 6
not holdsAt(F,T+1) <- not holdsAt(F,T) & not releasedAt(F,T+1) & 
   not ?[E]:(happens(E,T) & initiates(E,F,T)) & T<maxstep.

% DEC 7
releasedAt(F,T+1) <- 
   releasedAt(F,T) & not ?[E]:(happens(E,T) & 
   (initiates(E,F,T) | terminates(E,F,T))) & T<maxstep.

% DEC 8
not releasedAt(F,T+1) <- not releasedAt(F,T) & 
   not ?[E]: (happens(E,T) & releases(E,F,T)) & T<maxstep.

% DEC 9
holdsAt(F,T+1) <- happens(E,T) & initiates(E,F,T) & T<maxstep.

% DEC 10
not holdsAt(F,T+1) <- happens(E,T) & terminates(E,F,T) & T<maxstep.

% DEC 11
releasedAt(F,T+1) <- happens(E,T) & releases(E,F,T) & T<maxstep.

% DEC 12
not releasedAt(F,T+1) <- happens(E,T) & 
   (initiates(E,F,T) | terminates(E,F,T)) & T<maxstep.

{holdsAt(F,T)}.
{releasedAt(F,T)}.

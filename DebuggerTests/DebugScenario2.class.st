Class {
	#name : #DebugScenario2,
	#superclass : #DebugScenario,
	#category : #DebuggerTests
}

{ #category : #accessing }
DebugScenario2 >> run [
	| context process session |
	context := [ self start] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'scenario2 session' startedAt: context.
	"stepOver twice. Then the next stepOver causes the Nofication exception raised by step 3 to be caught by the step1 handler, bypassing the special contexts inserted by the stepOver. The debugger displays the start method (caller of step1)"
	
	
	"Transcript crShow: context isDead."
]

{ #category : #accessing }
DebugScenario2 >> start [
	^ self step1
]

{ #category : #accessing }
DebugScenario2 >> step1 [
	[ self step2 ] on: Notification do: [ ^2 ].
]

{ #category : #accessing }
DebugScenario2 >> step2 [
self halt.
	1+1.
	self step3.
	2+2.
	^4
]

{ #category : #accessing }
DebugScenario2 >> step3 [
	self notify: 'hey'
	"self error: 'hey'"
]

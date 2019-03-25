Class {
	#name : #DebugScenario1,
	#superclass : #DebugScenario,
	#category : #DebuggerTests
}

{ #category : #accessing }
DebugScenario1 >> run [
	| context process session |
	context := [ self start] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'scenario1 session' startedAt: context.
	session stepOver.
	session stepOver.
	session inspect.
	"session stepOver."
	
	Transcript crShow: context isDead.
]

{ #category : #accessing }
DebugScenario1 >> start [
	^ self step1
]

{ #category : #accessing }
DebugScenario1 >> step1 [
	^ self step2
]

{ #category : #accessing }
DebugScenario1 >> step2 [
	^ self step3
]

{ #category : #accessing }
DebugScenario1 >> step3 [
	^ 42
]

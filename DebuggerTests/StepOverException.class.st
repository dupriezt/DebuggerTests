Class {
	#name : #StepOverException,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
StepOverException >> setUp [
	super setUp.
	context := [ Error signal: 'hey'. ] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
StepOverException >> testStepOver [
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Error.
]

Class {
	#name : #StepOverHalt,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
StepOverHalt >> setUp [
	super setUp.
	context := [ self halt. ] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
StepOverHalt >> testStepOver [
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Exception.
]

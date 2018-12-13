Class {
	#name : #StepOverDoesNotUnderstand,
	#superclass : #DebuggerTests,
	#instVars : [
		'assistant'
	],
	#category : #DebuggerTests
}

{ #category : #tests }
StepOverDoesNotUnderstand >> setUp [
	super setUp.
	assistant := DebuggerTestsAssistant new.
	context := [ assistant messageNotUnderstood] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
StepOverDoesNotUnderstand >> testStepOver [
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Exception.
]

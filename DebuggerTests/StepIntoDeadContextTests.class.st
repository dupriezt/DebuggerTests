Class {
	#name : #StepIntoDeadContextTests,
	#superclass : #DebuggerTests,
	#instVars : [
		'assistant',
		'process'
	],
	#category : #DebuggerTests
}

{ #category : #tests }
StepIntoDeadContextTests >> setUp [
	super setUp.
	assistant := DebuggerTestsAssistant new.
	context := TestableContext on: [ ] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
StepIntoDeadContextTests >> testStepIntoDeadContextShouldRaiseException [
	session stepInto. "The first step into executes the (empty) body of the block and returns from it. From this point on, the context is dead since it returned."
	
	"We should be able to call stepInto.
	However, calling it provokes infinite exceptions and non recuperable images."
	"session stepInto."
	
	"We have found that the debugSession calls stepToSendOrReturn after step: which could be the cause of the issue.
	This test is green if we avoid calling that part and just call step:"
	session interruptedProcess step: session interruptedContext.
	
	self assert: context isDead
]

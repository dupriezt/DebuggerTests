Class {
	#name : #StepIntoMessageTests,
	#superclass : #DebuggerTests,
	#instVars : [
		'assistant'
	],
	#category : #DebuggerTests
}

{ #category : #tests }
StepIntoMessageTests >> setUp [
	super setUp.
	assistant := DebuggerTestsAssistant new.
	context := ProxyTestableContext on: [ assistant callQuickMethodWithoutReturningItsResult] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
StepIntoMessageTests >> testStepIntoMethodCallShouldActivateIt [
	session stepInto.
	session stepInto.
	self
		assert: process suspendedContext method
		equals: DebuggerTestsAssistant >> #callQuickMethodWithoutReturningItsResult.
]

{ #category : #tests }
StepIntoMessageTests >> testStepIntoQuickMethodCallNotReturnedShouldLeaveTheValueStackEmpty [
	session stepInto.
	session stepInto.
	session stepInto.
	self
		assert: process suspendedContext method
		equals: DebuggerTestsAssistant >> #callQuickMethodWithoutReturningItsResult.
	self
		assert: process suspendedContext size
		equals: 0.
]

Class {
	#name : #StepIntoUsedQuickMethodCallReturnTests,
	#superclass : #TestCase,
	#instVars : [
		'context',
		'session',
		'assistant',
		'process'
	],
	#category : #DebuggerTests
}

{ #category : #tests }
StepIntoUsedQuickMethodCallReturnTests >> setUp [
	super setUp.
	assistant := DebuggerTestsAssistant new.
	context := TestableContext on: [ assistant returnQuickMethodResult] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
StepIntoUsedQuickMethodCallReturnTests >> testStepIntoQuickMethodCallReturnedShouldPushReturnValueToTheStack [
	session stepInto.
	session stepInto.
	session stepInto.
	self
		assert: process suspendedContext method
		equals: DebuggerTestsAssistant >> #returnQuickMethodResult.
	self
		assert: process suspendedContext top
		equals: 1.
]

Class {
	#name : #StepIntoUsedQuickMethodCallReturnTests,
	#superclass : #DebuggerTests,
	#instVars : [
		'assistant'
	],
	#category : #DebuggerTests
}

{ #category : #tests }
StepIntoUsedQuickMethodCallReturnTests >> setUp [
	super setUp.
	assistant := DebuggerTestsAssistant new.
	self settingUpSessionAndProcessAndContextForBlock: [ assistant returnQuickMethodResult]
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

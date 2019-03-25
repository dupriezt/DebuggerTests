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
	self settingUpSessionAndProcessAndContextForBlock: [ assistant messageNotUnderstood]
]

{ #category : #tests }
StepOverDoesNotUnderstand >> testStepOver [
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Exception.
]

Class {
	#name : #ErrorWasInUIProcessTests,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
ErrorWasInUIProcessTests >> setUp [
	super setUp.
	context := [ 1+1] asContext.
	process := Process forContext: context priority: Processor userInterruptPriority.
	session := process newDebugSessionNamed: 'test session' startedAt: context
]

{ #category : #tests }
ErrorWasInUIProcessTests >> testErrorWasInUIProcessIsFalseWhenDebugSessionWasCreatedProgrammatically [
	self assert: (session errorWasInUIProcess not)
]

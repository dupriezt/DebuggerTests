Class {
	#name : #ErrorWasInUIProcessTests2,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
ErrorWasInUIProcessTests2 >> setUp [
	super setUp.
	context := [ 1+1] asContext.
	"process := Process forContext: context priority: Processor userInterruptPriority."
	"Instead of creating a new process like the other debugger tests, we ask the default ui process to create the DebugSession"
	session := UIManager default uiProcess newDebugSessionNamed: 'test session' startedAt: context
]

{ #category : #tests }
ErrorWasInUIProcessTests2 >> testErrorWasInUIProcessIsTrueWhenDebugSessionWasCreatedByTheUIProcess [
	self assert: (session errorWasInUIProcess)
]

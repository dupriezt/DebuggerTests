Class {
	#name : #DebuggerTests,
	#superclass : #TestCase,
	#instVars : [
		'context',
		'session'
	],
	#category : #DebuggerTests
}

{ #category : #tests }
DebuggerTests >> setUp [
	| process |
	super setUp.
	context := TestableContext on: [ |var| var:=4] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
DebuggerTests >> testNewDebugSession [
	self assert: context size equals: 0.
]

{ #category : #tests }
DebuggerTests >> testStepIntoAssignment [
	session stepInto.
	session stepInto.
	self assert: (context tempNamed: 'var') equals: 4.
]

{ #category : #tests }
DebuggerTests >> testStepIntoLiteral [
	session stepInto.
	self assert: context top equals: 4.
]

Class {
	#name : #AssignmentAndLiteralDebuggerTests,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #tests }
AssignmentAndLiteralDebuggerTests >> setUp [
	| process |
	super setUp.
	context := TestableContext on: [ |var| var:=4] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
AssignmentAndLiteralDebuggerTests >> testInterruptedContextEqualsSuspendedContextOfInterruptedProcess [
	self assert: session interruptedContext equals: session interruptedProcess suspendedContext.
	session stepInto.
	session stepInto.
	self assert: session interruptedContext equals: session interruptedProcess suspendedContext.
]

{ #category : #tests }
AssignmentAndLiteralDebuggerTests >> testNewDebugSession [
	self assert: context size equals: 0.
	self assert: session interruptedContext equals: context.
]

{ #category : #tests }
AssignmentAndLiteralDebuggerTests >> testStepIntoAssignment [
	session stepInto.
	session stepInto.
	self assert: (context tempNamed: 'var') equals: 4.
]

{ #category : #tests }
AssignmentAndLiteralDebuggerTests >> testStepIntoLiteral [
	session stepInto.
	self assert: context top equals: 4.
]

{ #category : #tests }
AssignmentAndLiteralDebuggerTests >> testStepOverAssignment [
	session stepOver.
	session stepOver.
	self assert: (context tempNamed: 'var') equals: 4.
]

{ #category : #tests }
AssignmentAndLiteralDebuggerTests >> testStepOverLiteral [
	session stepOver.
	self assert: context top equals: 4.
]

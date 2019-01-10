"
Testing the DebugSession>isLatestContext: method
"
Class {
	#name : #IsLatestContextTest,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
IsLatestContextTest >> setUp [
	super setUp.
	context := [ IsLatestContextTestAssistant method1] asContext.
	process := Process forContext: context priority: Processor userInterruptPriority.
	session := process newDebugSessionNamed: 'test session' startedAt: context
]

{ #category : #tests }
IsLatestContextTest >> testIsLatestContextTest [
	"Checking that a Context that has nothing to do with the debugged execution is not LatestContext"
	self assert: (session isLatestContext: [] asContext) not.
	
	"Checking that context (the starting context of the execution) is the LatestContext until a method is called"
	self assert: (session isLatestContext: context).
	session stepInto.
	self assert: (session isLatestContext: context).
	session stepInto.
	self assert: (session isLatestContext: context) not.
	session stepInto.
	self assert: (session isLatestContext: context) not.
	session stepInto.
	"The called method returned. context is LatestContext again."
	self assert: (session isLatestContext: context).
]

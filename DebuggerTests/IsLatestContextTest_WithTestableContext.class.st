"
Testing the DebugSession>isLatestContext: method, using a TestableContext to wrap the Context in the setup.
This has an impact on the last line of testIsLatestContextTest.
"
Class {
	#name : #'IsLatestContextTest_WithTestableContext',
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
IsLatestContextTest_WithTestableContext >> setUp [
	super setUp.
	context := TestableContext on: [ IsLatestContextTestAssistant method1] asContext.
	process := Process forContext: context priority: Processor userInterruptPriority.
	session := process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
IsLatestContextTest_WithTestableContext >> testIsLatestContextTest [
	"Checking that a Context that has nothing to do with the debugged execution is not LatestContext"
	self assert: (session isLatestContext: [] asContext) not.
	
	"Checking that a Context that has nothing to do with the debugged execution is not LatestContext"
	self assert: (session isLatestContext: context).
	session stepInto.
	self assert: (session isLatestContext: context).
	session stepInto.
	self assert: (session isLatestContext: context) not.
	session stepInto.
	self assert: (session isLatestContext: context) not.
	session stepInto.
	"The called method returned.
	Because the setUp of this test uses a TestableContext to wrap the Context, we have at the following line that context is NOT the LatestContext of the session"
	self assert: (session isLatestContext: context) not.
]

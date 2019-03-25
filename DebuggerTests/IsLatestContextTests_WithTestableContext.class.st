"
Testing the DebugSession>isLatestContext: method, using a TestableContext to wrap the Context in the setup.
This has an impact on the last line of testIsLatestContextTest.
"
Class {
	#name : #'IsLatestContextTests_WithTestableContext',
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
IsLatestContextTests_WithTestableContext >> setUp [
	super setUp.
	self settingUpSessionAndProcessAndContextForBlock: [ IsLatestContextTestAssistant method1]. 
]

{ #category : #tests }
IsLatestContextTests_WithTestableContext >> testIsLatestContextTest [
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
	"The called method returned."
	self assert: (session isLatestContext: context).
]

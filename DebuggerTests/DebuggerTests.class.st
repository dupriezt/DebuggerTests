"
Superclass for classes containing debugger tests.
Provides the ability to send #debuggerOnSetUpSession to a debugger test class to obtain a debugger opened on the debug session set up by that class for its tests.
"
Class {
	#name : #DebuggerTests,
	#superclass : #TestCase,
	#instVars : [
		'context',
		'session'
	],
	#category : #DebuggerTests
}

{ #category : #'as yet unclassified' }
DebuggerTests class >> debuggerOnSetUpSession [
	GTGenericStackDebugger new openOn: (self new setUp session).
]

{ #category : #accessing }
DebuggerTests >> session [
	^ session
]

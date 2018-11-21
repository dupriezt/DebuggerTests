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

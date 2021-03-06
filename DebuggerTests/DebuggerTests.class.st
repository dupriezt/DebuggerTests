"
Superclass for classes containing debugger tests.
Provides the ability to send #debuggerOnSetUpSession to a debugger test class to obtain a debugger opened on the debug session set up by that class for its tests.
"
Class {
	#name : #DebuggerTests,
	#superclass : #TestCase,
	#instVars : [
		'context',
		'session',
		'process'
	],
	#category : #DebuggerTests
}

{ #category : #'as yet unclassified' }
DebuggerTests >> inspectCurrentNode: aDebugSession [
	context := aDebugSession interruptedContext.
	(context method sourceNodeForPC: context pc) inspect.
]

{ #category : #accessing }
DebuggerTests >> session [
	^ session
]

{ #category : #running }
DebuggerTests >> setUp [
	super setUp.
	context := nil.
	process := nil.
	session := nil.
]

{ #category : #'as yet unclassified' }
DebuggerTests >> settingUpSessionAndProcessAndContextForBlock: aBlock [
	context := aBlock asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

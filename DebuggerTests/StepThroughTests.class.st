Class {
	#name : #StepThroughTests,
	#superclass : #DebuggerTests,
	#instVars : [
		'assistant'
	],
	#category : #DebuggerTests
}

{ #category : #running }
StepThroughTests >> setUp [
	super setUp.
	assistant := DebuggerTestsAssistant new.
	"Using a TestableContext instead of a normal Context caused the image to freeze when a step through was executed"
	context := [ assistant stepThroughHelper: [ 'hello' ] ] asContext.
	process := Process 
	    forContext: context 
	    priority: Processor userInterruptPriority.
	session:= process newDebugSessionNamed: 'test session' startedAt: context.
]

{ #category : #tests }
StepThroughTests >> testStepThrough [
	session stepOver.
	session stepOver.
	session stepThrough.
	self assert: (session interruptedContext method) equals: (DebuggerTestsAssistant>>#stepThroughHelper:).
	
]

{ #category : #tests }
StepThroughTests >> testStepThroughDoesTheSameThingAsStepOverWhenNoBlockReturns [
	|pcStepOver pcStepThrough|
	session stepOver.
	session stepOver.
	pcStepOver := session interruptedContext pc.
	self setUp.
	session stepThrough.
	session stepThrough.
	pcStepThrough := session interruptedContext pc.
	self assert: pcStepOver equals: pcStepThrough.
]

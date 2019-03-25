Class {
	#name : #StepThroughTests,
	#superclass : #DebuggerTests,
	#instVars : [
		'assistant'
	],
	#category : #DebuggerTests
}

{ #category : #helper }
StepThroughTests >> evalBlockThenReturnOne: aBlock [
	aBlock value.
	^1.
]

{ #category : #running }
StepThroughTests >> setUp [
	super setUp.
	"Using a TestableContext instead of a normal Context caused the image to freeze when a step through was executed"
	self settingUpSessionAndProcessAndContextForBlock: [ self evalBlockThenReturnOne: [ 'hello' ] ].
]

{ #category : #tests }
StepThroughTests >> testStepThrough [
	session stepOver.
	session stepOver.
	session stepThrough.
	self assert: (session interruptedContext method) equals: (self class>>#evalBlockThenReturnOne:).
	
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

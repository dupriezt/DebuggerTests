Class {
	#name : #StepThroughTests,
	#superclass : #DebuggerTests,
	#instVars : [
		'assistant'
	],
	#category : #DebuggerTests
}

{ #category : #helper }
StepThroughTests >> doSomething [
	^ 2+2
]

{ #category : #helper }
StepThroughTests >> evalBlockThenReturnOne: aBlock [
	aBlock value.
	^1.
]

{ #category : #running }
StepThroughTests >> setUp [
	super setUp.
	"Using a TestableContext instead of a normal Context caused the image to freeze when a step through was executed"
	self settingUpSessionAndProcessAndContextForBlock: [ self evalBlockThenReturnOne: [ self doSomething ] ].
]

{ #category : #running }
StepThroughTests >> stepA1 [
	self evalBlockThenReturnOne: [ self stepA2 ].
]

{ #category : #helper }
StepThroughTests >> stepA2 [
	^ 2+2
]

{ #category : #tests }
StepThroughTests >> testStepThrough [
	"In a context c, define a block b, send a message to another method to get b evaluated.
	Testing that a step through on this message send moves the execution to the point where the block b is about to be evaluated."
	| node |
	self settingUpSessionAndProcessAndContextForBlock: [ self stepA1 ].
	session stepInto.
	session stepInto.
	session stepInto.
	"Reached node 'self evalBlockThenReturnOne: [self stepA2]' of method stepA1"
	"Checking that the execution is indeed at this node"
	self assert: (session interruptedContext method) equals: (self class>>#stepA1).
	node := self class>>#stepA1 sourceNodeForPC: session interruptedContext pc.
	self assert: node isMessage.
	self assert: node receiver isSelf.
	self assert: node selector equals: #evalBlockThenReturnOne:.
	session stepThrough.
	"Checking that after the step through, the execution is at the 'self stepA2' node of the stepA1 method"
	self assert: (session interruptedContext method) equals: (self class>>#stepA1).
	node := self class>>#stepA1 sourceNodeForPC: session interruptedContext pc.
	self assert: node isMessage.
	self assert: node receiver isSelf.
	self assert: node selector equals: #stepA2.
	
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

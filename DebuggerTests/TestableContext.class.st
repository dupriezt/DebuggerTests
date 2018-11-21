Class {
	#name : #TestableContext,
	#superclass : #TestableInstructionStream,
	#instVars : [
		'messages'
	],
	#category : #'DebuggerTests-TestableContexts'
}

{ #category : #'instance creation' }
TestableContext class >> on: aContext [ 
	
	^ self new
		realContext: aContext;
		yourself
]

{ #category : #thingsCalledByDebugger }
TestableContext >> bottomContext [
	
	^ self testableContextFor: realContext bottomContext
]

{ #category : #thingsCalledByDebugger }
TestableContext >> findNextUnwindContextUpTo: anObject [
	
	self assert: anObject isNil.
	^ self testableContextFor: (realContext findNextUnwindContextUpTo: anObject)
]

{ #category : #testing }
TestableContext >> isBottomContext [
	
	^ realContext isBottomContext
]

{ #category : #testing }
TestableContext >> isDead [
	
	^ realContext isDead
]

{ #category : #accessing }
TestableContext >> method [

	^ realContext method
]

{ #category : #accessing }
TestableContext >> methodClass [
	
	^ realContext methodClass
]

{ #category : #accessing }
TestableContext >> pc: aPC [
	
	realContext pc: aPC
]

{ #category : #thingsCalledByDebugger }
TestableContext >> receiver [
	
	^ realContext receiver
]

{ #category : #thingsCalledByDebugger }
TestableContext >> return: value from: aSender [

	self assert: (aSender isKindOf: TestableContext).
	^ self testableContextFor: (realContext return: value from: aSender realContext)
]

{ #category : #accessing }
TestableContext >> selector [
	
	^ realContext selector
]

{ #category : #thingsCalledByDebugger }
TestableContext >> sender [
	
	^ self testableContextFor: realContext sender
]

{ #category : #accessing }
TestableContext >> sourceCode [
	
	^ realContext sourceCode
]

{ #category : #accessing }
TestableContext >> stack [
	
	^ realContext stack
]

{ #category : #accessing }
TestableContext >> stackOfSize: limit [ 
	
	^ realContext stackOfSize: limit 
]

{ #category : #thingsCalledByDebugger }
TestableContext >> step [

	^ self testableContextFor: realContext step.
]

{ #category : #thingsCalledByDebugger }
TestableContext >> stepToSendOrReturn [

	^ self testableContextFor: realContext stepToSendOrReturn
]

{ #category : #accessing }
TestableContext >> tempAt: anInteger [ 
	
	^ realContext tempAt: anInteger
]

{ #category : #accessing }
TestableContext >> tempNamed: aString [
	
	^ realContext tempNamed: aString
]

{ #category : #accessing }
TestableContext >> top [
	
	^ realContext top
]

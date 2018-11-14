Class {
	#name : #TestableContext,
	#superclass : #Object,
	#instVars : [
		'realContext',
		'cache'
	],
	#category : #DebuggerTests
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
TestableContext >> findContextSuchThat: testBlock [ 
	
	"I had to reimplement this in here because users may do context identity comparison (see calleeOf:).
	And TestableContexts are wrappers..."
	| context |
	context := self.
	[ context isNil ] whileFalse: [
		(testBlock value: context) 
			ifTrue: [ ^ context ].
		context := context sender ].
	^ nil
]

{ #category : #thingsCalledByDebugger }
TestableContext >> findNextUnwindContextUpTo: anObject [
	
	self assert: anObject isNil.
	^ self testableContextFor: (realContext findNextUnwindContextUpTo: anObject)
]

{ #category : #thingsCalledByDebugger }
TestableContext >> initialize [
	
	super initialize.
	cache := Dictionary new.
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
TestableContext >> pc: aPC [
	
	realContext pc: aPC
]

{ #category : #accessing }
TestableContext >> realContext [

	^ realContext
]

{ #category : #accessing }
TestableContext >> realContext: aContext [ 
	realContext := aContext
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

{ #category : #thingsCalledByDebugger }
TestableContext >> sender [
	
	^ self testableContextFor: realContext sender
]

{ #category : #accessing }
TestableContext >> size [

	^ realContext size
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

{ #category : #helpers }
TestableContext >> testableContextFor: aRealContext [

	| newTestableContext |
	aRealContext ifNil: [ ^ nil ].
	aRealContext == realContext ifTrue: [ ^ self ].
	cache at: aRealContext ifPresent: [  :testableContext | ^ testableContext ].
	
	newTestableContext := TestableContext on: aRealContext.
	newTestableContext useCache: cache.
	^ newTestableContext
]

{ #category : #accessing }
TestableContext >> top [
	
	^ realContext top
]

{ #category : #helpers }
TestableContext >> useCache: aCache [

	cache := aCache.
	cache at: realContext put: self.
]

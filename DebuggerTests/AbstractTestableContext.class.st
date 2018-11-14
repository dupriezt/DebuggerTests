Class {
	#name : #AbstractTestableContext,
	#superclass : #Object,
	#instVars : [
		'realContext',
		'cache'
	],
	#category : #DebuggerTests
}

{ #category : #'instance creation' }
AbstractTestableContext class >> on: aContext [ 
	
	^ self new
		realContext: aContext;
		yourself
]

{ #category : #thingsCalledByDebugger }
AbstractTestableContext >> findContextSuchThat: testBlock [ 
	
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

{ #category : #helpers }
AbstractTestableContext >> initialize [
	
	super initialize.
	cache := Dictionary new.
]

{ #category : #accessing }
AbstractTestableContext >> realContext [

	^ realContext
]

{ #category : #accessing }
AbstractTestableContext >> realContext: aContext [ 
	realContext := aContext
]

{ #category : #accessing }
AbstractTestableContext >> size [

	^ realContext size
]

{ #category : #helpers }
AbstractTestableContext >> testableContextFor: aRealContext [

	| newTestableContext |
	aRealContext ifNil: [ ^ nil ].
	aRealContext == realContext ifTrue: [ ^ self ].
	cache at: aRealContext ifPresent: [  :testableContext | ^ testableContext ].
	
	newTestableContext := self class on: aRealContext.
	newTestableContext useCache: cache.
	^ newTestableContext
]

{ #category : #helpers }
AbstractTestableContext >> useCache: aCache [

	cache := aCache.
	cache at: realContext put: self.
]

Class {
	#name : #TracingTestableContext,
	#superclass : #ProxyTestableContext,
	#instVars : [
		'messages'
	],
	#category : #'DebuggerTests-TestableContexts'
}

{ #category : #'reflective operations' }
TracingTestableContext >> doPerform: aSelector withArguments: arguments [

	messages add: aSelector.
	^ super doPerform: aSelector withArguments: arguments.
]

{ #category : #'reflective operations' }
TracingTestableContext >> initialize [

	super initialize.
	messages := OrderedCollection new.
]

{ #category : #'reflective operations' }
TracingTestableContext >> messages [

	^ messages
]

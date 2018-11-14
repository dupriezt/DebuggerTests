Class {
	#name : #ProxyTestableContext,
	#superclass : #AbstractTestableContext,
	#category : #DebuggerTests
}

{ #category : #'reflective operations' }
ProxyTestableContext >> doPerform: aMessage [

	^ self doPerform: aMessage withArguments: #()
]

{ #category : #'reflective operations' }
ProxyTestableContext >> doPerform: aSelector withArguments: arguments [

	^ realContext perform: aSelector withArguments: arguments
]

{ #category : #'reflective operations' }
ProxyTestableContext >> doesNotUnderstand: aMessage [

	| newArguments result |
	newArguments := aMessage arguments collect: [ :each |
		(each isKindOf: ProxyTestableContext)
			ifTrue: [ each realContext ]
			ifFalse: [ each ] ].

	result := self doPerform: aMessage selector withArguments: newArguments.
	
	(result isKindOf: Context) ifFalse: [ ^ result ].
	^ self testableContextFor: result.
]

{ #category : #'reflective operations' }
ProxyTestableContext >> size [

	^ self doPerform: #size
]

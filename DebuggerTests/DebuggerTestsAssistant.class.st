Class {
	#name : #DebuggerTestsAssistant,
	#superclass : #Object,
	#category : #DebuggerTests
}

{ #category : #'accessing structure variables' }
DebuggerTestsAssistant >> callQuickMethodWithoutReturningItsResult [
	self quickMethod.
]

{ #category : #'accessing structure variables' }
DebuggerTestsAssistant >> quickMethod [
	^1.
]

{ #category : #'accessing structure variables' }
DebuggerTestsAssistant >> returnQuickMethodResult [
	^ self quickMethod.
]

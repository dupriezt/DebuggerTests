Class {
	#name : #ErrorWasInUIProcessTests,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
ErrorWasInUIProcessTests >> setUp [
	super setUp.
	self settingUpSessionAndProcessAndContextForBlock: [ 1+1].
]

{ #category : #tests }
ErrorWasInUIProcessTests >> testErrorWasInUIProcessIsFalseWhenDebugSessionWasCreatedProgrammatically [
	self assert: (session errorWasInUIProcess not)
]

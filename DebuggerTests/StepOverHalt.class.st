Class {
	#name : #StepOverHalt,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #running }
StepOverHalt >> setUp [
	super setUp.
	self settingUpSessionAndProcessAndContextForBlock: [ self halt. ]
]

{ #category : #tests }
StepOverHalt >> testStepOver [
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Exception.
]

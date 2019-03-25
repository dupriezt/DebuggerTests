Class {
	#name : #StepOverException,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #pages }
StepOverException >> step1 [
	self step2.
]

{ #category : #pages }
StepOverException >> step2 [
	[ self step3 ] on: Notification do: [ ^2 ].
]

{ #category : #pages }
StepOverException >> step3 [
	self step4.
	^4
]

{ #category : #pages }
StepOverException >> step4 [
	self notify: 'hey'
]

{ #category : #tests }
StepOverException >> testErrorSignalledDuringStepOverShouldBeCaught [
	self settingUpSessionAndProcessAndContextForBlock: [ Error signal: 'hey'. ].
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Error.
]

{ #category : #tests }
StepOverException >> testStepOverNonErrorExceptionSignalWithHandlerDeeperInTheContextStack [
	"Context stack (from top to bottom) of the execution:
	self step4 | signal a Notification exception
	self step3 | just calls step 4. Point at which this test performs the stepOver
	self step2 | has a handler for Notification exceptions
	self step1 | just calls step2
	
	When doing a stepOver at step3, the session jumps to step1.
	The Notification exception was used because it is an exception that is not a subclass of Error, and iis therefore not caught by the handler context stepOver inserts between step2 and 3 (which handles Error)
	"
	self settingUpSessionAndProcessAndContextForBlock: [ self step1 ].
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	"Reached the beginning of the step3 method call. Now doing a stepOver"
	session stepOver.
	"The DebugSession jumped to the step1 method call"
	self assert: session interruptedContext method equals: self class >>#step1
]

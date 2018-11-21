Class {
	#name : #TestableInstructionStream,
	#superclass : #AbstractTestableContext,
	#category : #'DebuggerTests-TestableContexts'
}

{ #category : #accessing }
TestableInstructionStream >> debuggerMap [
	
	^ realContext debuggerMap
]

{ #category : #accessing }
TestableInstructionStream >> pc [
	
	^ realContext pc
]

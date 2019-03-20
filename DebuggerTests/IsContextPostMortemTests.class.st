Class {
	#name : #IsContextPostMortemTests,
	#superclass : #DebuggerTests,
	#category : #DebuggerTests
}

{ #category : #'pseudo actions' }
IsContextPostMortemTests >> doSomething [
	^ self doSomething2
]

{ #category : #'pseudo actions' }
IsContextPostMortemTests >> doSomething2 [
	^ 42
]

{ #category : #running }
IsContextPostMortemTests >> setUp [
	super setUp.
	context := [ self doSomething ] asContext.
	process := Process forContext: context priority: Processor userInterruptPriority.
	session := process newDebugSessionNamed: 'test session' startedAt: context
]

{ #category : #tests }
IsContextPostMortemTests >> testIsContextPostMortem [
	session stepInto.
	"The top context of the context chain is not post mortem"
	self assert: (session isContextPostMortem: session interruptedProcess suspendedContext) not.
	"A context from the context chain is not post mortem"
	self assert: (session isContextPostMortem: context) not.
	"A context not from the context chain is post mortem..."
	self assert: (session isContextPostMortem: [2] asContext).
	process suspendedContext: nil.
	"...unless the process' suspended context is nil, in which case, no context is post mortem"
	self assert: (session isContextPostMortem: [2] asContext) not.
]

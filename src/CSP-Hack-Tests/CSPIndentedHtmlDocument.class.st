"
I am an indented HTML document to make debugging CSP errors easier.
"
Class {
	#name : #CSPIndentedHtmlDocument,
	#superclass : #CSPHtmlDocument,
	#instVars : [
		'indentLevel',
		'indentCloseTags',
		'firstLine'
	],
	#category : #'CSP-Hack-Tests'
}

{ #category : #writing }
CSPIndentedHtmlDocument >> closeTag: aString [
	indentLevel := indentLevel - 1.
	indentCloseTags removeLast
		ifTrue: [ self indent ].
	super closeTag: aString
]

{ #category : #private }
CSPIndentedHtmlDocument >> indent [
	firstLine
		ifTrue: [ firstLine := false ]
		ifFalse: [ stream crlf ].
	indentLevel timesRepeat: [ self nextPutAll: '  ' ]
]

{ #category : #initialization }
CSPIndentedHtmlDocument >> initializeWithStream: aStream codec: aCodec [
	super initializeWithStream: aStream codec: aCodec.
	indentCloseTags := OrderedCollection with: false.
	indentLevel := 0.
	firstLine := true
]

{ #category : #writing }
CSPIndentedHtmlDocument >> openTag: aString attributes: anAttributes closed: aBoolean [
	self indent.

	super openTag: aString attributes: anAttributes closed: aBoolean.

	indentCloseTags
		removeLast;
		addLast: true;
		addLast: aBoolean
]

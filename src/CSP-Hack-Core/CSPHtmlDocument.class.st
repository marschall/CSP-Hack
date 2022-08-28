"
I make sure a nonce is added to every <script> element that does not already have it.
"
Class {
	#name : #CSPHtmlDocument,
	#superclass : #WAHtmlDocument,
	#category : #'CSP-Hack-Core'
}

{ #category : #writing }
CSPHtmlDocument >> openTag: aString attributes: anAttributes closed: aBoolean [
	| attributes |
	attributes := anAttributes.
	aString = 'script' ifTrue: [
		attributes := attributes ifNil: [ WAHtmlAttributes new ].
		attributes at: 'nonce' ifAbsentPut: [ self requestContext cspNonce ] ].
	
	super openTag: aString attributes: attributes closed: aBoolean
]

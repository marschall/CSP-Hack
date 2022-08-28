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
		attributes isNil ifTrue: [
			attributes := WAHtmlAttributes new ].
		(attributes includesKey: 'nonce') ifFalse: [
			attributes at: 'nonce' put: self requestContext cspNonce ] ].
	
	super openTag: aString attributes: attributes closed: aBoolean
]

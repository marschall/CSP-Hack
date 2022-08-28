"
I make it possible to change the document class of an application to CSPHtmlDocument since the following does not work

	anApplicaiton preferenceAt: #documentClass put: (GRPlatform current bindingOf: CSPHtmlDocument)
"
Class {
	#name : #CSPRenderPhaseContinuation,
	#superclass : #WARenderPhaseContinuation,
	#category : #'CSP-Hack-Core'
}

{ #category : #accessing }
CSPRenderPhaseContinuation >> documentClass [
	^ CSPHtmlDocument
]

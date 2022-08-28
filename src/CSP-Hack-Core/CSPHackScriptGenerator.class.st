"
I add a nonce to every script element.
"
Class {
	#name : #CSPHackScriptGenerator,
	#superclass : #JQScriptGenerator,
	#category : #'CSP-Hack-Core'
}

{ #category : #writing }
CSPHackScriptGenerator >> writeScriptTag: aBlock on: aDocument [
	"Utitlity method to properly wrap the script generation code in aBlock onto aDocument."

	| attributes |
	attributes := WAHtmlAttributes new
		at: 'type' put: 'text/javascript';
		at: 'nonce' put: self requestContext cspNonce;
		yourself.
	aDocument openTag: 'script' attributes: attributes.
	aBlock value.
	aDocument closeTag: 'script'
]

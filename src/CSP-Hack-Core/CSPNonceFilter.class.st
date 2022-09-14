"
I generate a nonce for every request, store it in the request context and generate a CSP HTTP header.
"
Class {
	#name : #CSPNonceFilter,
	#superclass : #WARequestFilter,
	#instVars : [
		'keyGenerator'
	],
	#category : #'CSP-Hack-Core'
}

{ #category : #private }
CSPNonceFilter >> addNonceTo: aRequestContext [
	| nonce |
	nonce := self generateNonce.
	aRequestContext cspNonce: nonce.
	
	aRequestContext response
		headerAt: 'Content-Security-Policy'
		put: (self generateHeaderFromNonce: nonce).
]

{ #category : #private }
CSPNonceFilter >> generateHeaderFromNonce: aString [
	"Answer the value of the Content-Security-Policy header given a nonce"
	
	"https://bugzilla.mozilla.org/show_bug.cgi?id=1648057
	https://stackoverflow.com/questions/63372491/content-security-policy-csp-blocking-valid-nonce-in-firefox"
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'script-src ''strict-dynamic'' ''nonce-';
			nextPutAll: aString;
			nextPutAll: '''; default-src ''self'';' ]
]

{ #category : #private }
CSPNonceFilter >> generateNonce [
	^ keyGenerator keyOfLength: self nonceSize
]

{ #category : #processing }
CSPNonceFilter >> handleFiltered: aRequestContext [
	(self shouldAddNonceTo: aRequestContext) ifTrue: [
		self addNonceTo: aRequestContext ].
	super handleFiltered: aRequestContext
]

{ #category : #initialization }
CSPNonceFilter >> initialize [
	super initialize.
	keyGenerator := WAKeyGenerator new
		space: self nonceSpace;
		yourself
]

{ #category : #accessing }
CSPNonceFilter >> nonceSize [
	^ 16
]

{ #category : #accessing }
CSPNonceFilter >> nonceSpace [
	^ 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
]

{ #category : #processing }
CSPNonceFilter >> shouldAddNonceTo: aRequestContext [
	| request |
	request := aRequestContext request.
	^ request isGet and: [ request isXmlHttpRequest not ]
]

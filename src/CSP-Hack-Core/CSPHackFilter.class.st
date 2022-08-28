"
I generate a nonce for every request, store it in the request context and generate a CSP HTTP header.
"
Class {
	#name : #CSPHackFilter,
	#superclass : #WARequestFilter,
	#instVars : [
		'keyGenerator'
	],
	#category : #'CSP-Hack-Core'
}

{ #category : #private }
CSPHackFilter >> addNonceTo: aRequestContext [
	| nonce csp |
	nonce := self generateNonce.
	aRequestContext cspNonce: nonce.
	
	"https://bugzilla.mozilla.org/show_bug.cgi?id=1648057
	https://stackoverflow.com/questions/63372491/content-security-policy-csp-blocking-valid-nonce-in-firefox"
	csp := String streamContents: [ :stream |
		stream
			nextPutAll: 'script-src ''strict-dynamic'' ''nonce-';
			nextPutAll: nonce;
			nextPutAll: '''; default-src ''self'';' ].
	
	aRequestContext response headerAt: 'Content-Security-Policy' put: csp.
]

{ #category : #private }
CSPHackFilter >> generateNonce [
	^ keyGenerator keyOfLength: self nonceSize
]

{ #category : #processing }
CSPHackFilter >> handleFiltered: aRequestContext [
	aRequestContext request isGet ifTrue: [
		self addNonceTo: aRequestContext ].
	super handleFiltered: aRequestContext
]

{ #category : #initialization }
CSPHackFilter >> initialize [
	super initialize.
	keyGenerator := WAKeyGenerator new
		space: self nonceSpace;
		yourself
]

{ #category : #accessing }
CSPHackFilter >> nonceSize [
	^ 16
]

{ #category : #accessing }
CSPHackFilter >> nonceSpace [
	^ 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
]

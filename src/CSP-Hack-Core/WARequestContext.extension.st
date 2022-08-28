Extension { #name : #WARequestContext }

{ #category : #'*CSP-Hack-Core' }
WARequestContext >> cspNonce [
	^ self properties at: #cspNonce ifAbsent: [ nil ]
]

{ #category : #'*CSP-Hack-Core' }
WARequestContext >> cspNonce: aString [
	^ self properties at: #cspNonce put: aString
]

Class {
	#name : #CSPHackCounterFunctionalTest,
	#superclass : #WAComponent,
	#instVars : [
		'count'
	],
	#category : #'CSP-Hack-Tests'
}

{ #category : #initialization }
CSPHackCounterFunctionalTest >> initialize [
	super initialize.
	count := 0
]

{ #category : #rendering }
CSPHackCounterFunctionalTest >> renderContentOn: html [
	html paragraph: [
		html anchor
			url: '';
			onClick: (((html jQuery: #count) load
				html: [ :h | h render: (count := count - 1) ]),
				html jQuery event preventDefault);
			with: '--'.
		html span
			id: #count;
			with: count.
		html anchor
			url: '';
			onClick: (((html jQuery: #count) load
				html: [ :h | h render: (count := count + 1) ]),
				html jQuery event preventDefault);
			with: '++' ]
]

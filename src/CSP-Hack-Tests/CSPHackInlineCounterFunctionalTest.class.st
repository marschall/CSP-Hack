Class {
	#name : #CSPHackInlineCounterFunctionalTest,
	#superclass : #WAComponent,
	#instVars : [
		'count'
	],
	#category : #'CSP-Hack-Tests'
}

{ #category : #initialization }
CSPHackInlineCounterFunctionalTest >> initialize [
	super initialize.
	count := 0
]

{ #category : #rendering }
CSPHackInlineCounterFunctionalTest >> renderContentOn: html [
	html paragraph: [
		html anchor
			url: '';
			onClick: (
				((html jQuery: #count) load html: [ :h |
					h render: (count := count - 1).
					h script: 'console.log("down")' ]),
					html jQuery event preventDefault);
			with: '--'.
			
		html span
			id: #count;
			with: count.
	
		html anchor
			url: '';
			onClick: (
				(html jQuery ajax script: [ :s |
					s << (
						(s jQuery: #count) html: [ :h |
							h render: (count := count + 1).
							h script: 'console.log("up")' ]
							yourself).

					s << (
						(s jQuery: #button) html: [ :h |
							count = 0 ifFalse: [
								h button
									bePush;
									onClick: (
										h jQuery getScript script: [ :ss |
											ss << (JSStream on: 'console.log("reset")').
											ss << (ss jQuery: #button) empty.
											ss << (
												(ss jQuery: #count) load
													html: [ :hh | hh render: (count := 0) ]) ]);
												with: 'Reset' ] ]) ]),
						html jQuery event preventDefault);
			with: '++'.
			html span id: #button ]
]

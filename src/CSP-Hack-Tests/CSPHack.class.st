Class {
	#name : #CSPHack,
	#superclass : #WAObject,
	#category : #'CSP-Hack-Tests'
}

{ #category : #actions }
CSPHack class >> install [
	^ (WAAdmin register: CSPHackCounterFunctionalTest asApplicationAt: 'tests/csp-hack')	
		preferenceAt: #scriptGeneratorClass put: JQScriptGenerator;
		preferenceAt: #renderPhaseContinuationClass put: (GRPlatform current bindingOf: CSPRenderPhaseContinuation);
		preferenceAt: #rootDecorationClasses put: Array new;
		addFilter: CSPNonceFilter new;
		addLibrary: JQDeploymentLibrary;
		yourself
]

{ #category : #actions }
CSPHack class >> installDebug [
	^ (WAAdmin register: CSPHackCounterFunctionalTest asApplicationAt: 'tests/csp-hack')	
		preferenceAt: #scriptGeneratorClass put: JQScriptGenerator;
		preferenceAt: #renderPhaseContinuationClass put: (GRPlatform current bindingOf: CSPIndentedRenderPhaseContinuation);
		preferenceAt: #rootDecorationClasses put: Array new;
		addFilter: CSPNonceFilter new;
		addLibrary: JQDeploymentLibrary;
		yourself
]

{ #category : #actions }
CSPHack class >> installInline [
	^ (WAAdmin register: CSPHackInlineCounterFunctionalTest asApplicationAt: 'tests/csp-hack-inline')	
		preferenceAt: #scriptGeneratorClass put: JQScriptGenerator;
		preferenceAt: #renderPhaseContinuationClass put: (GRPlatform current bindingOf: CSPRenderPhaseContinuation);
		preferenceAt: #rootDecorationClasses put: Array new;
		addFilter: CSPNonceFilter new;
		addLibrary: JQDeploymentLibrary;
		yourself
]

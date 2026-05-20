Class {
	#name : 'Customer',
	#superclass : 'Object',
	#instVars : [
		'name',
		'monthlyFee',
		'calls'
	],
	#category : 'Mercap-Billing',
	#package : 'Mercap-Billing'
}

{ #category : 'as yet unclassified' }
Customer class >> name: aName monthlyFee: aFee [
    ^ self new
        setName: aName monthlyFee: aFee;
        yourself
]

{ #category : 'initialization' }
Customer >> calls [
    ^ calls
]

{ #category : 'initialization' }
Customer >> callsInMonth: aMonth year: aYear [
    ^ calls select: [ :each | each wasMadeInMonth: aMonth year: aYear ]
]

{ #category : 'initialization' }
Customer >> monthlyFee [
    ^ monthlyFee
]

{ #category : 'initialization' }
Customer >> name [
    ^ name
]

{ #category : 'initialization' }
Customer >> registerCall: aCall [
    calls add: aCall
]

{ #category : 'initialization' }
Customer >> setName: aName monthlyFee: aFee [
    name := aName.
    monthlyFee := aFee.
    calls := OrderedCollection new
]

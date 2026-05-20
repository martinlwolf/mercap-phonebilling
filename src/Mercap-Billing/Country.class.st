Class {
	#name : 'Country',
	#superclass : 'Object',
	#instVars : [
		'name',
		'ratePerMinute'
	],
	#category : 'Mercap-Billing',
	#package : 'Mercap-Billing'
}

{ #category : 'as yet unclassified' }
Country class >> name: aName ratePerMinute: aRate [
    ^ self new
        setName: aName ratePerMinute: aRate;
        yourself
]

{ #category : 'initialization' }
Country >> name [
    ^ name
]

{ #category : 'initialization' }
Country >> ratePerMinute [
    ^ ratePerMinute
]

{ #category : 'initialization' }
Country >> setName: aName ratePerMinute: aRate [
    name := aName.
    ratePerMinute := aRate
]

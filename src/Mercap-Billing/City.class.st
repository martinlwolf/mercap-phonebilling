Class {
	#name : 'City',
	#superclass : 'Object',
	#instVars : [
		'name',
		'ratePerMinute'
	],
	#category : 'Mercap-Billing',
	#package : 'Mercap-Billing'
}

{ #category : 'as yet unclassified' }
City class >> name: aName ratePerMinute: aRate [
    ^ self new
        setName: aName ratePerMinute: aRate;
        yourself
]

{ #category : 'accessing' }
City >> name [
    ^ name
]

{ #category : 'accessing' }
City >> ratePerMinute [
    ^ ratePerMinute
]

{ #category : 'initialization' }
City >> setName: aName ratePerMinute: aRate [
    name := aName.
    ratePerMinute := aRate
]

Class {
	#name : 'Call',
	#superclass : 'Object',
	#instVars : [
		'durationInMinutes',
		'dateTime'
	],
	#category : 'Mercap-Billing',
	#package : 'Mercap-Billing'
}

{ #category : 'initialization' }
Call >> cost [
    ^ self subclassResponsibility
]

{ #category : 'initialization' }
Call >> dateTime [
    ^ dateTime
]

{ #category : 'initialization' }
Call >> description [
    ^ self subclassResponsibility
]

{ #category : 'initialization' }
Call >> durationInMinutes [
    ^ durationInMinutes
]

{ #category : 'initialization' }
Call >> initializeDuration: minutes dateTime: aDateTime [
    durationInMinutes := minutes.
    dateTime := aDateTime
]

{ #category : 'initialization' }
Call >> wasMadeInMonth: aMonth year: aYear [
    ^ dateTime month = aMonth and: [ dateTime year = aYear ]
]

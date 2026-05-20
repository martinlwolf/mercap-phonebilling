Class {
	#name : 'InternationalCall',
	#superclass : 'Call',
	#instVars : [
		'destinationCountry'
	],
	#category : 'Mercap-Billing',
	#package : 'Mercap-Billing'
}

{ #category : 'as yet unclassified' }
InternationalCall class >> duration: minutes dateTime: aDateTime country: aCountry [
    ^ self new
        initializeDuration: minutes dateTime: aDateTime country: aCountry;
        yourself
]

{ #category : 'initialization' }
InternationalCall >> cost [
    ^ durationInMinutes * (destinationCountry ratePerMinute)
]

{ #category : 'initialization' }
InternationalCall >> description [
    ^ 'International call to ', destinationCountry name, 
      ' (', durationInMinutes printString, ' min) - $', self cost printString
]

{ #category : 'initialization' }
InternationalCall >> destinationCountry [
    ^ destinationCountry
]

{ #category : 'initialization' }
InternationalCall >> initializeDuration: minutes dateTime: aDateTime country: aCountry [
    self initializeDuration: minutes dateTime: aDateTime.
    destinationCountry := aCountry
]

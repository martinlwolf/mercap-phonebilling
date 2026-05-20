Class {
	#name : 'NationalCall',
	#superclass : 'Call',
	#instVars : [
		'destinationCity'
	],
	#category : 'Mercap-Billing',
	#package : 'Mercap-Billing'
}

{ #category : 'as yet unclassified' }
NationalCall class >> duration: minutes dateTime: aDateTime city: aCity [
    ^ self new
        initializeDuration: minutes dateTime: aDateTime city: aCity;
        yourself
]

{ #category : 'initialization' }
NationalCall >> cost [
    ^ durationInMinutes * (destinationCity ratePerMinute)
]

{ #category : 'initialization' }
NationalCall >> description [
    ^ 'National call to ', destinationCity name, 
      ' (', durationInMinutes printString, ' min) - $', self cost printString
]

{ #category : 'initialization' }
NationalCall >> destinationCity [
    ^ destinationCity
]

{ #category : 'initialization' }
NationalCall >> initializeDuration: minutes dateTime: aDateTime city: aCity [
    super initializeDuration: minutes dateTime: aDateTime.
    destinationCity := aCity
]

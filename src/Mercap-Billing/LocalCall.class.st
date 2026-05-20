Class {
	#name : 'LocalCall',
	#superclass : 'Call',
	#category : 'Mercap-Billing',
	#package : 'Mercap-Billing'
}

{ #category : 'as yet unclassified' }
LocalCall class >> duration: minutes dateTime: aDateTime [
    ^ self new
        initializeDuration: minutes dateTime: aDateTime;
        yourself
]

{ #category : 'as yet unclassified' }
LocalCall class >> offPeakRate [
    ^ 0.10
]

{ #category : 'as yet unclassified' }
LocalCall class >> peakRate [
    ^ 0.20
]

{ #category : 'initialization' }
LocalCall >> cost [
    ^ durationInMinutes * self ratePerMinute
]

{ #category : 'as yet unclassified' }
LocalCall >> description [
    ^ 'Local call on ', dateTime printString, 
      ' (', durationInMinutes printString, ' min) - $', self cost printString
]

{ #category : 'as yet unclassified' }
LocalCall >> isDaytime [
    | hour |
    hour := dateTime hour.
    ^ hour >= 8 and: [ hour < 20 ]
]

{ #category : 'as yet unclassified' }
LocalCall >> isInPeakHours [
    "Weekday between 8:00 and 20:00"
    ^ self isWeekday and: [ self isDaytime ]
]

{ #category : 'as yet unclassified' }
LocalCall >> isWeekday [
    ^ (#(#Saturday #Sunday) includes: dateTime dayOfWeekName asSymbol) not
]

{ #category : 'as yet unclassified' }
LocalCall >> ratePerMinute [
    ^ self isInPeakHours
        ifTrue: [ self class peakRate ]
        ifFalse: [ self class offPeakRate ]
]

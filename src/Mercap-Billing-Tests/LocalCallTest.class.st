Class {
	#name : 'LocalCallTest',
	#superclass : 'TestCase',
	#category : 'Mercap-Billing-Tests',
	#package : 'Mercap-Billing-Tests'
}

{ #category : 'tests' }
LocalCallTest >> testCostAtPeakEndBoundaryIsOffPeak [
    "Monday at exactly 20:00 should be off-peak"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 20 minute: 0 second: 0).
    self assert: call cost closeTo: 1.0
]

{ #category : 'tests' }
LocalCallTest >> testCostAtPeakStartBoundary [
    "Monday at exactly 8:00 should be peak rate"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 8 minute: 0 second: 0).
    self assert: call cost closeTo: 2.0
]

{ #category : 'tests' }
LocalCallTest >> testCostJustBeforePeakEndIsPeak [
    "Monday at 19:59 should still be peak"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 19 minute: 59 second: 0).
    self assert: call cost closeTo: 2.0
]

{ #category : 'tests' }
LocalCallTest >> testCostJustBeforePeakStartIsOffPeak [
    "Monday at 7:59 should still be off-peak"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 7 minute: 59 second: 0).
    self assert: call cost closeTo: 1.0
]

{ #category : 'tests' }
LocalCallTest >> testCostOnSaturdayAlwaysOffPeak [
    "Saturday 10am should still be off-peak"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 9 hour: 10 minute: 0 second: 0).
    self assert: call cost closeTo: 1.0
]

{ #category : 'tests' }
LocalCallTest >> testCostOnSundayAlwaysOffPeak [
    "Sunday 10am should still be off-peak"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 10 hour: 10 minute: 0 second: 0).
    self assert: call cost closeTo: 1.0
]

{ #category : 'tests' }
LocalCallTest >> testCostOnWeekdayDuringOffPeakHoursEarlyMorning [
    "Monday 6am should use off-peak rate (0.10)"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 6 minute: 0 second: 0).
    self assert: call cost closeTo: 1.0
]

{ #category : 'tests' }
LocalCallTest >> testCostOnWeekdayDuringOffPeakHoursEvening [
    "Monday 9pm should use off-peak rate (0.10)"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 21 minute: 0 second: 0).
    self assert: call cost closeTo: 1.0
]

{ #category : 'tests' }
LocalCallTest >> testCostOnWeekdayDuringPeakHours [
    "Monday 10am should use peak rate (0.20)"
    | call |
    call := LocalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0).
    self assert: call cost closeTo: 2.0
]

{ #category : 'tests' }
LocalCallTest >> testZeroDurationCallCostsZero [
    | call |
    call := LocalCall 
        duration: 0 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0).
    self assert: call cost equals: 0
]

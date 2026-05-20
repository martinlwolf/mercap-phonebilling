Class {
	#name : 'NationalCallTest',
	#superclass : 'TestCase',
	#category : 'Mercap-Billing-Tests',
	#package : 'Mercap-Billing-Tests'
}

{ #category : 'tests' }
NationalCallTest >> testCostBasedOnDestinationCityRate [
    | cordoba call |
    cordoba := City name: 'Cordoba' ratePerMinute: 0.50.
    call := NationalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0) 
        city: cordoba.
    self assert: call cost closeTo: 5.0
]

{ #category : 'tests' }
NationalCallTest >> testCostScalesWithDuration [
    | rosario shortCall longCall |
    rosario := City name: 'Rosario' ratePerMinute: 0.40.
    shortCall := NationalCall 
        duration: 5 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0) 
        city: rosario.
    longCall := NationalCall 
        duration: 20 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0) 
        city: rosario.
    self assert: longCall cost closeTo: shortCall cost * 4
]

{ #category : 'tests' }
NationalCallTest >> testDifferentCitiesYieldDifferentCosts [
    | cordoba mendoza callToCordoba callToMendoza |
    cordoba := City name: 'Cordoba' ratePerMinute: 0.50.
    mendoza := City name: 'Mendoza' ratePerMinute: 0.80.
    callToCordoba := NationalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0) 
        city: cordoba.
    callToMendoza := NationalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0) 
        city: mendoza.
    self deny: callToCordoba cost = callToMendoza cost
]

Class {
	#name : 'InternationalCallTest',
	#superclass : 'TestCase',
	#category : 'Mercap-Billing-Tests',
	#package : 'Mercap-Billing-Tests'
}

{ #category : 'tests' }
InternationalCallTest >> testCostBasedOnDestinationCountryRate [
    | brazil call |
    brazil := Country name: 'Brazil' ratePerMinute: 2.0.
    call := InternationalCall 
        duration: 5 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0) 
        country: brazil.
    self assert: call cost closeTo: 10.0
]

{ #category : 'tests' }
InternationalCallTest >> testDifferentCountriesYieldDifferentCosts [
    | brazil usa callToBrazil callToUsa |
    brazil := Country name: 'Brazil' ratePerMinute: 2.0.
    usa := Country name: 'USA' ratePerMinute: 3.5.
    callToBrazil := InternationalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0) 
        country: brazil.
    callToUsa := InternationalCall 
        duration: 10 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0) 
        country: usa.
    self assert: callToUsa cost > callToBrazil cost
]

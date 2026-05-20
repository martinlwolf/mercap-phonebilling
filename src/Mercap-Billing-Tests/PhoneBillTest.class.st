Class {
	#name : 'PhoneBillTest',
	#superclass : 'TestCase',
	#instVars : [
		'customer',
		'cordoba',
		'brazil'
	],
	#category : 'Mercap-Billing-Tests',
	#package : 'Mercap-Billing-Tests'
}

{ #category : 'running' }
PhoneBillTest >> setUp [
    super setUp.
    customer := Customer name: 'John Smith' monthlyFee: 500.
    cordoba := City name: 'Cordoba' ratePerMinute: 0.50.
    brazil := Country name: 'Brazil' ratePerMinute: 2.0
]

{ #category : 'running' }
PhoneBillTest >> testPhoneBillExcludesCallsFromOtherMonths [
    | phoneBill |
    "May call: should be included"
    customer registerCall: 
        (LocalCall 
            duration: 10 
            dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0)).
    "April call: should NOT be included"
    customer registerCall: 
        (LocalCall 
            duration: 100 
            dateTime: (DateAndTime year: 2026 month: 4 day: 4 hour: 10 minute: 0 second: 0)).
    phoneBill := PhoneBill forCustomer: customer month: 5 year: 2026.
    "Only the May call's 2.0 should count, not the April call's 20.0"
    self assert: phoneBill callsTotal closeTo: 2.0
]

{ #category : 'running' }
PhoneBillTest >> testPhoneBillSumsAllCallTypes [
    | phoneBill expectedTotal |
    "Local call: Monday 10am, 10 min -> 10 * 0.20 = 2.0"
    customer registerCall: 
        (LocalCall 
            duration: 10 
            dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0)).
    "National call to Cordoba: 5 min -> 5 * 0.50 = 2.5"
    customer registerCall: 
        (NationalCall 
            duration: 5 
            dateTime: (DateAndTime year: 2026 month: 5 day: 5 hour: 14 minute: 0 second: 0) 
            city: cordoba).
    "International call to Brazil: 3 min -> 3 * 2.0 = 6.0"
    customer registerCall: 
        (InternationalCall 
            duration: 3 
            dateTime: (DateAndTime year: 2026 month: 5 day: 6 hour: 16 minute: 0 second: 0) 
            country: brazil).
    phoneBill := PhoneBill forCustomer: customer month: 5 year: 2026.
    expectedTotal := 500 + 2.0 + 2.5 + 6.0.
    self assert: phoneBill total closeTo: expectedTotal
]

{ #category : 'running' }
PhoneBillTest >> testPhoneBillTotalEqualsMonthlyFeePlusCallsTotal [
    "Invariant: total must always equal monthlyFee + callsTotal"
    | phoneBill |
    customer registerCall: 
        (LocalCall 
            duration: 15 
            dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0)).
    customer registerCall: 
        (NationalCall 
            duration: 8 
            dateTime: (DateAndTime year: 2026 month: 5 day: 5 hour: 14 minute: 0 second: 0) 
            city: cordoba).
    phoneBill := PhoneBill forCustomer: customer month: 5 year: 2026.
    self assert: phoneBill total closeTo: customer monthlyFee + phoneBill callsTotal
]

{ #category : 'running' }
PhoneBillTest >> testPhoneBillTotalIncludesMonthlyFeePlusCalls [
    | phoneBill |
    customer registerCall: 
        (LocalCall 
            duration: 10 
            dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0)).
    "10 * 0.20 = 2.0"
    phoneBill := PhoneBill forCustomer: customer month: 5 year: 2026.
    self assert: phoneBill callsTotal closeTo: 2.0.
    self assert: phoneBill total closeTo: 502.0
]

{ #category : 'running' }
PhoneBillTest >> testPhoneBillWithNoCallsTotalsOnlyMonthlyFee [
    | phoneBill |
    phoneBill := PhoneBill forCustomer: customer month: 5 year: 2026.
    self assert: phoneBill callsTotal equals: 0.
    self assert: phoneBill total equals: 500
]

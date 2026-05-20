Class {
	#name : 'CustomerTest',
	#superclass : 'TestCase',
	#instVars : [
		'customer'
	],
	#category : 'Mercap-Billing-Tests',
	#package : 'Mercap-Billing-Tests'
}

{ #category : 'running' }
CustomerTest >> setUp [
    super setUp.
    customer := Customer name: 'John Smith' monthlyFee: 500
]

{ #category : 'tests' }
CustomerTest >> testCallsInMonthFiltersByMonth [
    | mayCall aprilCall mayCalls |
    mayCall := LocalCall 
        duration: 5 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0).
    aprilCall := LocalCall 
        duration: 5 
        dateTime: (DateAndTime year: 2026 month: 4 day: 4 hour: 10 minute: 0 second: 0).
    customer registerCall: mayCall.
    customer registerCall: aprilCall.
    mayCalls := customer callsInMonth: 5 year: 2026.
    self assert: mayCalls size equals: 1.
    self assert: (mayCalls includes: mayCall)
]

{ #category : 'tests' }
CustomerTest >> testCallsInMonthFiltersByYear [
    "Same month, different year, should not be included"
    | call2026 call2025 calls |
    call2026 := LocalCall 
        duration: 5 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0).
    call2025 := LocalCall 
        duration: 5 
        dateTime: (DateAndTime year: 2025 month: 5 day: 4 hour: 10 minute: 0 second: 0).
    customer registerCall: call2026.
    customer registerCall: call2025.
    calls := customer callsInMonth: 5 year: 2026.
    self assert: calls size equals: 1.
    self assert: (calls includes: call2026)
]

{ #category : 'tests' }
CustomerTest >> testCallsInMonthReturnsEmptyWhenNoMatch [
    customer registerCall: 
        (LocalCall 
            duration: 5 
            dateTime: (DateAndTime year: 2026 month: 4 day: 4 hour: 10 minute: 0 second: 0)).
    self assert: (customer callsInMonth: 5 year: 2026) isEmpty
]

{ #category : 'running' }
CustomerTest >> testNewCustomerHasNoCalls [
    self assert: customer calls isEmpty
]

{ #category : 'tests' }
CustomerTest >> testRegisteredCallIsStored [
    | call |
    call := LocalCall 
        duration: 5 
        dateTime: (DateAndTime year: 2026 month: 5 day: 4 hour: 10 minute: 0 second: 0).
    customer registerCall: call.
    self assert: customer calls size equals: 1.
    self assert: (customer calls includes: call)
]

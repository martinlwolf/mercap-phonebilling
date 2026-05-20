Class {
	#name : 'PhoneBill',
	#superclass : 'Object',
	#instVars : [
		'customer',
		'month',
		'year',
		'billedCalls'
	],
	#category : 'Mercap-Billing',
	#package : 'Mercap-Billing'
}

{ #category : 'as yet unclassified' }
PhoneBill class >> forCustomer: aCustomer month: aMonth year: aYear [
    ^ self new
        generateFor: aCustomer month: aMonth year: aYear;
        yourself
]

{ #category : 'as yet unclassified' }
PhoneBill >> callsTotal [
    | total |
    total := 0.
    billedCalls do: [ :call | total := total + call cost ].
    ^ total
]

{ #category : 'as yet unclassified' }
PhoneBill >> generateFor: aCustomer month: aMonth year: aYear [
    customer := aCustomer.
    month := aMonth.
    year := aYear.
    billedCalls := customer callsInMonth: month year: year
]

{ #category : 'as yet unclassified' }
PhoneBill >> print [
    | result |
    result := '========================================' , String cr.
    result := result , 'PhoneBill - ' , customer name , String cr.
    result := result , 'Period: ' , month printString , '/' , year printString , String cr.
    result := result , '----------------------------------------' , String cr.
    result := result , 'Monthly fee: $' , customer monthlyFee printString , String cr.
    result := result , 'Calls:' , String cr.
    billedCalls do: [ :call | 
        result := result , '  - ' , call description , String cr ].
    result := result , '----------------------------------------' , String cr.
    result := result , 'Calls subtotal: $' , self callsTotal printString , String cr.
    result := result , 'TOTAL: $' , self total printString , String cr.
    result := result , '========================================' , String cr.
    Transcript show: result.
]

{ #category : 'as yet unclassified' }
PhoneBill >> total [
    ^ customer monthlyFee + self callsTotal
]

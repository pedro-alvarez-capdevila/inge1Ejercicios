!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'ms 9/6/2022 19:28:39'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self execute: [customerBook addCustomerNamed: 'John Lennon'.] maxAmountOfMillisecondsItShouldTake: 50.
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ms 9/6/2022 19:30:10'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	 
	self execute: [customerBook removeCustomerNamed: paulMcCartney.] maxAmountOfMillisecondsItShouldTake: 100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ms 9/6/2022 19:58:26'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''. 
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ms 9/6/2022 19:58:22'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'. 
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pedro 9/6/2022 21:02:05'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.

	self assertCustomersAmountOf: customerBook activeAmount: 0 suspendedAmount: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pedro 9/6/2022 21:02:16'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomersAmountOf: customerBook activeAmount: 0 suspendedAmount: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ms 9/6/2022 20:16:01'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertCustomerCannotBeSuspended: 'George Harrison' inACustomerBook: customerBook withARegisteredCustomer: johnLennon.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ms 9/6/2022 20:16:44'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertCustomerCannotBeSuspended: johnLennon inACustomerBook: customerBook withARegisteredCustomer: johnLennon.
! !


!CustomerBookTest methodsFor: 'auxiliar methods' stamp: 'ms 9/6/2022 20:12:42'!
assertCustomerCannotBeSuspended: aCustomerToSuspend inACustomerBook: aCustomerBook withARegisteredCustomer: aRegisteredCustomer

	[ aCustomerBook suspendCustomerNamed: aCustomerToSuspend.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: aRegisteredCustomer) ]! !

!CustomerBookTest methodsFor: 'auxiliar methods' stamp: 'pedro 9/6/2022 21:00:57'!
assertCustomersAmountOf: aCustomerBook activeAmount: amountOfActiveCustomers suspendedAmount: amountOfSuspendedCustomers

	self assert: aCustomerBook numberOfActiveCustomers equals: amountOfActiveCustomers.
	self assert: aCustomerBook numberOfSuspendedCustomers equals: amountOfSuspendedCustomers.
	self assert: aCustomerBook numberOfCustomers equals: amountOfActiveCustomers + amountOfSuspendedCustomers .! !

!CustomerBookTest methodsFor: 'auxiliar methods' stamp: 'ms 9/6/2022 19:25:12'!
execute: aClosure maxAmountOfMillisecondsItShouldTake: anAmountOfMilliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
	  
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (anAmountOfMilliseconds * millisecond)! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'pedro 9/6/2022 20:45:39'!
includesCustomerNamed: aName

	^ (self isActiveCustomer: aName) or: [self isASuspendedCustomer: aName].! !

!CustomerBook methodsFor: 'testing' stamp: 'pedro 9/6/2022 20:45:39'!
isASuspendedCustomer: aName

	^ suspended includes: aName.! !

!CustomerBook methodsFor: 'testing' stamp: 'pedro 9/6/2022 20:43:53'!
isActiveCustomer: aName

	^ (active includes: aName)! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !

!CustomerBook methodsFor: 'testing' stamp: 'pedro 9/6/2022 20:52:59'!
validateIsNotACustomer: aName

	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	! !

!CustomerBook methodsFor: 'testing' stamp: 'pedro 9/6/2022 20:49:25'!
validateNameIsNotEmpty: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'pedro 9/6/2022 20:53:15'!
addCustomerNamed: aName

	self validateNameIsNotEmpty: aName.
	self validateIsNotACustomer: aName.
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'pedro 9/6/2022 20:54:02'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'pedro 9/6/2022 20:34:26'!
removeCustomerNamed: aName 

	active remove: aName ifAbsent: [ suspended remove: aName ifAbsent: [^ NotFound signal.]].
 
	^ aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'pedro 9/6/2022 20:55:15'!
suspendCustomerNamed: aName 
	
	(self isActiveCustomer: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !

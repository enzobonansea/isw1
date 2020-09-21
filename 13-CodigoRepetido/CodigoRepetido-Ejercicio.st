!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'eb 9/19/2020 21:14:13'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertClosureExecution: [customerBook addCustomerNamed: 'John Lennon'] takesLessThan: 50 inUnit: millisecond .
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'eb 9/19/2020 21:22:26'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook createCustomerBookWithOneCustomerCalled: paulMcCartney.
	  
	self assertClosureExecution: [customerBook removeCustomerNamed: paulMcCartney]  
		takesLessThan: 100 inUnit: millisecond .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'eb 9/19/2020 20:00:19'!
test03CanNotAddACustomerWithEmptyName 

	| emptyCustomerBook |
			
	emptyCustomerBook := CustomerBook new.

	[ emptyCustomerBook addCustomerNamed: ''. self fail ] 
		on: Error 
		do: [ :anError | self assertErrorIsForEmptyName: anError andCustomerBookStillsEmpty: emptyCustomerBook ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'eb 9/19/2020 21:22:30'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := CustomerBook createCustomerBookWithOneCustomerCalled: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ]
		on: NotFound 
		do: [ self assertCustomerBook: customerBook hasOneCustomerWhoseNameIs: johnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'eb 9/19/2020 21:22:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul Mc Cartney'.
	customerBook := CustomerBook createCustomerBookWithOneSuspendedCustomerCalled: paulMcCartney.
	
	self assertCustomerBookHasOnlyOneSuspendedCustomer: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'eb 9/19/2020 21:22:57'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook createCustomerBookWithOneSuspendedCustomerCalled: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBookIsEmpty: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'eb 9/19/2020 21:22:33'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook createCustomerBookWithOneCustomerCalled: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ self assertCustomerBook: customerBook hasOneCustomerWhoseNameIs: johnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'eb 9/19/2020 21:23:03'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook createCustomerBookWithOneSuspendedCustomerCalled: johnLennon .
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ self assertCustomerBook: customerBook hasOneCustomerWhoseNameIs: johnLennon ]
! !


!CustomerBookTest methodsFor: 'private' stamp: 'eb 9/19/2020 21:15:11'!
assertClosureExecution: aBlock takesLessThan: quantity inUnit: unit 

	| millisecondsBeforeRunning millisecondsAfterRunning |
		
	millisecondsBeforeRunning := Time millisecondClockValue * unit.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * unit.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (quantity * unit)! !

!CustomerBookTest methodsFor: 'private' stamp: 'eb 9/19/2020 21:26:34'!
assertCustomerBook: customerBook hasOneCustomerWhoseNameIs: customerName

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: customerName)! !

!CustomerBookTest methodsFor: 'private' stamp: 'eb 9/19/2020 21:26:44'!
assertCustomerBookHasOnlyOneSuspendedCustomer: customerBook

	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'private' stamp: 'eb 9/19/2020 21:26:49'!
assertCustomerBookIsEmpty: customerBook

	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers! !

!CustomerBookTest methodsFor: 'private' stamp: 'eb 9/19/2020 21:26:54'!
assertErrorIsForEmptyName: anError andCustomerBookStillsEmpty: customerBook

	self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty ! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'ja 9/21/2020 19:17:26'!
addCustomerNamed: potentialCustomerName

	potentialCustomerName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: potentialCustomerName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: potentialCustomerName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ja 9/21/2020 18:43:08'!
numberOfCustomers
	
	^(self numberOfActiveCustomers) + (self numberOfSuspendedCustomers).! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ja 9/21/2020 19:16:47'!
removeCustomerNamed: customerName 
	
	^ active remove: customerName ifAbsent: [ 
		suspended remove: customerName ifAbsent: [ 
			  NotFound signal ]
		]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'ja 9/21/2020 19:17:06'!
suspendCustomerNamed: customerName 
	
	(active includes: customerName) ifFalse: [^CantSuspend signal].	
	active remove: customerName.
	suspended add: customerName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !


!CustomerBook class methodsFor: 'creation' stamp: 'eb 9/19/2020 21:27:20'!
createCustomerBookWithOneCustomerCalled: customerName

	| customerBook |
	
	customerBook := self new.
	customerBook addCustomerNamed: customerName.
	
	^customerBook.! !

!CustomerBook class methodsFor: 'creation' stamp: 'eb 9/19/2020 21:27:24'!
createCustomerBookWithOneSuspendedCustomerCalled: customerName

	| customerBook |
	
	customerBook := self createCustomerBookWithOneCustomerCalled: customerName.
	customerBook suspendCustomerNamed: customerName.
	
	^customerBook.! !

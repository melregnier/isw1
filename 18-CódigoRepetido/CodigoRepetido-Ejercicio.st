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

!CustomerBookTest methodsFor: 'testing' stamp: 'mr 9/2/2019 20:01:00'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self closure: [ customerBook addCustomerNamed: 'john Lennon' ] shouldNotTakeMoreMillisecondsThan: 50
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'mr 9/2/2019 20:49:22'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.

	self closure: [ customerBook removeCustomerNamed: paulMcCartney. ] shouldNotTakeMoreMillisecondsThan: 100.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'mr 9/2/2019 20:34:07'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self closure: [ customerBook addCustomerNamed: ''. ] shouldFailWith: Error andDo: 
	[ :anError |
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'mr 9/2/2019 20:34:57'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self closure: [ customerBook removeCustomerNamed: 'Paul McCartney'. ] shouldFailWith: NotFound andDo: 
	[ :anError |
		self assert: customerBook numberOfCustomers = 1. 
		self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'mr 9/2/2019 20:11:26'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook hasActiveCustomers: 0 andSuspendedCustomers: 1.	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'mr 9/2/2019 20:11:41'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook hasActiveCustomers: 0 andSuspendedCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'mr 9/2/2019 20:46:18'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self closure: [ customerBook suspendCustomerNamed: 'Paul McCartney'. ] shouldFailWith: CantSuspend andDo: [ 		:anError | 
			self assertCustomerBook: customerBook includes: johnLennon andHasNumberOfCustomers: 1]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'mr 9/2/2019 20:47:41'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.

	self closure: [ customerBook suspendCustomerNamed: johnLennon. ] shouldFailWith: CantSuspend andDo: [ 		:anError | 
			self assertCustomerBook: customerBook includes: johnLennon andHasNumberOfCustomers: 1]! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'mr 9/2/2019 20:51:46'!
assertCustomerBook: aCustomerBook hasActiveCustomers: numberOfActiveCustomers andSuspendedCustomers: numberOfSuspendedCustomers
 	| totalCustomers |
	
	totalCustomers := numberOfActiveCustomers + numberOfSuspendedCustomers. 
	
	self assert: numberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: aCustomerBook numberOfCustomers.
	! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'mr 9/2/2019 20:45:04'!
assertCustomerBook: aCustomerBook includes: nameOfCustomer andHasNumberOfCustomers: numberOfCustomers

	self assert: aCustomerBook numberOfCustomers = numberOfCustomers .
	self assert: (aCustomerBook includesCustomerNamed: nameOfCustomer )! !


!CustomerBookTest methodsFor: 'time measuring' stamp: 'mr 9/2/2019 20:00:40'!
closure: aClosure shouldNotTakeMoreMillisecondsThan: milliseconds 
	
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (milliseconds * millisecond)! !


!CustomerBookTest methodsFor: 'fail' stamp: 'mr 9/2/2019 20:31:27'!
closure: closureToFail shouldFailWith: error andDo: closureAfterFail
 	[ closureToFail value.
	  self fail ]
		on: error
		do: closureAfterFail! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'customer management' stamp: 'mr 9/2/2019 18:48:14'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'mr 9/3/2019 14:56:42'!
removeCustomerNamed: aName 
 	
	| customerHasTheSameName |
	
	customerHasTheSameName  :=  [:customer |  aName = customer].
	
	(self removeFrom: active if: customerHasTheSameName) ifTrue: [ ^aName ].
	(self removeFrom: suspended if: customerHasTheSameName) ifTrue: [ ^aName ].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'errors' stamp: 'mr 9/3/2019 15:39:46'!
signalClassError: classError

	self error: (classError asMessage sendTo: self class)
! !

!CustomerBook methodsFor: 'errors' stamp: 'mr 9/3/2019 15:40:05'!
signalCustomerAlreadyExists 
	
	self signalClassError: #customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'errors' stamp: 'mr 9/3/2019 15:40:17'!
signalCustomerNameCannotBeEmpty 
	
	self signalClassError: #customerCanNotBeEmptyErrorMessage.
! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'removing' stamp: 'mr 9/3/2019 15:40:55'!
removeFrom: aCollection if: conditionToRemove
	
	aCollection do: [:each | (conditionToRemove value: each) ifTrue: [aCollection remove: each. ^ true]].
	^ false.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !

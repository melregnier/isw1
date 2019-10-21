!classDefinition: #BankEntityTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #BankEntityTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
BankEntityTest subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing - private' stamp: 'DR 10/18/2019 20:33:52'!
addAccountWith: anAmount toPortfolio: aPortfolio 
	
	| account |

	account := ReceptiveAccount  new.
	Deposit register: anAmount on: account.
	
	aPortfolio add: account.
	^aPortfolio .
	! !

!PortfolioTest methodsFor: 'testing - private' stamp: 'DR 10/18/2019 21:38:23'!
addPortfolioWithAccountWith: anAmount toPortfolio: aPortfolio
	
	| portfolioToInclude |

	portfolioToInclude := Portfolio new.
	self addAccountWith: anAmount toPortfolio: portfolioToInclude .
	aPortfolio add: portfolioToInclude.
	^aPortfolio.
	! !


!PortfolioTest methodsFor: 'tests' stamp: 'D 10/17/2019 18:50:52'!
test01EmptyPortfolioHasZeroBalance
	
	| emptyPortfolio |
	
	emptyPortfolio := Portfolio new.
	
	self assert: emptyPortfolio  balance isZero.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DR 10/18/2019 20:34:20'!
test02PortfolioWithOneAccountReturnsBalanceOfThatAccount
	
	| portfolio |

	portfolio := Portfolio new.

	self addAccountWith: 100 toPortfolio: portfolio.
	
	self assert: portfolio  balance equals: 100.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mr 10/21/2019 14:42:20'!
test03PortfolioWithManyAccountsReturnsBalanceOfAllAccounts
	
	| portfolio |
	
	portfolio := Portfolio new.
	self addAccountWith: 100 toPortfolio: portfolio.
	self addAccountWith: 50 toPortfolio: portfolio.
		
	self assert: portfolio  balance equals: 150.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DR 10/18/2019 21:39:17'!
test04PortfolioWithAPortfolioHasBalanceOfThePortfolio
	
	| portfolio |

	portfolio := Portfolio new.
	
	self addPortfolioWithAccountWith: 100 toPortfolio: portfolio.
		
	self assert: portfolio balance equals: 100.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mr 10/21/2019 14:42:38'!
test05PortfolioWithManyPortfoliosHasBalanceOfAllPortfolios
	
	| portfolio portfolioToInclude anotherPortfolioToInclude |
	
	portfolioToInclude := Portfolio new.
	anotherPortfolioToInclude := Portfolio new.
	
	self addPortfolioWithAccountWith: 100 toPortfolio: portfolioToInclude.
	self addPortfolioWithAccountWith: 50 toPortfolio: anotherPortfolioToInclude .
	
	portfolio := Portfolio new.
	portfolio add: portfolioToInclude.
	portfolio add: anotherPortfolioToInclude.
		
	self assert: portfolio balance equals: 150.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'D 10/17/2019 19:51:13'!
test06EmptyPortfolioHasNoTransactions
	
	| portfolio |
	
	portfolio := Portfolio new.
		
	self assert: portfolio transactions isEmpty.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DR 10/18/2019 21:42:25'!
test07PortfolioWithOneAccountHasTransactionsOfThatAccount

	| portfolio account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: portfolio transactions equals: account transactions .
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mr 10/21/2019 15:12:40'!
test08PortfolioWithManyAccountsHasTransactionsOfAllAccounts

	| portfolio anAccount anotherAccount |
	anAccount := ReceptiveAccount  new.
	Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount  new.
	Deposit register: 50 on: anotherAccount.
	
	portfolio := Portfolio new.
	portfolio add: anAccount.
	portfolio add: anotherAccount.
	
	self assert: (portfolio transactions includesAllOf: anAccount transactions).
	self assert: (portfolio transactions includesAllOf: anotherAccount transactions).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mr 10/21/2019 15:13:45'!
test09PortfolioWithOnePortfolioHasTransactionsOfThePortfolio

	| portfolio anAccount portfolioToInclude |
	anAccount := ReceptiveAccount  new.
	Deposit register: 100 on: anAccount.
	
	portfolioToInclude := Portfolio new.
	portfolioToInclude add: anAccount.
	
	portfolio := Portfolio new.
	portfolio add: portfolioToInclude.
	
	self assert: (portfolio transactions includesAllOf: portfolioToInclude transactions).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'D 10/17/2019 20:36:56'!
test10EmptyPortfolioHasNoRegisteredTransactions

	| portfolio anAccount aTransaction |
	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 100 on: anAccount.
	
	portfolio := Portfolio new.

	
	self deny: (portfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'mr 10/21/2019 14:48:01'!
test11PortfolioWithAccountAndPortfolioHasRegisteredTheirTransactions

	| portfolio anotherPortfolio anAccount anotherAccount aTransaction anotherTransaction |
	
	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount  new.
	anotherTransaction := Deposit register: 150 on: anotherAccount.
	
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: anotherAccount.
	
	portfolio := Portfolio new.
	portfolio add: anAccount.
	portfolio add: anotherPortfolio.
	
	self assert: (portfolio hasRegistered: aTransaction).
	self assert: (portfolio hasRegistered: anotherTransaction ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DR 10/18/2019 21:45:16'!
test12AddingAnAccountToAPortfolioThatAlreadyHasItRaisesError

	| portfolio anAccount |
	anAccount := ReceptiveAccount  new.
	Deposit register: 100 on: anAccount.
	
	portfolio := Portfolio new.
	portfolio add: anAccount .
	
	self should: [ portfolio add: anAccount. ]
	       raise: Error - MessageNotUnderstood
		 withMessageText: Portfolio cannotAddAnExistentAccountError.
	
	self assert: portfolio balance equals: 100.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'mr 10/18/2019 18:54:19'!
test13AddingToAnEmptyPortfolioRegisteredInTwoPortfoliosAnAccountRegisteredInOneOfThemRaisesError

	| portfolio anAccount anotherAccount anotherPortfolio emptyPortfolio |

	anAccount := ReceptiveAccount  new.
	Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount  new.
	Deposit register: 150 on: anotherAccount.
	
	portfolio := Portfolio new.
	portfolio add: anAccount.
	
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: anotherAccount.
	
	emptyPortfolio := Portfolio new.
	
	portfolio add: emptyPortfolio.
	anotherPortfolio add: emptyPortfolio.
	
	self should: [ emptyPortfolio add: anAccount. ]
	       raise: Error - MessageNotUnderstood
		 withMessageText: Portfolio cannotAddAnExistentAccountError.
	
	self assert: emptyPortfolio balance equals: 0.	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DR 10/18/2019 20:04:33'!
test14APortfolioCannotIncludeAndHimselfShouldRaiseError

	| portfolio anAccount |

	anAccount := ReceptiveAccount  new.
	Deposit register: 100 on: anAccount.
	
	portfolio := Portfolio new.
	portfolio add: anAccount.
	
	self should: [ portfolio add: portfolio. ]
	       raise: Error - MessageNotUnderstood
		 withMessageText: Portfolio cannotAddAnExistentAccountError.
	
	self assert: portfolio balance equals: 100.	! !

!PortfolioTest methodsFor: 'tests' stamp: 'DR 10/18/2019 20:05:33'!
test15APortfolioWithAnAccountCannotAddAnotherPortfolioWithTheSameAccountAndShouldRaiseError

	| portfolio anAccount anotherPortfolio |

	anAccount := ReceptiveAccount  new.
	Deposit register: 100 on: anAccount.
	
	portfolio := Portfolio new.
	portfolio add: anAccount.
	
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: anAccount.
	
	self should: [ portfolio add: anotherPortfolio. ]
	       raise: Error - MessageNotUnderstood
		 withMessageText: Portfolio cannotAddAnExistentAccountError.
	
	self assert: portfolio balance equals: 100.	! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
BankEntityTest subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 10/21/2019 15:17:55'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 10/21/2019 15:17:35'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'mr 10/21/2019 15:31:07'!
valueForBalance

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'mr 10/21/2019 15:30:26'!
valueForBalance

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'mr 10/21/2019 15:30:45'!
valueForBalance

	^ value negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankEntity category: #'Portfolio-Ejercicio'!
Object subclass: #BankEntity
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankEntity methodsFor: 'operations - private' stamp: 'mr 10/18/2019 18:53:35'!
addParent: aParent

	parents add: aParent .! !


!BankEntity methodsFor: 'testing - private' stamp: 'mr 10/21/2019 15:36:02'!
hasEntitiesInCommonWith: anElement

	self subclassResponsibility .! !

!BankEntity methodsFor: 'testing - private' stamp: 'mr 10/19/2019 00:14:37'!
includes: anElement

	self subclassResponsibility .! !


!BankEntity methodsFor: 'testing' stamp: 'mr 10/19/2019 00:15:24'!
hasRegistered: aTransaction

	self subclassResponsibility.! !


!BankEntity methodsFor: 'accessing' stamp: 'mr 10/19/2019 00:15:10'!
balance

	self subclassResponsibility.! !

!BankEntity methodsFor: 'accessing' stamp: 'mr 10/19/2019 00:15:05'!
transactions

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
BankEntity subclass: #Portfolio
	instanceVariableNames: 'entities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'operations' stamp: 'mr 10/21/2019 15:20:31'!
add: anEntityToAdd
	
	self assertIfIncludes: anEntityToAdd.
	
	anEntityToAdd addParent: self.
	entities add: anEntityToAdd. 
	

! !


!Portfolio methodsFor: 'accessing' stamp: 'mr 10/21/2019 15:21:03'!
balance
	
	^ (entities sum: [ :anEntity | anEntity balance ] ifEmpty: [ 0 ]).! !

!Portfolio methodsFor: 'accessing' stamp: 'mr 10/21/2019 15:28:51'!
transactions
	
	^ entities inject: OrderedCollection new into: [ :collectionOfTransactions :anEntity | collectionOfTransactions addAllLast: (anEntity transactions); yourself ].
! !


!Portfolio methodsFor: 'initialization' stamp: 'mr 10/21/2019 15:19:11'!
initialize

	entities := OrderedCollection new.
	parents := OrderedCollection new.
! !


!Portfolio methodsFor: 'testing' stamp: 'mr 10/18/2019 23:47:50'!
hasRegistered: aTransaction 
	
	^ self transactions includes: aTransaction .! !


!Portfolio methodsFor: 'accessing - private' stamp: 'mr 10/21/2019 15:25:13'!
roots

	| roots |
	
	roots := OrderedCollection new.
	parents isEmpty ifTrue: [ 
		roots add: self.
		^ roots ].
	
	parents inject: roots
			 into: [ :collectionOfRoots :aParent | collectionOfRoots addAllLast: (aParent roots); yourself. ].
	
	^ roots.
! !


!Portfolio methodsFor: 'asserts - private' stamp: 'mr 10/21/2019 15:36:02'!
assertIfIncludes: anEntityToAdd.
	
	self roots detect:   [ :aRoot | aRoot hasEntitiesInCommonWith: anEntityToAdd. ] 
		  	    ifNone:   [ ^ self. ].
	
	self error: self class cannotAddAnExistentAccountError.	
	

! !


!Portfolio methodsFor: 'testing - private' stamp: 'mr 10/21/2019 15:36:02'!
hasEntitiesInCommonWith: anEntityToInclude

	^ (anEntityToInclude includes: self) or: [ entities anySatisfy: [ :anEntity | anEntity hasEntitiesInCommonWith: anEntityToInclude ] ].
! !

!Portfolio methodsFor: 'testing - private' stamp: 'mr 10/21/2019 15:22:00'!
includes: anEntityToInclude

	^ self = anEntityToInclude or: [ entities anySatisfy: [:anEntity | anEntity includes: anEntityToInclude ] ].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mr 10/18/2019 17:57:58'!
cannotAddAnExistentAccountError

	 ^ 'You cannot add an already existent account'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
BankEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'mr 10/18/2019 18:25:20'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'D 10/17/2019 19:44:24'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'mr 10/21/2019 15:18:18'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'mr 10/21/2019 15:30:45'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueForBalance ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing - private' stamp: 'mr 10/21/2019 15:36:02'!
hasEntitiesInCommonWith: anElementToInclude

	^ (anElementToInclude includes: self) or: [ self includes: anElementToInclude ].

	! !

!ReceptiveAccount methodsFor: 'testing - private' stamp: 'mr 10/18/2019 23:35:33'!
includes: anElementToInclude

	^ self = anElementToInclude.

	! !

!classDefinition: #CartTest category: #TusLibros stamp: 'dr 11/7/2019 19:08:47'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'dr 11/4/2019 18:41:30'!
test09EmptyCartHasTotalCostZero
	| cart |
	
	cart := self createCart.
	
	self assert: (cart totalCost) isZero.! !

!CartTest methodsFor: 'tests' stamp: 'dr 11/4/2019 18:44:06'!
test10CartTotalCostEqualTotalOfItems
	| cart |
	
	cart := self createCart.
	cart add: self itemSellByTheStore .
	
	self assert: (cart totalCost) equals: self priceForItemSellByStore.! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'dr 11/4/2019 18:49:23'!
defaultCatalog
	
	^ Dictionary new add: (Association key: self itemSellByTheStore value: self priceForItemSellByStore); yourself.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !

!CartTest methodsFor: 'support' stamp: 'dr 11/4/2019 18:44:37'!
priceForItemSellByStore
	
	^ 5 * peso.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'dr 11/7/2019 19:08:47'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'dr 11/4/2019 19:18:51'!
aValidCreditCard 

	^ CreditCard number: 1234567890123456 expirationMonthYear: self validExpirationMonthYear owner: 'Name MiddleName Surname'.! !

!CashierTest methodsFor: 'support' stamp: 'dr 11/4/2019 20:04:28'!
anExpiredCreditCard

	^ CreditCard number: 1111222233334444 expirationMonthYear: self anExpiredMonthYear owner: 'NotCool Owner'.! !

!CashierTest methodsFor: 'support' stamp: 'dr 11/4/2019 19:10:45'!
anItemSellByTheStore

	^ 'validItem'.! !

!CashierTest methodsFor: 'support' stamp: 'dr 11/4/2019 19:11:09'!
defaultCart

	^ self emptyCart add: self anItemSellByTheStore; yourself.
	! !

!CashierTest methodsFor: 'support' stamp: 'dr 11/6/2019 17:01:00'!
defaultCashier

	^ Cashier for: self defaultCart.! !

!CashierTest methodsFor: 'support' stamp: 'dr 11/4/2019 19:09:03'!
defaultCatalog

	^ Dictionary new add: (Association key: 'validItem' value: 5 * peso); yourself.! !

!CashierTest methodsFor: 'support' stamp: 'dr 11/4/2019 19:09:29'!
emptyCart

	^ Cart acceptingItemsOf: self defaultCatalog.! !

!CashierTest methodsFor: 'support' stamp: 'dr 11/4/2019 19:56:16'!
priceForItemSellByStore
	
	^ 5 * peso.! !


!CashierTest methodsFor: 'date support' stamp: 'dr 11/4/2019 20:04:07'!
anExpiredMonthYear

	^ July ofYear: (GregorianYear number: 2018).! !

!CashierTest methodsFor: 'date support' stamp: 'dr 11/6/2019 16:51:43'!
checkOutDate

	^ FixedGregorianDate yearNumber: 2019 monthNumber: 11 dayNumber: 04.
! !

!CashierTest methodsFor: 'date support' stamp: 'dr 11/4/2019 19:18:31'!
validExpirationMonthYear 

	^ March ofYear: (GregorianYear number: 2020)! !


!CashierTest methodsFor: 'tests' stamp: 'dr 11/4/2019 19:46:52'!
test01CashierForAnEmptyCartRaiseAnError

	self should: [ Cashier for: self emptyCart. ]
		  raise: Error - MessageNotUnderstood
		  withMessageText: Cashier canNotCreateCashierForAnEmptyCartError.
! !

!CashierTest methodsFor: 'tests' stamp: 'dr 11/6/2019 17:02:33'!
test02CheckOutOfCartWithValidCardReturnsTotalCostOfCartAndRegistersSale

	| cashier aSalesBook aMerchantProcessorSimulator merchantProcessorExecuted |
	
	aSalesBook := OrderedCollection new.

	cashier := self defaultCashier.

	aMerchantProcessorSimulator := MerchantProcessorSimulator doing: [ :anAmount :aCreditCard | merchantProcessorExecuted := true ].

	self assert: (cashier checkOutFrom: self aValidCreditCard registerIn: aSalesBook at: self checkOutDate for: aMerchantProcessorSimulator) equals: self priceForItemSellByStore .
	self assert: aSalesBook last equals: cashier.
	self assert: merchantProcessorExecuted.! !

!CashierTest methodsFor: 'tests' stamp: 'dr 11/6/2019 17:03:00'!
test03CheckOutOfCartWithCardExpiredRaiseCardExpiredError

	| aSalesBook aMerchantProcessorSimulator merchantProcessorExecuted |
	
	aSalesBook := OrderedCollection new.
	merchantProcessorExecuted := false.

	aMerchantProcessorSimulator := MerchantProcessorSimulator doing: [ :anAmount :aCreditCard | merchantProcessorExecuted := true ]. 

	self should: [ self defaultCashier checkOutFrom: self anExpiredCreditCard registerIn: aSalesBook at: self checkOutDate for: aMerchantProcessorSimulator  ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: Cashier expiratedCreditCardErrorMessage .

	self assert: aSalesBook isEmpty.
	self deny: merchantProcessorExecuted.! !

!CashierTest methodsFor: 'tests' stamp: 'dr 11/6/2019 17:03:23'!
test04CheckOutOfCartWhenMerchantProcessorRaisesErrorRaisesTheSameError

	| aSalesBook aFailingMerchantProcessorSimulator |

	aSalesBook := OrderedCollection new.

	aFailingMerchantProcessorSimulator := MerchantProcessorSimulator doing: [ :anAmount :aCreditCard |
										   	self error: 'Could not debit ', anAmount printString, ' from credit card'.
										   ]. 

	self should: [ self defaultCashier checkOutFrom: self aValidCreditCard registerIn: aSalesBook at: self checkOutDate for: aFailingMerchantProcessorSimulator ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: 'Could not debit ', self priceForItemSellByStore printString, ' from credit card'.

	self assert: aSalesBook isEmpty.! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'dr 11/7/2019 19:08:47'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'dr 11/4/2019 20:28:52'!
test01CanNotCreateACreditCardWithInvalidLength

	self should: [ CreditCard number: 111122223333444 expirationMonthYear: (March ofYear: (GregorianYear number: 2019)) owner: 'Yo' ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: CreditCard invalidLengthErrorMessage.! !

!CreditCardTest methodsFor: 'tests' stamp: 'dr 11/5/2019 18:20:29'!
test02CreditCardKnowsItsInformation

	| aCreditCard |
	aCreditCard := CreditCard number: 1111222233334444 expirationMonthYear: (March ofYear: (GregorianYear number: 2019)) owner: 'Yo'.
	
	self assert: aCreditCard number equals: 1111222233334444.
	self assert: aCreditCard owner equals: 'Yo'.
	self assert: aCreditCard expirationMonthOfYear equals: (March ofYear: (GregorianYear number: 2019)).! !

!CreditCardTest methodsFor: 'tests' stamp: 'dr 11/6/2019 15:22:50'!
test03CreditCardIsExpiredAtDatePosteriorToCreditCardExpirationMonthOfYear

	| aCreditCard aPosteriorDate |
	aCreditCard := CreditCard number: 1111222233334444 expirationMonthYear: (March ofYear: (GregorianYear number: 2019)) owner: 'Yo'.
	aPosteriorDate := FixedGregorianDate yearNumber: 2020 monthNumber: 2 dayNumber: 20.
	
	self assert: (aCreditCard isExpiredAt: aPosteriorDate).! !

!CreditCardTest methodsFor: 'tests' stamp: 'dr 11/6/2019 15:24:44'!
test04CreditCardIsNotExpiredAtDatePreviousToCreditCardExpirationMonthOfYear

	| aCreditCard aPreviousDate |
	aCreditCard := CreditCard number: 1111222233334444 expirationMonthYear: (March ofYear: (GregorianYear number: 2019)) owner: 'Yo'.
	aPreviousDate := FixedGregorianDate yearNumber: 2018 monthNumber: 2 dayNumber: 20.
	
	self deny: (aCreditCard isExpiredAt: aPreviousDate).! !


!classDefinition: #Cart category: #TusLibros stamp: 'dr 11/7/2019 19:08:47'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !

!Cart methodsFor: 'error messages' stamp: 'dr 11/4/2019 18:53:47'!
priceFor: anItem

	^ catalog at: anItem.! !


!Cart methodsFor: 'assertions' stamp: 'dr 11/4/2019 18:46:53'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'dr 11/4/2019 18:51:35'!
initializeAcceptingItemsOf: aCatalog

	total := 0 * peso.
	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'dr 11/4/2019 19:45:27'!
isEmpty
	
	^ items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'dr 11/4/2019 18:53:02'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	1 to: aQuantity do: [ :aNumber | items add: anItem.
										 total := total + (self priceFor: anItem).
		 ]! !


!Cart methodsFor: 'accessing' stamp: 'sjd 11/2/2019 17:35:48'!
forEachItemDo: aClosureToRun 
	
	items do: aClosureToRun.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'dr 11/4/2019 19:23:23'!
checkOutFor: aCreditCard 
	self shouldBeImplemented.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'dr 11/4/2019 18:51:05'!
totalCost
	
	^ total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'dr 11/7/2019 19:08:48'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'dr 11/7/2019 19:08:48'!
Object subclass: #Cashier
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'dr 11/4/2019 20:08:12'!
assertCreditCardNotExpiredFor: aCreditCard at: aCheckOutDate

	(aCreditCard isExpiredAt: aCheckOutDate) ifTrue: [self error: self class expiratedCreditCardErrorMessage ].
	! !


!Cashier methodsFor: 'check out' stamp: 'dr 11/6/2019 16:29:58'!
checkOutFrom: aCreditCard registerIn: aSalesBook at: aDate for: aMerchantProcessor 

	self assertCreditCardNotExpiredFor: aCreditCard at: aDate.

	aMerchantProcessor debit: cart totalCost from: aCreditCard .
	
	aSalesBook add: self.
	
	^ cart totalCost.
	
	! !


!Cashier methodsFor: 'initialization' stamp: 'dr 11/4/2019 19:45:10'!
initializeFor: aCart
	
	aCart isEmpty ifTrue: [ self error: self class canNotCreateCashierForAnEmptyCartError ].
	
	cart := aCart.  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'dr 11/7/2019 19:08:48'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'sjd 11/2/2019 19:39:41'!
expiratedCreditCardErrorMessage
	
	^ 'Expirated credit card. Please verify your information or try with another credit card.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'sjd 11/2/2019 19:36:47'!
invalidLengthOfCreditCardErrorMessage
	
	^ 'Invalid length of credit card. Please verify your information or try with another credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'sjd 11/2/2019 17:30:40'!
itemNotValidErrorMessageFor: anItem

	^ anItem printString, ' is not registered in the price list'! !


!Cashier class methodsFor: 'instance creation' stamp: 'dr 11/4/2019 19:26:47'!
for: aCart

	^ self new initializeFor: aCart.! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'dr 11/4/2019 19:44:04'!
canNotCreateCashierForAnEmptyCartError
	
	^ 'You can not check out an empty cart.'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'dr 11/7/2019 19:08:48'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationMonthYear owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'dr 11/4/2019 20:31:24'!
initializeForNumber: aCreditCardNumber expirationMonthYear: anExpirationMonthOfYear owner: anOwner 

	aCreditCardNumber decimalDigitLength = 16 ifFalse: [ self error: self class invalidLengthErrorMessage . ]. 

	number := aCreditCardNumber.
	expirationMonthYear := anExpirationMonthOfYear.
	owner := anOwner.! !


!CreditCard methodsFor: 'testing' stamp: 'dr 11/6/2019 15:25:26'!
isExpiredAt: aDate

	^ expirationMonthYear < (GregorianMonthOfYear year: aDate year month: aDate month).

	
	
	! !


!CreditCard methodsFor: 'accessing' stamp: 'dr 11/5/2019 18:21:50'!
expirationMonthOfYear
	
	^ expirationMonthYear.! !

!CreditCard methodsFor: 'accessing' stamp: 'dr 11/5/2019 18:21:01'!
number
	
	^number! !

!CreditCard methodsFor: 'accessing' stamp: 'dr 11/5/2019 18:21:23'!
owner
	
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'dr 11/7/2019 19:08:48'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'dr 11/4/2019 19:21:57'!
number: aCreditCardNumber expirationMonthYear: anExpirationMonthOfYear owner: anOwner
	
	^self new initializeForNumber: aCreditCardNumber expirationMonthYear: anExpirationMonthOfYear owner: anOwner.! !


!CreditCard class methodsFor: 'as yet unclassified' stamp: 'dr 11/4/2019 20:27:55'!
invalidLengthErrorMessage
	
	'The length of the number should be 16 (sixteen) digits.'! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros stamp: 'dr 11/7/2019 19:08:48'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitFromClosure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'dr 11/6/2019 16:19:29'!
initializeDoing: aClosureToRun

	debitFromClosure := aClosureToRun .! !


!MerchantProcessorSimulator methodsFor: 'debit from' stamp: 'dr 11/6/2019 16:36:34'!
debit: anAmount from: aCreditCard

	^ debitFromClosure value: anAmount value: aCreditCard .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros stamp: 'dr 11/7/2019 19:08:48'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'dr 11/6/2019 16:18:35'!
doing: aClosureToRun

	^ self new initializeDoing: aClosureToRun .! !
